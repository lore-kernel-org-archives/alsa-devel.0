From: forumjunk@comcast.net (Darryl House)
Subject: Re: snd-hda-intel support for SPDIF-in wiht
	vt1708	card?
Date: Fri, 21 Dec 2007 22:59:11 +0000
Message-ID: <122120072259.10957.476C453F000C7D2600002ACD220702065305029A06039A9D0100@comcast.net>
Content-Type: multipart/mixed; boundary="===============1499463231971265601=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from QMTA04.emeryville.ca.mail.comcast.net
	(qmta04.emeryville.ca.mail.comcast.net [76.96.30.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 39F321038B6
	for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2007 23:59:17 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, john@stilen.com
List-Id: alsa-devel@alsa-project.org

--===============1499463231971265601==

Well, I spoke too soon... with or without the via patch, I now get an error from the driver about an inappropriate ioctl for the device while KDE is trying to start the sound system.

On a command line, madplay and aplay return this: 

#> aplay /usr/share/sounds/KDE_Glass_Break.ogg
#> ALSA lib pcm_dmix.c:866:(snd_pcm_dmix_open) unable to open slave
#> aplay: main:546: audio open error: Device or resource busy

#> aplay /usr/share/sounds/pop.wav
#> ALSA lib pcm_dmix.c:866:(snd_pcm_dmix_open) unable to open slave
#> aplay: main:546: audio open error: Device or resource busy

#> madplay /usr/share/sounds/KDE_Glass_Break.ogg
#> MPEG Audio Decoder 0.15.2 (beta) - Copyright © 2000-2004 Robert Leslie et al.
#> audio: /dev/dsp: Device or resource busy

#> madplay /usr/share/sounds/pop.wav
#> MPEG Audio Decoder 0.15.2 (beta) - Copyright © 2000-2004 Robert Leslie et al.
#> audio: /dev/dsp: Device or resource busy

alsaconf correctly detects the VT1708, and alsamixer and alsactl all seem to work correctly.

I've tried obtaining and installing the latest mercurial clone of alsa-lib,
and I've tried this with or without the patch_via.c patch below.

Am I doing something wrong?

-- Darryl

 -------------- Original message ----------------------
From: forumjunk@comcast.net (Darryl House)
> The patch fixed all compilation errors for me, thank you. I did have to apply it 
> manually, but that was rather simple.
> 
> I can confirm that SPDIF input doesn't work for the card, but I haven't applied 
> the patch that you suggested to John Stile for that, yet. I'll do that a bit 
> later today if you still recommend it
> 
> Is this patch still recommended?
> 
> > diff -r 2d3893cf030c pci/hda/patch_via.c
> > --- a/pci/hda/patch_via.c	Tue Dec 18 15:42:53 2007 +0100
> > +++ b/pci/hda/patch_via.c	Tue Dec 18 17:48:00 2007 +0100
> > @@ -568,25 +568,27 @@ static int via_init(struct hda_codec *co
> >  		if (IS_VT1708_VENDORID(codec->vendor_id)) {
> >  			snd_hda_codec_write(codec, VT1708_DIGIN_PIN, 0,
> >  					    AC_VERB_SET_PIN_WIDGET_CONTROL,
> > -					    0x40);
> > +					    PIN_OUT);
> >  			snd_hda_codec_write(codec, VT1708_DIGIN_PIN, 0,
> >  					    AC_VERB_SET_EAPD_BTLENABLE, 0x02);
> >  		} else if (IS_VT1709_10CH_VENDORID(codec->vendor_id) ||
> >  			   IS_VT1709_6CH_VENDORID(codec->vendor_id)) {
> >  			snd_hda_codec_write(codec, VT1709_DIGIN_PIN, 0,
> >  					    AC_VERB_SET_PIN_WIDGET_CONTROL,
> > -					    0x40);
> > +					    PIN_OUT);
> >  			snd_hda_codec_write(codec, VT1709_DIGIN_PIN, 0,
> >  					    AC_VERB_SET_EAPD_BTLENABLE, 0x02);
> >  		} else if (IS_VT1708B_8CH_VENDORID(codec->vendor_id) ||
> >  			   IS_VT1708B_4CH_VENDORID(codec->vendor_id)) {
> >  			snd_hda_codec_write(codec, VT1708B_DIGIN_PIN, 0,
> >  					    AC_VERB_SET_PIN_WIDGET_CONTROL,
> > -					    0x40);
> > +					    PIN_OUT);
> >  			snd_hda_codec_write(codec, VT1708B_DIGIN_PIN, 0,
> >  					    AC_VERB_SET_EAPD_BTLENABLE, 0x02);
> >  		}
> > -	}
> > +	} else /* enable SPDIF-input pin */
> > +		snd_hda_codec_write(codec, spec->autocfg.dig_in_pin, 0,
> > +				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN);
> >  
> >   	return 0;
> >  }
> 
> Thanks again!
> 
> -- Darryl
> 
> 
>  -------------- Original message ----------------------
> From: Takashi Iwai <tiwai@suse.de>
> [...]
> > Thanks.  Does the patch below fix the probelm?
> > Run hgcompile after applying it.
> > 
> > 
> > Takashi
> > 
> > diff -r 414b1156a8b3 configure.in
> > --- a/configure.in	Tue Dec 18 16:09:20 2007 +0100
> > +++ b/configure.in	Fri Dec 21 12:10:53 2007 +0100
> > @@ -1230,7 +1230,7 @@ esac
> >  
> >  dnl set ia32 (X86)
> >  case "$processor" in
> > -  i?86*|k?|crusoe|mcyrixiii|mwinchip|viac3_2|mcore2|geodegx*)
> > +  i?86*|k?|crusoe|mcyrixiii|mwinchip|viac3_2|mcore2|geodegx*|x86_32)
> >      if $KCC -mpreferred-stack-boundary=2 -S -o /dev/null -xc /dev/null 
> > >/dev/null 2>&1; then
> >        c_opts="-mpreferred-stack-boundary=2 $c_opts"
> >        CONFIG_X86=y
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


--===============1499463231971265601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1499463231971265601==--
