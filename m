From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: USB224_usbsnoop1.log captured on WinXP
Date: Fri, 2 Apr 2004 14:34:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404021434.26528.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

It shows the same light switching as is already implemented:
	grep -n ": 19" USB224_usbsnoop1.log 
gives us pre INPUT MONITOR pressed
	21501:    00000000: 19 00 1a 00 1b 00 1c 00 1d 11 1e 00 1f 00
and post
	21941:    00000000: 19 00 1a 00 1b 00 1c 02 1d 01 1e 00 1f 00
the 8th byte changing from 0 to 2 is the actual INPUT MONITOR Led switch on.

see us428control:
	void us428_lights::init_us428_lights()
	void us428_lights::LightSet(eLight L, bool Value)
with
	enum eLight{
		eL_InputMonitor = 25
	};
the same urb as in the log should be sent to the us224 on linux.
for the us428 it works. not for the us224.

So please try the following patch:
>>>
--- alsa-driver/usb/usx2y/usbusx2yaudio.c	30 Mar 2004 08:27:16 -0000	1.9
+++ alsa-driver/usb/usx2y/usbusx2yaudio.c	2 Apr 2004 11:55:21 -0000
@@ -1245,7 +1245,7 @@
 	    					     snd_dma_continuous_data(GFP_KERNEL),
 						     usX2Y_capt_substream->endpoints * 64*1024,
 						     usX2Y_capt_substream->endpoints * 128*1024)) ||
-	    (usX2Y(card)->chip.dev->descriptor.idProduct == USB_ID_US428 &&
+	    (usX2Y(card)->chip.dev->descriptor.idProduct != USB_ID_US122 &&
 	     0 > (err = usX2Y_rate_set(usX2Y_stream, 44100)))) {	// Lets us428 
recognize output-volume settings, disturbs us122.
 		snd_usX2Y_audio_stream_free(usX2Y_stream);
 		return err;
<<<

if the us428 doesn't get the "usX2Y_rate_set(usX2Y_stream, 44100)" at startup, 
it later behaves ignorant to light & volume setting. like us224 behaves now.

If we get the INPUT MONITOR Led enlightened, the Volume settings should also 
work with respect to direct monitoring at least. 
US224 Master Fader seams to b where US428's Fader5 is. That needs adjustment 
in us428control.

The data sent to set us224 internal mixers is filtered out with
	grep -n "00: 0[0123456789] .. .. .. ..$" USB224_usbsnoop1.log
it gives i. e.:
	11721:    00000000: 00 00 25 00 25
	11732:    00000000: 01 00 25 00 25
	11743:    00000000: 02 00 25 00 25
	11754:    00000000: 03 00 25 00 25
	11831:    00000000: 04 00 42 00 42

look at struct usX2Y_volume and its methods. it should fit the us224.
But lets get that Leds enlighted first :-)


Cheers,
Karsten




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
