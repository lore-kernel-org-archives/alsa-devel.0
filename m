From: Lee Revell <rlrevell@joe-job.com>
Subject: emu10k1 device naming
Date: Sun, 25 Jul 2004 00:29:27 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1090729766.1952.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: tiwai@suse.de, pzad@pobox.sk
List-Id: alsa-devel@alsa-project.org

Now that the emu10k1 driver supports low latency, multichannel capture,
it would be useful to rearrange the devices.  Currently you have to use
hw:0,0 for playback, and hw:0,2 for capture.  This works down to 32
frames (you have to record more than 2 channels to get 32 frames,
because 512 bytes is the smallest period JACK supports).  JACK requires
the playback and capture device to be the same for both directions.

The current hw:0,0 device could be moved to hw:0,2.  This is the best
arrangement, because these are the only two devices that it makes sense
to use for full-duplex.  The hw:0,2 playback device is a special AC3
passthrough device, there is no capture device that corresponds to it. 
The same applies to the current hw:0,0 (ADC capture) and hw:0,1 (mic
capture - 8000 Hz) devices, there is no corresponding playback device.

It was suggsted to use the 'asym' PCM plugin for this, but JACK does not
support using a PCM as the device name, you need to give it a hardware
device.

Lee 





-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
