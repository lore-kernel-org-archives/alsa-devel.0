From: Joshua N Pritikin <vishnu@pobox.com>
Subject: S/PDIF RCA IEC958 C-Media PCI CMI8738 - can't record
Date: Fri, 4 Oct 2002 08:41:39 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021004031139.GB705@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: cltien@cmedia.com.tw, support@cmedia.com.tw
Cc: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have an Iwill DVD266-uRN with CMI8738 sound.  I'm trying to record
through the RCA S/PDIF Input port.  My system is Linux 2.4.19 i386 SMP.

I tried both C-Media's driver and the driver from the stock 2.4.19
kernel.  S/PDIF RCA Output works but S/PDIF RCA Input doesn't
work for either.  I also tried:

  http://member.nifty.ne.jp/Breeze/softwares/unix/cmictl-e.html

When i turn on Monitor then my analogue speakers output static.

I also tried Alsa 9.0rc1 CMIPCI driver.  Playback works fine but
recording looks like this:

joshua@remix:~$ arecord -v -D spdif -t wav -f S16_LE -r 44100 -c 2 iectest
Recording WAVE 'iectest' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Hooks PCM
Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 16384
period_size  : 4096
period_time  : 92879
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4096
xfer_align   : 4096
start_threshold  : 1
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Slave: Hardware PCM card 0 'C-Media PCI CMI8738-MC6' device 2 subdevice -1

Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 16384
period_size  : 4096
period_time  : 92879
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4096
xfer_align   : 4096
start_threshold  : 1
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Max peak (8192 samples): 32767 (0x7fff) #################### 100%
Max peak (8192 samples): 32767 (0x7fff) #################### 100%
Max peak (8192 samples): 32767 (0x7fff) #################### 100%
Max peak (8192 samples): 32767 (0x7fff) #################### 100%
...

When i disconnect the cable then i get an I/O error so it is
*somewhat* connected.  However, i can't get a normal recording.

The ALSA Soundcard Matrix clearly claims that "RCA IEC958 Input"
is supported with the CMI8738.  Is this untrue?

-- 
Victory to the Divine Mother!!         after all,
  http://sahajayoga.org                  http://why-compete.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
