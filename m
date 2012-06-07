From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/2] ALSA: hda - reduce msleep time if EPSS
 power states supported
Date: Thu, 07 Jun 2012 09:15:11 +0200
Message-ID: <4FD054FF.1090907@canonical.com>
References: <1338991369-31656-1-git-send-email-xingchao.wang@intel.com>
	<1338991369-31656-2-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id B1E26244EB
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 09:15:13 +0200 (CEST)
In-Reply-To: <1338991369-31656-2-git-send-email-xingchao.wang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wang Xingchao <xingchao.wang@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, wangxingchao2011@gmail.com
List-Id: alsa-devel@alsa-project.org

On 06/06/2012 04:02 PM, Wang Xingchao wrote:
> if EPSS supported, transition from D3 state to D0 state in less
> than 10ms
>
> Signed-off-by: Wang Xingchao<xingchao.wang@intel.com>
> ---
>   sound/pci/hda/hda_codec.c |    6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> index b89c8ec..5298ba1 100644
> --- a/sound/pci/hda/hda_codec.c
> +++ b/sound/pci/hda/hda_codec.c
> @@ -3526,14 +3526,18 @@ static bool snd_hda_codec_get_supported_ps(struct hda_codec *codec, hda_nid_t fg
>   static void hda_set_power_state(struct hda_codec *codec, hda_nid_t fg,
>   				unsigned int power_state)
>   {
> +	bool epss;
>   	if (codec->patch_ops.set_power_state) {
>   		codec->patch_ops.set_power_state(codec, fg, power_state);
>   		return;
>   	}
>
> +	epss = snd_hda_codec_get_supported_ps(codec, fg, AC_PWRST_EPSS);
>   	/* this delay seems necessary to avoid click noise at power-down */
> -	if (power_state == AC_PWRST_D3)
> +	if ((power_state == AC_PWRST_D3)&&  !epss)
>   		msleep(100);
> +	else
> +		msleep(10);

Hi Wang,

You seem to have increased the delay from 0 to 10 ms on all cases when 
power_state != AC_PWRST_D3, is this intentional?

Or did you mean to write like this:

	if (power_state == AC_PWRST_D3) {
		bool epss = snd_hda_codec_get_supported_ps(codec, fg, AC_PWRST_EPSS);
		msleep(epss ? 10 : 100);
	}


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
