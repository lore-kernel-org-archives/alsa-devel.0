From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH v2 1/2] ALSA: hda - bug fix on return value
 when getting HDMI ELD info
Date: Tue, 02 Apr 2013 08:30:15 +0200
Message-ID: <515A7AF7.90405@canonical.com>
References: <1364462422-30404-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id CEAD92650C2
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2013 08:30:17 +0200 (CEST)
In-Reply-To: <1364462422-30404-1-git-send-email-mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/28/2013 10:20 AM, mengdong.lin@intel.com wrote:
> From: Mengdong Lin <mengdong.lin@intel.com>
>
> In function snd_hdmi_get_eld(), the variable 'ret' should be initialized to 0.
> Otherwise it will be returned uninitialized as non-zero after ELD info is got
> successfully. Thus hdmi_present_sense() will always assume ELD info is invalid
> by mistake, and /proc file system cannot show the proper ELD info.
>
> Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Cc: stable@vger.kernel.org
Acked-by: David Henningsson <david.henningsson@canonical.com>

>
> diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
> index 7dd8463..d0d7ac1 100644
> --- a/sound/pci/hda/hda_eld.c
> +++ b/sound/pci/hda/hda_eld.c
> @@ -320,7 +320,7 @@ int snd_hdmi_get_eld(struct hda_codec *codec, hda_nid_t nid,
>   		     unsigned char *buf, int *eld_size)
>   {
>   	int i;
> -	int ret;
> +	int ret = 0;
>   	int size;
>
>   	/*
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
