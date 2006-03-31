From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: pcm parameters, digital output ...
Date: Fri, 31 Mar 2006 12:47:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0603311204150.9303@tm8103.perex-int.cz>
References: <1143632082.9481.6.camel@localhost>
 <Pine.LNX.4.61.0603301642170.11712@tm8103.perex-int.cz> <1143731165.4617.0.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1EC69D8
	for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2006 12:47:11 +0200 (MEST)
In-Reply-To: <1143731165.4617.0.camel@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Thu, 30 Mar 2006, Johannes Berg wrote:

> On Thu, 2006-03-30 at 16:51 +0200, Jaroslav Kysela wrote:
> 
> > The mask is R/O variable and the bit definitions are different for 
> > consumer and pro modes, so the driver can describe exactly which bits are 
> > supported for these two different modes.
> 
> Yes, I know, I just don't see why there are different modes. If the chip
> has different modes, shouldn't the driver be able to switch between them
> based on the consumer bit in the actual iec958 values it gets from
> userspace?

It's information for user space applications. The driver, of course, 
ignores the extra bits, but the application should be able to determine 
which bits are really send physically over IEC958 interface. Some Cirrus 
Logic chips supports only limited iec958 channel status bits and these 
bits are even different for pro and consumer modes.

> > AC97 code is probably not a good example. The "shift" to specific PCM 
> > device is not implemented there. Look to snd_ice1712_spdif_build_controls
> > in ice1712.c . This code is good.
> 
> Hmm, ok. Did you read my earlier discussion about why I do *not* want a
> shift to a specific pcm device?

Note that controls might be changed (removed, added) at runtime, but it's 
not preferred, because the logic for applications is more complicated.

At least alsa-lib must have configuration for your iec958 device which 
correctly handles the iec958 channel status bits. And this configuration 
will describe which controls should be used.

> > I'm not sure, if we need a new format when we have information from the 
> > control elements, that the stream is not PCM encoded. But on other hand, 
> > these formats can be used with some conversion layers in alsa-lib 
> > for handling of these streams and prevent extra things like resampling, 
> > volume processing etc.
> 
> Aha, good point, I could use the iec958 bits to determine the mode. But 
> that's out-of-band information, so it is not too nice to rely on it 
> imho. And exactly like you say, resampling etc. cannot be done on 
> compressed information.
> 
> > Also, there is a possibility to use subformat value (which is not used 
> > so far for S16_LE/BE formats) for the non-pcm stream specification.
> 
> I'm not too familiar with these internals :)
> 
> What I'm currently doing is defining for each codec what kind of
> transfer formats it supports, see 
> http://johannes.sipsolutions.net/gitweb.cgi?p=snd-aoa.git;a=blob;h=e3ca7a269906ceb41b411afcad14c54f4a181588;hb=4e1bc0b35020b3b1cac87f60cb67671e2c9a801e;f=aoa/codecs/onyx/snd-aoa-codec-onyx.c#l430
> 
> Then the generic framework cuts that down to whatever is usable() at the
> moment depending on the selection of the iec958 and analog mute mixer
> elements. Hence there you can see what I'd like to do with a new format
> (which I called SNDRV_PCM_FMTBIT_COMPRESSED_16BE for now).

Basically, I'm against to create these new formats, because the data 
organization is exactly same as for standard PCM samples. All what we 
require is to set a non-audio flag somewhere for the data stream.

I would create SNDRV_PCM_SUBFORMAT_NONAUDIO and add subformat 
bitmask handling to struct snd_pcm_hardware. Also, note that applications
passing AC3 or other compressed streams should set this subformat. To 
provide backward compatibility, we should create a hack for the iec958 
device in alsa-lib configuration which sets this subformat value when
AES0 contains the non-audio bit. The mechanism for handling the extra 
iec958 parameters would remain same - using the control interface.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
