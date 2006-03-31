From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: pcm parameters, digital output ...
Date: Fri, 31 Mar 2006 13:38:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0603311303340.9303@tm8103.perex-int.cz>
References: <1143632082.9481.6.camel@localhost>
 <Pine.LNX.4.61.0603301642170.11712@tm8103.perex-int.cz>
 <1143731165.4617.0.camel@localhost>  <Pine.LNX.4.61.0603311204150.9303@tm8103.perex-int.cz>
 <1143802530.22691.29.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5E295BD
	for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2006 13:38:48 +0200 (MEST)
In-Reply-To: <1143802530.22691.29.camel@localhost>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Fri, 31 Mar 2006, Johannes Berg wrote:

> On Fri, 2006-03-31 at 12:47 +0200, Jaroslav Kysela wrote:
> 
> > It's information for user space applications. The driver, of course, 
> > ignores the extra bits, but the application should be able to determine 
> > which bits are really send physically over IEC958 interface. Some Cirrus 
> > Logic chips supports only limited iec958 channel status bits and these 
> > bits are even different for pro and consumer modes.
> 
> Well there are 192 bits in either case so I don't see your point? If the
> mask says that the consumer/pro mode bit cannot be set, then the meaning
> is clear by asking the device once for the bits and seeing whether pro
> is on or not, and if it is settable then the application knows which it
> set or can also ask whether it is set or not.
> I don't see what more information the app could get from having a pro
> mask and a con mask. Or is there hardware that changes the allowed mask
> with the setting of pro/con mode??

Yes, it's exactly what I'm talking about.

> > Basically, I'm against to create these new formats, because the data 
> > organization is exactly same as for standard PCM samples. All what we 
> > require is to set a non-audio flag somewhere for the data stream.
> 
> Right. But it needs to be within the stream info, not out-of-band with
> the iec control like you suggested.
> 
> > I would create SNDRV_PCM_SUBFORMAT_NONAUDIO and add subformat 
> > bitmask handling to struct snd_pcm_hardware. Also, note that applications
> > passing AC3 or other compressed streams should set this subformat. To 
> > provide backward compatibility, we should create a hack for the iec958 
> > device in alsa-lib configuration which sets this subformat value when
> > AES0 contains the non-audio bit. The mechanism for handling the extra 
> > iec958 parameters would remain same - using the control interface.
> 
> That makes sense. Essentially, I'm happy if I can use the same stream
> and tell during prepare() if compressed audio is going to be sent or
> not. That's pretty much all that matters to me.

Ok, I will try to add this feature. If someone else have objections 
against this implementation, please, speak now.

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
