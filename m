From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/4] ALSA: hda - Return error when open
	empty hdmi device
Date: Mon, 17 Jun 2013 10:23:37 +0200
Message-ID: <51BEC789.1060408@canonical.com>
References: <1371223229-8236-1-git-send-email-xingchao.wang@linux.intel.com>
 <1371223229-8236-3-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 57C762616FB
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2013 10:23:41 +0200 (CEST)
In-Reply-To: <1371223229-8236-3-git-send-email-xingchao.wang@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wang Xingchao <xingchao.wang@linux.intel.com>
Cc: tiwai@suse.de, daniel.vetter@ffwll.ch, alsa-devel@alsa-project.org, intel-gfx@lists.freedesktop.org, xingchao.wang@intel.com
List-Id: alsa-devel@alsa-project.org

On 06/14/2013 05:20 PM, Wang Xingchao wrote:
> when user open HDMI device 3/7/8, if it has no physical device
> connected, return error.

This patch will cause regressions in two big use cases:

  1) Older chipsets (at least from non-Intel vendors) might not support 
correct ELD reporting. Thus this will cause HDMI audio to stop working 
there.

  2) In PulseAudio's current design, PulseAudio probes the device at 
startup and caches the result. Unfortunately, there is no reprobing at 
plug/unplug, so if the monitor is hotplugged, it will not work unless 
PulseAudio is restarted afterwards.


> The bug is from Haswell platform, All pins choose converter 0 by default
> in hardware level, maybe only pin 1 had valid monitor connected. if user
> play audio on pin 0/2, pin 1 can get audio data too.
>
> Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
> ---
>   sound/pci/hda/patch_hdmi.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 8db5eb6..d766f40 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -1139,6 +1139,9 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
>   	per_pin = get_pin(spec, pin_idx);
>   	eld = &per_pin->sink_eld;
>
> +	if (!eld->monitor_present || !eld->eld_valid)
> +		return -EIO;
> +
>   	if (codec->vendor_id == 0x80862807)
>   		hsw_verify_cvt_D0(spec, codec);
>   		
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
