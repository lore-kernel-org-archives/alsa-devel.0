From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: v3.1.8: hda-intel broken
Date: Wed, 22 Feb 2012 15:31:24 +0000
Message-ID: <20120222153124.GH22562@n2100.arm.linux.org.uk>
References: <20120221235807.GO22562@n2100.arm.linux.org.uk>
	<s5hr4xn46ks.wl%tiwai@suse.de>
	<20120222140252.GE22562@n2100.arm.linux.org.uk>
	<s5hboor2b9k.wl%tiwai@suse.de> <s5h8vjv2b3i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 6F5961040BD
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 16:31:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h8vjv2b3i.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 22, 2012 at 03:31:45PM +0100, Takashi Iwai wrote:
> Takashi (going to take a coffee now)

Your coffee seems to have worked.  It no longer warns at boot or
with your aplay test.  You can have a tested-by for this.  Thanks.

> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Fix redundant jack creations for cx5051
> 
> The cx5051 parser calls snd_hda_input_jack_add() in the init callback
> to create and initialize the jack detection instances.  Since the init
> callback is called at each time when the device gets woken up after
> suspend or power-saving mode, the duplicated instances are accumulated
> at each call.  This ends up with the kernel warnings with the too
> large array size.
> 
> The fix is simply to move the calls of snd_hda_input_jack_add() into
> the parser section instead of the init callback.
> 
> The fix is needed only up to 3.2 kernel, since the HD-audio jack layer
> was redesigned in the 3.3 kernel.
> 
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/patch_conexant.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
> index 7072251..08bad5b 100644
> --- a/sound/pci/hda/patch_conexant.c
> +++ b/sound/pci/hda/patch_conexant.c
> @@ -1899,6 +1899,10 @@ static void cxt5051_init_mic_port(struct hda_codec *codec, hda_nid_t nid,
>  	snd_hda_codec_write(codec, nid, 0,
>  			    AC_VERB_SET_UNSOLICITED_ENABLE,
>  			    AC_USRSP_EN | event);
> +}
> +
> +static void cxt5051_init_mic_jack(struct hda_codec *codec, hda_nid_t nid)
> +{
>  	snd_hda_input_jack_add(codec, nid, SND_JACK_MICROPHONE, NULL);
>  	snd_hda_input_jack_report(codec, nid);
>  }
> @@ -1916,7 +1920,6 @@ static int cxt5051_init(struct hda_codec *codec)
>  	struct conexant_spec *spec = codec->spec;
>  
>  	conexant_init(codec);
> -	conexant_init_jacks(codec);
>  
>  	if (spec->auto_mic & AUTO_MIC_PORTB)
>  		cxt5051_init_mic_port(codec, 0x17, CXT5051_PORTB_EVENT);
> @@ -2037,6 +2040,12 @@ static int patch_cxt5051(struct hda_codec *codec)
>  	if (spec->beep_amp)
>  		snd_hda_attach_beep_device(codec, spec->beep_amp);
>  
> +	conexant_init_jacks(codec);
> +	if (spec->auto_mic & AUTO_MIC_PORTB)
> +		cxt5051_init_mic_jack(codec, 0x17);
> +	if (spec->auto_mic & AUTO_MIC_PORTC)
> +		cxt5051_init_mic_jack(codec, 0x18);
> +
>  	return 0;
>  }
>  
> -- 
> 1.7.9
> 
