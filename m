From: Nathaniel Gray <n8gray@caltech.edu>
Subject: recording issues
Date: Wed, 1 Oct 2003 14:34:29 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310011434.29210.n8gray@caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

My sound card uses different devices for capture (device 0) and playback 
(device 1).  I have two issues with capture right now:

1.  If I do something like:
	arecord -f dat -D hw:0,1 -d 5 foo.wav
it seems to record for much longer than 5 seconds.  In fact, "time 
arecord..." tells me that it goes for 10 seconds.  If I then try to 
play back the result with aplay:
	aplay foo.wav
the playback is too fast.  The same thing happens with the -f cd format.  
I thought I'd try forcing mono recording but:
[n8gray@golux alsa]$ arecord -D hw:0,1 -c 1 -r 48000 -f S16_LE -d 5 
foo.wav
Recording WAVE 'foo.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, 
Mono
arecord: set_params:833: Channels count non available


2.  Is there a way to make the OSS emulation use hw:0,0 as the playback 
device and hw:0,1 as the capture device?

Here's some info:
[n8gray@golux alsa]$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 0.9.7a.
Compiled on Oct  1 2003 for kernel 2.4.21-0.16mm-mdkcustom.

[n8gray@golux alsa]$ cat /proc/asound/cards
0 [I82801CAICH3   ]: ICH - Intel 82801CA-ICH3
                     Intel 82801CA-ICH3 at 0xd800, irq 11

[n8gray@golux alsa]$ cat /proc/asound/devices
  0: [0- 0]: ctl
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  1:       : sequencer
 33:       : timer

Can anybody help?

Thanks,
-Nathan

-- 
>>>-- Nathaniel Gray -- Caltech Computer Science ------>
>>>-- Mojave Project -- http://mojave.cs.caltech.edu -->




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
