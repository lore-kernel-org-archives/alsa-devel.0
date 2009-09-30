From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: ALC268 - Acer Aspire 5720 - mic source switch
 disappered
Date: Wed, 30 Sep 2009 19:33:28 +0200
Message-ID: <1254332008.4556.0.camel@maxim-laptop>
References: <1254186798.16290.4.camel@maxim-laptop>
	<s5hk4zigsco.wl%tiwai@suse.de> <1254237796.20723.1.camel@maxim-laptop>
	<s5hhbul4vb9.wl%tiwai@suse.de> <1254243023.20723.5.camel@maxim-laptop>
	<1254243103.20723.6.camel@maxim-laptop> <s5hbpktotay.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 2175E24469
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 19:33:34 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 22so2473469fge.2
	for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2009 10:33:33 -0700 (PDT)
In-Reply-To: <s5hbpktotay.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2009-09-30 at 08:11 +0200, Takashi Iwai wrote: 
> At Tue, 29 Sep 2009 18:51:43 +0200,
> Maxim Levitsky wrote:
> > 
> > On Tue, 2009-09-29 at 18:50 +0200, Maxim Levitsky wrote: 
> > > On Tue, 2009-09-29 at 17:36 +0200, Takashi Iwai wrote: 
> > > > At Tue, 29 Sep 2009 17:23:15 +0200,
> > > > Maxim Levitsky wrote:
> > > > > 
> > > > > On Tue, 2009-09-29 at 08:47 +0200, Takashi Iwai wrote: 
> > > > > > At Tue, 29 Sep 2009 03:13:18 +0200,
> > > > > > Maxim Levitsky wrote:
> > > > > > > 
> > > > > > > Hi,
> > > > > > > 
> > > > > > > I have installed 2.6.32-rc1 (well -rc2...)
> > > > > > > 
> > > > > > > And I notice that 'Input source' is missing.
> > > > > > 
> > > > > > Now it's selected automatically per mic-jack plugging.
> > > > > > 
> > > > > > 
> > > > > > Takashi
> > > > > 
> > > > > Nice, but driver doesn't record from internal mic now, despite the fact
> > > > > that no external mic is plugged in.
> > > > 
> > > > That's a bug, obviously :)
> > > > 
> > > > Could you run alsa-info.sh (with --no-upload option) with and without
> > > > the mic plugged, and attach the files?
> > > > 
> > > > 
> > > > thanks,
> > > > 
> > > > Takashi
> > > 
> > > Sure, I already did, but it mostly contains the /proc/asound/Intel/...
> > > codec#0 stuff...
> > Here the attachment I forgot...
> 
> Ah, this is no aspire-one-like model.
> 
> Looks like I mistakenly removed the input source mixer element.
> The fixed patch is below.
> 
> 
> thanks,
> 
> Takashi
> 
> ---
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 1296058..bc057a8 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -12660,7 +12660,7 @@ static struct alc_config_preset alc268_presets[] = {
>  		.init_hook = alc268_toshiba_automute,
>  	},
>  	[ALC268_ACER] = {
> -		.mixers = { alc268_acer_mixer, alc268_capture_nosrc_mixer,
> +		.mixers = { alc268_acer_mixer, alc268_capture_alt_mixer,
>  			    alc268_beep_mixer },
>  		.init_verbs = { alc268_base_init_verbs, alc268_eapd_verbs,
>  				alc268_acer_verbs },

Thank you very much. Works fine now!

Best regards,
Maxim Levitsky
