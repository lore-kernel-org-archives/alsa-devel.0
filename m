From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH v2 2/2] ALSA: hda - bug fix on HDMI ELD
 debug message
Date: Tue, 02 Apr 2013 08:30:44 +0200
Message-ID: <515A7B14.1040405@canonical.com>
References: <1364462488-30444-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B3B1A2650EE
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2013 08:30:44 +0200 (CEST)
In-Reply-To: <1364462488-30444-1-git-send-email-mengdong.lin@intel.com>
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

On 03/28/2013 10:21 AM, mengdong.lin@intel.com wrote:
> From: Mengdong Lin <mengdong.lin@intel.com>
>
> This patch let ELD debug message show 'pin_eld->monitor_present' which reflects
> the real pin response to verb GET_PIN_SENSE.
>
> 'eld->monitor_present' should not be used here because 'eld' is a temp
> structure now and so its "monitor_present" is not set.
>
> Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Acked-by: David Henningsson <david.henningsson@canonical.com>

>
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
