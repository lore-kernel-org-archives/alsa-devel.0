From: Kailang <kailang@realtek.com>
Subject: Re: Support Dell headset mode for ALC288
Date: Tue, 7 Apr 2015 07:08:36 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A17A0D0C8@RTITMBSV09.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A17A0C909@RTITMBSV09.realtek.com.tw>
 <s5hoan4xdxi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id C11A126051F
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 09:08:46 +0200 (CEST)
In-Reply-To: <s5hoan4xdxi.wl-tiwai@suse.de>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

 

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de] 
> Sent: Saturday, April 04, 2015 8:43 PM
> To: Kailang
> Cc: (alsa-devel@alsa-project.org)
> Subject: Re: Support Dell headset mode for ALC288
> 
> At Tue, 31 Mar 2015 08:01:57 +0000,
> Kailang wrote:
> > 
> > 
> > Hi Takashi,
> >   
> >  Dell has new platform with ALC288.
> >  Attach patch is support headset mode for ALC288.
> 
> > @@ -3828,6 +3894,11 @@ static void 
> alc_determine_headset_type(struct hda_codec *codec)
> >   conteol) */
> >  		{}
> >  	};
> > +	static struct coef_fw coef0286[] = {
> > +		//UPDATE_COEF(0x4f, 0xfcc0, 0x5400), /* Combo 
> Jack auto detect */
> > +		UPDATE_COEF(0x4f, 0xfcc0, 0xd400),
> 
> Why is this commented out and what's the next line does instead?
> And it's 0286?  Not 0288?
> 
> > @@ -3949,8 +4027,15 @@ static void 
> alc_update_headset_jack_cb(struct hda_codec *codec,
> >  				       struct hda_jack_callback 
> *jack)  {
> >  	struct alc_spec *spec = codec->spec;
> > +	int present;
> >  	spec->current_headset_type = ALC_HEADSET_TYPE_UNKNOWN;
> >  	snd_hda_gen_hp_automute(codec, jack);
> > +	present = spec->gen.hp_jack_present ? 0x40 : 0;
> > +	if (codec->bus->pci->subsystem_vendor == 0x1028 &&
> > +				codec->core.vendor_id == 0x10ec0288)
> > +		/* Headset Mic enable and disable, ony for Dell Dino */
> > +		snd_hda_codec_write(codec, 0x01, 0, 
> AC_VERB_SET_GPIO_DATA,
> > +					present);
> 
> This is too ugly to put in the common function.
> For Dell, prepare its own callback function and use it 
> instead.  Or, put a new hook there to call additionally.  
> This avoids the PCI ID check in each place.
> 
> So, better to split to a few patches.  One for adding ALC286 
> (or 288?) support generically.  And another for adding 
> Dell-specific things.
>
 
Ok! I will split it for two patches.
But spec->gen.hp_automute_hook = alc_update_headset_jack_cb in alc_fixup_headset_mode().
If I move dell specific part to fixup table by SSID, spec->gen.hp_automute_hook will be reinit to new.
So, I just place the code here.

> 
> thanks,
> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
> 
