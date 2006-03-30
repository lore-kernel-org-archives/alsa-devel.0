From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: pcm parameters, digital output ...
Date: Thu, 30 Mar 2006 16:51:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0603301642170.11712@tm8103.perex-int.cz>
References: <1143632082.9481.6.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EAC3D11F
	for <alsa-devel@alsa-project.org>; Thu, 30 Mar 2006 16:51:48 +0200 (MEST)
In-Reply-To: <1143632082.9481.6.camel@localhost>
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

On Wed, 29 Mar 2006, Johannes Berg wrote:

> What is the point in having "Con Mask", "Pro Mask" and just "Mask"?
> Doesn't "Mask" subsume the other two, and in the "Pro Mask" the consumer
> mode bit cannot be set (which ac97 seems to still allow...)? Just has me
> puzzled.
> Anyway, that isn't really the point.

The mask is R/O variable and the bit definitions are different for 
consumer and pro modes, so the driver can describe exactly which bits are 
supported for these two different modes.

> Looking at the ac97 api, it specifies the SPDIF controls as part of the
> mixer. Shouldn't those rather be tied to a specific PCM?

AC97 code is probably not a good example. The "shift" to specific PCM 
device is not implemented there. Look to snd_ice1712_spdif_build_controls
in ice1712.c . This code is good.

> I think that there isn't much we can do without breaking everything. I
> think it'd probably be best to add a new "pcm" format for the compressed
> data. The current ac3play is using 16bit signed little endian pcm data
> (SND_PCM_FORMAT_S16_LE), which is not really what it is sending, it
> isn't sending PCM data at all.
> Something like SND_PCM_FORMAT_SPDIF_NONPCM would be fine. Then
> applications would use that to announce that they're sending non-pcm
> data down the 'pcm' device...

I'm not sure, if we need a new format when we have information from the 
control elements, that the stream is not PCM encoded. But on other hand, 
these formats can be used with some conversion layers in alsa-lib 
for handling of these streams and prevent extra things like resampling, 
volume processing etc.

Also, there is a possibility to use subformat value (which is not used 
so far for S16_LE/BE formats) for the non-pcm stream specification.

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
