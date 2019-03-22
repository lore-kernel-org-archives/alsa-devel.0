From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] ALSA: hda/ca0132: work around clang -Wuninitialized
 warning
Date: Fri, 22 Mar 2019 08:13:21 -0700
Message-ID: <20190322151321.GA13220@archlinux-ryzen>
References: <20190322140649.197027-1-arnd@arndb.de>
 <s5hr2az9cos.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hr2az9cos.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Connor McAdams <conmanx360@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, Alastair Bridgewater <alastair.bridgewater@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 22, 2019 at 04:00:19PM +0100, Takashi Iwai wrote:
> On Fri, 22 Mar 2019 15:06:28 +0100,
> Arnd Bergmann wrote:
> > 
> > When CONFIG_PCI is disabled, clang gets confused about the
> > control flow of the switch() statement always ending up
> > in the default case, and warns:
> > 
> > sound/pci/hda/patch_ca0132.c:7558:6: error: variable 'fw_entry' is used uninitialized whenever 'if' condition is false
> >       [-Werror,-Wsometimes-uninitialized]
> >         if (!spec->alt_firmware_present) {
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > sound/pci/hda/patch_ca0132.c:7565:42: note: uninitialized use occurs here
> >         dsp_os_image = (struct dsp_image_seg *)(fw_entry->data);
> >                                                 ^~~~~~~~
> > sound/pci/hda/patch_ca0132.c:7558:2: note: remove the 'if' if its condition is always true
> >         if (!spec->alt_firmware_present) {
> >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > sound/pci/hda/patch_ca0132.c:7521:33: note: initialize the variable 'fw_entry' to silence this warning
> >         const struct firmware *fw_entry;
> >                                        ^
> >                                         = NULL
> > 
> > Adding an explicit check for CONFIG_PCI avoids the issue.
> > Unfortunately this is not very intuitive here.
> > 
> > Link: https://bugs.llvm.org/show_bug.cgi?id=41197#c1
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Any suggestions for other workarounds appreciated. If you can think
> > of a better fix, please treat this as a reported-by:
> 
> Can it be addressed by the code simplification like below, instead?
> 

Yes, the warning is fixed with that diff and makes the code easier to
follow I think.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> 
> thanks,
> 
> Takashi
> 
> ---
>  sound/pci/hda/patch_ca0132.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
> index 29882bda7632..e1ebc6d5f382 100644
> --- a/sound/pci/hda/patch_ca0132.c
> +++ b/sound/pci/hda/patch_ca0132.c
> @@ -1005,7 +1005,6 @@ struct ca0132_spec {
>  	unsigned int scp_resp_header;
>  	unsigned int scp_resp_data[4];
>  	unsigned int scp_resp_count;
> -	bool alt_firmware_present;
>  	bool startup_check_entered;
>  	bool dsp_reload;
>  
> @@ -7518,7 +7517,7 @@ static bool ca0132_download_dsp_images(struct hda_codec *codec)
>  	bool dsp_loaded = false;
>  	struct ca0132_spec *spec = codec->spec;
>  	const struct dsp_image_seg *dsp_os_image;
> -	const struct firmware *fw_entry;
> +	const struct firmware *fw_entry = NULL;
>  	/*
>  	 * Alternate firmwares for different variants. The Recon3Di apparently
>  	 * can use the default firmware, but I'll leave the option in case
> @@ -7529,33 +7528,26 @@ static bool ca0132_download_dsp_images(struct hda_codec *codec)
>  	case QUIRK_R3D:
>  	case QUIRK_AE5:
>  		if (request_firmware(&fw_entry, DESKTOP_EFX_FILE,
> -					codec->card->dev) != 0) {
> +					codec->card->dev) != 0)
>  			codec_dbg(codec, "Desktop firmware not found.");
> -			spec->alt_firmware_present = false;
> -		} else {
> +		else
>  			codec_dbg(codec, "Desktop firmware selected.");
> -			spec->alt_firmware_present = true;
> -		}
>  		break;
>  	case QUIRK_R3DI:
>  		if (request_firmware(&fw_entry, R3DI_EFX_FILE,
> -					codec->card->dev) != 0) {
> +					codec->card->dev) != 0)
>  			codec_dbg(codec, "Recon3Di alt firmware not detected.");
> -			spec->alt_firmware_present = false;
> -		} else {
> +		else
>  			codec_dbg(codec, "Recon3Di firmware selected.");
> -			spec->alt_firmware_present = true;
> -		}
>  		break;
>  	default:
> -		spec->alt_firmware_present = false;
>  		break;
>  	}
>  	/*
>  	 * Use default ctefx.bin if no alt firmware is detected, or if none
>  	 * exists for your particular codec.
>  	 */
> -	if (!spec->alt_firmware_present) {
> +	if (!fw_entry) {
>  		codec_dbg(codec, "Default firmware selected.");
>  		if (request_firmware(&fw_entry, EFX_FILE,
>  					codec->card->dev) != 0)
> -- 
> 2.16.4
> 
