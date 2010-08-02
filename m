From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: How to handle HBR pass-through? (new PCM_FORMAT?)
Date: Mon, 2 Aug 2010 20:37:20 +0300
Message-ID: <201008022037.20532.anssi.hannula@iki.fi>
References: <201008011423.33724.anssi.hannula@iki.fi>
	<201008021040.17380.anssi.hannula@iki.fi>
	<s5hocdlm1f0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
	[83.102.40.132]) by alsa0.perex.cz (Postfix) with ESMTP id 52D6F2454A
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 19:37:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by tulikuusama.dnainternet.net (Postfix) with ESMTP id DABD62C770
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 20:37:22 +0300 (EEST)
Received: from tulikuusama.dnainternet.net ([83.102.40.132])
	by localhost (tulikuusama.dnainternet.net [127.0.0.1]) (amavisd-new,
	port 10041)
	with ESMTP id KUjydaFh392E for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 20:37:22 +0300 (EEST)
Received: from oliivipuu.dnainternet.net (oliivipuu.dnainternet.net
	[83.102.40.215])
	by tulikuusama.dnainternet.net (Postfix) with ESMTP id B1E672C767
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 20:37:22 +0300 (EEST)
Received: from mail.onse.fi (unknown [109.204.162.131])
	by oliivipuu.dnainternet.net (Postfix) with ESMTP id 9D8C02BAA3
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 20:37:21 +0300 (EEST)
Received: from sigma.onse.fi (sigma [10.0.0.8])
	by mail.onse.fi (Postfix) with ESMTP id 2DDC810DE0C8
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 20:37:21 +0300 (EEST)
In-Reply-To: <s5hocdlm1f0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai kirjoitti maanantai, 2. elokuuta 2010 19:20:35:
> At Mon, 2 Aug 2010 10:40:17 +0300,
> 
> Anssi Hannula wrote:
> > pl bossart kirjoitti maanantai, 2. elokuuta 2010 06:18:35:
> > > > What this means is that if just the needed HBR bits are set in the
> > > > audio driver, one can play back e.g. TrueHD by passing the IEC-61937
> > > > stream to ALSA as 192kHz 8-channel 16-bit PCM data; of course normal
> > > > 8-channel PCM playback wouldn't work anymore then. So the driver
> > > > would need to know if this is 8- channel PCM or 8-channel compressed
> > > > audio.
> > > > 
> > > > Which brings us to my question: How should the user be able to do
> > > > this, i.e. inform the driver whether this is 8-channel PCM data or
> > > > compressed audio data?
> > > > 
> > > > 
> > > > One easy option would be to have a separate IEC61937_HBR format in
> > > > ALSA which could be used for IEC-61937 streams represented as 8x
> > > > 16-bit channels.
> > > > 
> > > > If that would be considered too specific, we could add a more generic
> > > > IEC61937 format, which is the same as above except that "normal" ( =
> > > > "2 channel") IEC-61937 streams could be used as well. However, as
> > > > normal IEC-61937 streams can be used with S/PDIF as well, we'd
> > > > AFAICS need to add such format bit to all S/PDIF drivers or have a
> > > > no-op converter to the more widely supported 16- bit PCM format.
> > > 
> > > Could we require that the user sets the channel status bits (with the
> > > AESx controls) in case this is compressed. The driver would then make
> > > an informed decision to use HBR packets instead of regular PCM 8-ch
> > > layout2?
> > 
> > Indeed, the non-audio flag (AES0 & 0x02) could be used for this.
> > 
[...]
> Reusing the existing IEC958 status bits is OK for practical POV,
> indeed.  This makes also compatible with the existing user-space stuff.

Ok.

Now, on my system I have used device name 'hw:2,9' for the passthrough. How 
can I pass AES0 to that?

'hw:2,9,AES0=0x06' doesn't work ("Unknown parameter AES0").

Using 'hdmi:AES0=0x06' results in an error as it tries to use a hdmi interface 
on an usb-audio card ("Unable to find definition 'cards.USB-
Audio.pcm.hdmi.0:CARD=0,AES0=6,AES1=130,AES2=0,AES3=2'").

Using 'hdmi:CARD=NVidia,AES0=0x06' results in the wrong device being used 
(presumably card 2 device 3).

I also tried 'hdmi:CARD=NVidia,DEV=X,AES0=0x06' but no other values for X than 
0 seem to work ("Unable to find definition 'cards.HDA-
Intel.pcm.hdmi.X:CARD=NVidia,AES0=6,AES1=130,AES2=0,AES3=2'").

(Interestingly, outputting audio (e.g. speaker-test) to any of the hw:2,[378] 
works, but only after I've outputted something to hw:2,9 first. Similarly, if 
I try 8-channel audio on hw:2,[378] when last stream on hw:2,9 was a 2-channel 
one, only 2 channels will get through. I guess the audio lines for the 4 hdmi 
codecs are somehow shared or something.)

Here's the device list:
$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: External [SB Live! 24-bit External], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Intel [HDA Intel], device 0: CONEXANT Analog [CONEXANT Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: NVidia [HDA NVidia], device 3: NVIDIA HDMI [NVIDIA HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: NVidia [HDA NVidia], device 7: NVIDIA HDMI [NVIDIA HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: NVidia [HDA NVidia], device 8: NVIDIA HDMI [NVIDIA HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: NVidia [HDA NVidia], device 9: NVIDIA HDMI [NVIDIA HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

-- 
Anssi Hannula
