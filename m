From: "James C. Georgas" <jgeorgas@rogers.com>
Subject: broken emu10k1 ADC
Date: Thu, 15 Dec 2005 16:49:47 -0500
Message-ID: <1134683387.12352.34.camel@Rainsong.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Can someone please verify that they can capture both channels of an
analog source with a SBLive 5.1 EMU10k1/STAC9708-11 card?

Here's my setup:
	SBLive 5.1 Platinum, with a LiveDrive(00060?, manufactured 2000)
	kernel 2.6.14-gentoo-r4
	ALSA drivers 1.0.10_rc3 (also tried above kernel driver)
	enable_ir=1 extin=0x3fff extout=0x7fff

Mixer settings:
	capture CD selected
	capture gain = 0
	AC97 playback = 100
	headphone (LiveDrive) = 100

Source:
	Nine Inch Nails, Things Falling Apart, Track 4, first 10 seconds
	(has a noticeable stereo pan effect).

1) I get the left channel, but not the right channel.

2) Same result if I play back through the SBLive's main speakers, with
the PCM and Master controls unmuted and set to 100. The remaining cases
are played back through the LiveDrive headphone jack, to ensure that the
stream heard is actually the digital capture, and not just the
STAC9708-11's analog passthrough (which works fine for both channels).

3) Same result if I set AC97 capture to 100, and capture using "arecord
-d10 -fdat snd.out" and then play back through the (unmuted, volume=100)
wave device, using "aplay snd.out".

4) Same result for any of the other analog sources, including "mix".

5) "Mix mono" mixes both channels properly, but I still only get the
left stream for playback and capture.

6 I get both channels when playing back or capturing a digital source.

I'm pretty sure that my STAC9708-11's right ADC is fried, but I wanted
to get some second opinions before I went and blew thirty bucks on a
replacement card.

I'm not on the list, so could you please CC to my personal email
address?

Thanks.

-- 
James C. Georgas <jgeorgas@rogers.com>



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
