From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - bug fix on return value when
 getting HDMI ELD info
Date: Wed, 27 Mar 2013 11:16:21 +0100
Message-ID: <5152C6F5.1060007@canonical.com>
References: <1364391446-23883-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 9237A265083
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 11:16:22 +0100 (CET)
In-Reply-To: <1364391446-23883-1-git-send-email-mengdong.lin@intel.com>
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

On 03/27/2013 02:37 PM, mengdong.lin@intel.com wrote:
> From: Mengdong Lin <mengdong.lin@intel.com>
>
> In function snd_hdmi_get_eld(), the variable 'ret' should be initialized to 0.
> Otherwise it will be returned uninitialized as non-zero after ELD info is got
> successfully. Thus hdmi_present_sense() will always assume ELD info is invalid
> by mistake, and /proc file system cannot show the proper ELD info.
>
> This patch also let debug message show 'pin_eld->monitor_present' which is the
> real pin response to verb GET_PIN_SENSE.
>
> Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

Reviewed-by: David Henningsson <david.henningsson@canonical.com>

Good findings.
The first one is at least in 3.8 and so this should be sent to stable too.

The second one (pin_eld) is new for 3.9, and probably caused by me, so, 
sorry for that :-/


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
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 78e1827..de8ac5c 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -1196,7 +1196,7 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
>
>   	_snd_printd(SND_PR_VERBOSE,
>   		"HDMI status: Codec=%d Pin=%d Presence_Detect=%d ELD_Valid=%d\n",
> -		codec->addr, pin_nid, eld->monitor_present, eld->eld_valid);
> +		codec->addr, pin_nid, pin_eld->monitor_present, eld->eld_valid);
>
>   	if (eld->eld_valid) {
>   		if (snd_hdmi_get_eld(codec, pin_nid, eld->eld_buffer,
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
