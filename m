From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ALSA: hda - Add new GPU codec ID to snd-hda
Date: Sat, 13 Jul 2013 21:05:01 -0700
Message-ID: <20130714040501.GA11088@kroah.com>
References: <1373652097-4845-1-git-send-email-aplattner@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1373652097-4845-1-git-send-email-aplattner@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Plattner <aplattner@nvidia.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 12, 2013 at 11:01:37AM -0700, Aaron Plattner wrote:
> Vendor ID 0x10de0060 is used by a yet-to-be-named GPU chip.
> 
> Reviewed-by: Andy Ritger <aritger@nvidia.com>
> Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
> ---
>  sound/pci/hda/patch_hdmi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index e12f7a0..486def7 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -2536,6 +2536,7 @@ static const struct hda_codec_preset snd_hda_preset_hdmi[] = {
>  { .id = 0x10de0043, .name = "GPU 43 HDMI/DP",	.patch = patch_generic_hdmi },
>  { .id = 0x10de0044, .name = "GPU 44 HDMI/DP",	.patch = patch_generic_hdmi },
>  { .id = 0x10de0051, .name = "GPU 51 HDMI/DP",	.patch = patch_generic_hdmi },
> +{ .id = 0x10de0060, .name = "GPU 60 HDMI/DP",	.patch = patch_generic_hdmi },
>  { .id = 0x10de0067, .name = "MCP67 HDMI",	.patch = patch_nvhdmi_2ch },
>  { .id = 0x10de8001, .name = "MCP73 HDMI",	.patch = patch_nvhdmi_2ch },
>  { .id = 0x11069f80, .name = "VX900 HDMI/DP",	.patch = patch_via_hdmi },
> @@ -2588,6 +2589,7 @@ MODULE_ALIAS("snd-hda-codec-id:10de0042");
>  MODULE_ALIAS("snd-hda-codec-id:10de0043");
>  MODULE_ALIAS("snd-hda-codec-id:10de0044");
>  MODULE_ALIAS("snd-hda-codec-id:10de0051");
> +MODULE_ALIAS("snd-hda-codec-id:10de0060");
>  MODULE_ALIAS("snd-hda-codec-id:10de0067");
>  MODULE_ALIAS("snd-hda-codec-id:10de8001");
>  MODULE_ALIAS("snd-hda-codec-id:11069f80");

Why are these module aliases being created by hand and not automated
like all other aliases that contain device ids like this are?

odd,

greg k-h
