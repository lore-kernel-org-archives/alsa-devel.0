From: Nathan Gray <n8gray@caltech.edu>
Subject: [BUG] intel8x0: arecord doesn't work
Date: Wed, 27 Aug 2003 01:10:06 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <bihp12$g4o$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

I'm trying to record from the built-in mic in my laptop (Dell Inspiron 4150)
but it doesn't seem to work right.  If I select "Mic" as the capture source
and max out the volume then when I tap the microphone I can hear it loud
and clear in my headphones.  Then I try:

[n8gray@golux patches]$ arecord -d 5 foo.wav
Recording WAVE 'foo.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono

I tap the mic a few times as this is running.  I hear the taps great while
recording, but playing back foo.wav I just hear static, with the taps
barely audible.  Adjusting the recording levels doesn't change anything.  

If I try:

[n8gray@golux patches]$ arecord -f cd -d 5 foo.wav
Recording WAVE 'foo.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo

then I get a 5 second wav file that's completely blank.  As far as I can
tell, any format that's not U8 has the same effect.  

Any ideas of what's going on?  Here's some info about my system:

[n8gray@golux patches]$ cat /home/n8gray/.asoundrc
pcm.intel8x0 {
   type hw
   card 0
}

ctl.intel8x0 {
   type hw
   card 0
}

[n8gray@golux patches]$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 0.9.6.
Compiled on Aug 26 2003 for kernel 2.4.21-0.16mm-mdkcustom.

[n8gray@golux patches]$ cat /proc/asound/cards
0 [I82801CAICH3   ]: ICH - Intel 82801CA-ICH3
                     Intel 82801CA-ICH3 at 0xd800, irq 11

[n8gray@golux patches]$ cat /proc/asound/devices
  0: [0- 0]: ctl
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  1:       : sequencer
 33:       : timer

[n8gray@golux patches]$ cat /proc/asound/modules
0 snd-intel8x0

[n8gray@golux patches]$ cat /proc/asound/pcm
00-00: Intel ICH : Intel 82801CA-ICH3 : playback 1 : capture 1
00-01: Intel ICH - MIC ADC : Intel 82801CA-ICH3 - MIC ADC : capture 1

Let me know if there's anything else you need to know.

Thanks,
-Nathan

-- 
>>>-- Nathaniel Gray -- Caltech Computer Science ------>
>>>-- Mojave Project -- http://mojave.cs.caltech.edu -->



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
