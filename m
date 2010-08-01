From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: How to handle HBR pass-through? (new PCM_FORMAT?)
Date: Sun, 1 Aug 2010 14:23:33 +0300
Message-ID: <201008011423.33724.anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from saarni.dnainternet.net (saarni.dnainternet.net [83.102.40.136])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F61F244A4
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Aug 2010 13:23:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by saarni.dnainternet.net (Postfix) with ESMTP id C1DE5E6437
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Aug 2010 14:23:35 +0300 (EEST)
Received: from saarni.dnainternet.net ([83.102.40.136])
	by localhost (saarni.dnainternet.net [127.0.0.1]) (amavisd-new,
	port 10041)
	with ESMTP id iERDl+-rI2xf for <alsa-devel@alsa-project.org>;
	Sun,  1 Aug 2010 14:23:35 +0300 (EEST)
Received: from oliivipuu.dnainternet.net (oliivipuu.dnainternet.net
	[83.102.40.215])
	by saarni.dnainternet.net (Postfix) with ESMTP id 9D166E6338
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Aug 2010 14:23:35 +0300 (EEST)
Received: from mail.onse.fi (unknown [109.204.162.131])
	by oliivipuu.dnainternet.net (Postfix) with ESMTP id 9368D7F002
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Aug 2010 14:23:34 +0300 (EEST)
Received: from sigma.onse.fi (sigma [10.0.0.8])
	by mail.onse.fi (Postfix) with ESMTP id 27FF010DE4BE
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Aug 2010 14:23:34 +0300 (EEST)
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

Hi all!

Passing through compressed audio via a digital link (S/PDIF, HDMI) is done by 
encapsulating the audio in a constant-bitrate IEC-61937 format, which is then 
passed to alsa as a normal 16bit PCM stream.

However, there is a new complication: Codecs that require an iec60958 frame 
rate higher than 192kHz (currently TrueHD/MLP and DTS-HD) need to be 
transmitted in HDMI (note that these can't be transmitted in normal S/PDIF at 
all) in a slightly different way.

The transmission via HDMI is essentially the same as transmission of 8-channel 
PCM stream with sample rate of iec60958_frame_rate/4 (e.g. 192kHz for TrueHD), 
with the samples inside a HBR packet instead of standard audio sample packet.

What this means is that if just the needed HBR bits are set in the audio 
driver, one can play back e.g. TrueHD by passing the IEC-61937 stream to ALSA 
as 192kHz 8-channel 16-bit PCM data; of course normal 8-channel PCM playback 
wouldn't work anymore then. So the driver would need to know if this is 8-
channel PCM or 8-channel compressed audio.

Which brings us to my question: How should the user be able to do this, i.e. 
inform the driver whether this is 8-channel PCM data or compressed audio data?


One easy option would be to have a separate IEC61937_HBR format in ALSA which 
could be used for IEC-61937 streams represented as 8x 16-bit channels.

If that would be considered too specific, we could add a more generic IEC61937 
format, which is the same as above except that "normal" ( = "2 channel") 
IEC-61937 streams could be used as well. However, as normal IEC-61937 streams 
can be used with S/PDIF as well, we'd AFAICS need to add such format bit to 
all S/PDIF drivers or have a no-op converter to the more widely supported 16-
bit PCM format.
Technically, I guess, IEC61937 data should be considered 8-bit or 32-bit 
(which is the amount of data in a single IEC-60958 frame) 1-channel stream, 
but that would mean the needed sample rate values would be far higher, which 
would be confusing since 16-bit PCM samples would not be supported at those 
rates.

Another possible option could be to have some ALSA device flag like AESx now 
are (I'm not sure how those are handled, maybe it wouldn't work).

Or maybe we should have SND_PCM_SUBFORMAT_IEC61937 or 
SND_PCM_SUBFORMAT_NONPCM?

What should be done?

-- 
Anssi Hannula
