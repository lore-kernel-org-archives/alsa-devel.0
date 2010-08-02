From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: How to handle HBR pass-through? (new PCM_FORMAT?)
Date: Mon, 2 Aug 2010 10:40:17 +0300
Message-ID: <201008021040.17380.anssi.hannula@iki.fi>
References: <201008011423.33724.anssi.hannula@iki.fi>
	<AANLkTi=MCNmW5qUT0spwu31UO3qmSFShw1vgkSAvU4ro@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirokuusama.dnainternet.net (sirokuusama.dnainternet.net
	[83.102.40.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C1ED103806
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 09:40:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sirokuusama.dnainternet.net (Postfix) with ESMTP id 857797F276
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 10:40:19 +0300 (EEST)
Received: from sirokuusama.dnainternet.net ([83.102.40.133])
	by localhost (sirokuusama.dnainternet.net [127.0.0.1]) (amavisd-new,
	port 10041)
	with ESMTP id ZpXWDwPKEM3G for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 10:40:19 +0300 (EEST)
Received: from oliivipuu.dnainternet.net (oliivipuu.dnainternet.net
	[83.102.40.215])
	by sirokuusama.dnainternet.net (Postfix) with ESMTP id 5E66D7F11C
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 10:40:19 +0300 (EEST)
Received: from mail.onse.fi (unknown [109.204.162.131])
	by oliivipuu.dnainternet.net (Postfix) with ESMTP id 538D22BAA4
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 10:40:18 +0300 (EEST)
Received: from sigma.onse.fi (sigma [10.0.0.8])
	by mail.onse.fi (Postfix) with ESMTP id 0883310DE0E5
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 10:40:18 +0300 (EEST)
In-Reply-To: <AANLkTi=MCNmW5qUT0spwu31UO3qmSFShw1vgkSAvU4ro@mail.gmail.com>
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

pl bossart kirjoitti maanantai, 2. elokuuta 2010 06:18:35:
> > What this means is that if just the needed HBR bits are set in the audio
> > driver, one can play back e.g. TrueHD by passing the IEC-61937 stream to
> > ALSA as 192kHz 8-channel 16-bit PCM data; of course normal 8-channel PCM
> > playback wouldn't work anymore then. So the driver would need to know if
> > this is 8- channel PCM or 8-channel compressed audio.
> > 
> > Which brings us to my question: How should the user be able to do this,
> > i.e. inform the driver whether this is 8-channel PCM data or compressed
> > audio data?
> > 
> > 
> > One easy option would be to have a separate IEC61937_HBR format in ALSA
> > which could be used for IEC-61937 streams represented as 8x 16-bit
> > channels.
> > 
> > If that would be considered too specific, we could add a more generic
> > IEC61937 format, which is the same as above except that "normal" ( = "2
> > channel") IEC-61937 streams could be used as well. However, as normal
> > IEC-61937 streams can be used with S/PDIF as well, we'd AFAICS need to
> > add such format bit to all S/PDIF drivers or have a no-op converter to
> > the more widely supported 16- bit PCM format.
> 
> Could we require that the user sets the channel status bits (with the
> AESx controls) in case this is compressed. The driver would then make
> an informed decision to use HBR packets instead of regular PCM 8-ch
> layout2?

Indeed, the non-audio flag (AES0 & 0x02) could be used for this.

It seems the only always-available way to set those is as parameters in the 
device string, correct?

Will it always be reset after the user closes the device?

> At any rate, supporting such formats entails changes to higher levels
> of the audio stack, for example gstreamer/alsasink would need
> additional caps. Changes are not limited to the alsa driver I guess.

Yes.
We are in the process of adding support in ffmpeg for the TrueHD-in-IEC61937 
muxing and after that I'll add support into XBMC for using that functionality.

Looked at gstreamer, it seems to only have ac3-in-iec61937 support currently. 
However, I'd guess gstreamer would additionally need some ways to 1) detect if 
HBR is supported, and 2) detect if the connected receiver supports the 
specific codec..

-- 
Anssi Hannula
