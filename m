From: Chris Raphael <raphael@math.umass.edu>
Subject: unwanted echo of audio input
Date: Sun, 15 Jun 2003 13:08:13 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306151708.h5FH8Da27641@fafner.math.umass.edu>
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


Alsa Folks,
  I am using ALSA 9.0 on a Dell Inspiron 8200 which uses the Intel 
82801CA-ICH3 card and CS4205 chip set.  I am writing a program
that simulaneaously samples and plays audio.  The problem I am
having is that everything that is captured by the microphone is
automatically echoed to the speaker.  I have tried all of the
mixer settings I can think of using alsamixer and cannot make the
problem go away.  I have also tried to fix the problem from a c
program using the OSS-style commands

  fd = open("dev/mixer",O_RDWR);
  vol = 0;	
  ioctl(fd,MIXER_WRITE(SOUND_MIXER_IMIX),&vol);
 
but without success --- the volume value is set to 0, as it should be,
but no change in what actually happens.  (All of my other sound-related
code uses the ALSA API).  
  

I am thinking that it is possible to avoid this echoing since, using
Windows, I was able to play from the cd and record without a similar
mixing of input and output on the same machine.

I would really appreciate any help with this.  It might not be relevant,
but the program I'm working on is an automatic accompaniment system.
The input is the soloist's musical sound signal and the output is
the orchestra recording, warped to follow the soloist.
There are some nice examples on my the web page: 

 http://fafner.math.umass.edu/music_plus_one

Christopher Raphael


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
