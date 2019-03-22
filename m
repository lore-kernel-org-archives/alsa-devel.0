From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] ALSA: hda/ca0132: work around clang -Wuninitialized
 warning
Date: Fri, 22 Mar 2019 07:53:15 -0700
Message-ID: <20190322145315.GA6521@archlinux-ryzen>
References: <20190322140649.197027-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190322140649.197027-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Takashi Iwai <tiwai@suse.com>, Connor McAdams <conmanx360@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Jaroslav Kysela <perex@perex.cz>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 22, 2019 at 03:06:28PM +0100, Arnd Bergmann wrote:
> When CONFIG_PCI is disabled, clang gets confused about the
> control flow of the switch() statement always ending up
> in the default case, and warns:
> 
> sound/pci/hda/patch_ca0132.c:7558:6: error: variable 'fw_entry' is used uninitialized whenever 'if' condition is false
>       [-Werror,-Wsometimes-uninitialized]
>         if (!spec->alt_firmware_present) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/pci/hda/patch_ca0132.c:7565:42: note: uninitialized use occurs here
>         dsp_os_image = (struct dsp_image_seg *)(fw_entry->data);
>                                                 ^~~~~~~~
> sound/pci/hda/patch_ca0132.c:7558:2: note: remove the 'if' if its condition is always true
>         if (!spec->alt_firmware_present) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/pci/hda/patch_ca0132.c:7521:33: note: initialize the variable 'fw_entry' to silence this warning
>         const struct firmware *fw_entry;
>                                        ^
>                                         = NULL
> 
> Adding an explicit check for CONFIG_PCI avoids the issue.
> Unfortunately this is not very intuitive here.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=41197#c1
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> Any suggestions for other workarounds appreciated. If you can think
> of a better fix, please treat this as a reported-by:
> ---
>  sound/pci/hda/patch_ca0132.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
> index 29882bda7632..415b16b7db70 100644
> --- a/sound/pci/hda/patch_ca0132.c
> +++ b/sound/pci/hda/patch_ca0132.c
> @@ -7555,7 +7555,7 @@ static bool ca0132_download_dsp_images(struct hda_codec *codec)
>  	 * Use default ctefx.bin if no alt firmware is detected, or if none
>  	 * exists for your particular codec.
>  	 */
> -	if (!spec->alt_firmware_present) {
> +	if (!IS_ENABLED(CONFIG_PCI) || !spec->alt_firmware_present) {
>  		codec_dbg(codec, "Default firmware selected.");
>  		if (request_firmware(&fw_entry, EFX_FILE,
>  					codec->card->dev) != 0)
> -- 
> 2.20.0
> 
