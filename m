From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH V2] ALSA: hda - power setting error check
Date: Thu, 7 Jun 2012 19:42:43 +0900
Message-ID: <20120607104243.GA18157@localhost>
References: <1339064490-6510-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 1314524341
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 12:42:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1339064490-6510-1-git-send-email-xingchao.wang@intel.com>
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

Xingchao,

On Thu, Jun 07, 2012 at 06:21:30PM +0800, Wang Xingchao wrote:
> codec may reject power state transition requests(reporting PS-ERROR set),
> in that case we re-issue a power state setting and check error bit again.

Is this patch based on real errors observed? And tested to fix the issue?

> Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
> ---
>  sound/pci/hda/hda_codec.c |   17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> index d0ca370..a93c7ca 100644
> --- a/sound/pci/hda/hda_codec.c
> +++ b/sound/pci/hda/hda_codec.c
> @@ -3526,6 +3526,7 @@ static bool snd_hda_codec_get_supported_ps(struct hda_codec *codec, hda_nid_t fg
>  static void hda_set_power_state(struct hda_codec *codec, hda_nid_t fg,
>  				unsigned int power_state)
>  {
> +	int state, count = 0;

nit pick: break that into two lines?

state should be unsigned int.

>  	if (codec->patch_ops.set_power_state) {
>  		codec->patch_ops.set_power_state(codec, fg, power_state);
>  		return;
> @@ -3537,9 +3538,19 @@ static void hda_set_power_state(struct hda_codec *codec, hda_nid_t fg,
>  		bool epss = snd_hda_codec_get_supported_ps(codec, fg, AC_PWRST_EPSS);
>  		msleep(epss? 10:100);
>  	}
> -	snd_hda_codec_read(codec, fg, 0, AC_VERB_SET_POWER_STATE,
> -			    power_state);
> -	snd_hda_codec_set_power_to_all(codec, fg, power_state, true);
> +
> +	/* repeat power states setting at most 10 times*/
> +	while (count++ > 10) {

< 10?

for(;;) looks slightly better, by putting the initialization together
with test and increase.

> +		snd_hda_codec_read(codec, fg, 0, AC_VERB_SET_POWER_STATE,
> +				    power_state);
> +		snd_hda_codec_set_power_to_all(codec, fg, power_state, true);
> +		state = snd_hda_codec_read(codec, fg, 0,
> +					   AC_VERB_GET_POWER_STATE, 0);
> +		if (!(state & AC_PWRST_ERROR))
> +			break;

Do you have any clue the condition of success? For example, is it time
based (the codec takes some time to respond) or retry count based?

> +	}
> +	if (count > 10)
> +		snd_printk(KERN_WARNING "Power states transition reject!\n");

Power state transition rejected

Hmm, if some codec always rejects it, the user may get lots of these
warnings..

Thanks,
Fengguang
