From: Tobias Schneider <tobsnyder@gmx.de>
Subject: overrun in second capture device after stopping first
	capture device
Date: Thu, 21 Jan 2010 13:40:24 +0100
Message-ID: <4B584B38.9030000@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 0C43A243C6
	for <Alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 13:40:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear ALSA Dev-Team,

while testing my driver, I figured out that under some circumstances 
there occur overruns when recording two streams:

first I startet a long capture at device 1:

-bash-3.2#
-bash-3.2# arecord -D hw:0,1 -d 180 -r 32000 -c 1 -t wav -f S16_LE 
arecord_049.wav
Recording WAVE 'arecord_049.wav' : Signed 16 bit Little Endian, Rate 
32000 Hz, Mono
overrun!!! (at least 121.536 ms long)
overrun!!! (at least 115.361 ms long)
overrun!!! (at least 190.883 ms long)
overrun!!! (at least 121.772 ms long)
overrun!!! (at least 119.487 ms long)

In another terminal, I started a second capture on the second device. 
Everytime
this capture is done, I got an overrun in the first capture (see above)

-bash-3.2#                                                                                                                                              
 
-bash-3.2# arecord -D hw:0,0 -d 15 -r 32000 -c 1 -t wav -f S16_LE 
arecord_047.wav
Recording WAVE 'arecord_047.wav' : Signed 16 bit Little Endian, Rate 
32000 Hz, Mono
-bash-3.2# arecord -D hw:0,0 -d 15 -r 32000 -c 1 -t wav -f S16_LE 
arecord_047.wav
Recording WAVE 'arecord_047.wav' : Signed 16 bit Little Endian, Rate 
32000 Hz, Mono
-bash-3.2# arecord -D hw:0,0 -d 15 -r 32000 -c 1 -t wav -f S16_LE 
arecord_047.wav
Recording WAVE 'arecord_047.wav' : Signed 16 bit Little Endian, Rate 
32000 Hz, Mono
-bash-3.2# arecord -D hw:0,0 -d 15 -r 32000 -c 1 -t wav -f S16_LE 
arecord_047.wav
Recording WAVE 'arecord_047.wav' : Signed 16 bit Little Endian, Rate 
32000 Hz, Mono
-bash-3.2# arecord -D hw:0,0 -d 15 -r 32000 -c 1 -t wav -f S16_LE 
arecord_047.wav
Recording WAVE 'arecord_047.wav' : Signed 16 bit Little Endian, Rate 
32000 Hz, Mono
-bash-3.2#

It seems, that the duration of the overrun relates to the capture time 
of the second capture, as it increases with bigger capture times. But if 
capture times are bigger than 25s, it seems there is no overrun...just 
some logs to clarify:

First Terminal:
-bash-3.2#
-bash-3.2# arecord -D hw:0,1 -d 180 -r 32000 -c 1 -t wav -f S16_LE 
arecord_049.wav
Recording WAVE 'arecord_049.wav' : Signed 16 bit Little Endian, Rate 
32000 Hz, Mono
overrun!!! (at least 99.074 ms long)

Second Terminal:
-bash-3.2#
-bash-3.2# arecord -D hw:0,0 -d 30 -r 32000 -c 1 -t wav -f S16_LE 
arecord_047.wav  
Recording WAVE 'arecord_047.wav' : Signed 16 bit Little Endian, Rate 
32000 Hz, Mono
-bash-3.2# arecord -D hw:0,0 -d 30 -r 32000 -c 1 -t wav -f S16_LE 
arecord_047.wav
Recording WAVE 'arecord_047.wav' : Signed 16 bit Little Endian, Rate 
32000 Hz, Mono
-bash-3.2# arecord -D hw:0,0 -d 30 -r 32000 -c 1 -t wav -f S16_LE 
arecord_047.wav
Recording WAVE 'arecord_047.wav' : Signed 16 bit Little Endian, Rate 
32000 Hz, Mono
-bash-3.2# arecord -D hw:0,0 -d 15 -r 32000 -c 1 -t wav -f S16_LE 
arecord_047.wav
Recording WAVE 'arecord_047.wav' : Signed 16 bit Little Endian, Rate 
32000 Hz, Mono
-bash-3.2#


First Terminal:
-bash-3.2# arecord -D hw:0,1 -d 180 -r 32000 -c 1 -t wav -f S16_LE 
arecord_049.wav
Recording WAVE 'arecord_049.wav' : Signed 16 bit Little Endian, Rate 
32000 Hz, Mono
overrun!!! (at least 193.656 ms long)


Second Terminal:
-bash-3.2# arecord -D hw:0,0 -d 25 -r 32000 -c 1 -t wav -f S16_LE 
arecord_047.wav
Recording WAVE 'arecord_047.wav' : Signed 16 bit Little Endian, Rate 
32000 Hz, Mono
-bash-3.2# arecord -D hw:0,0 -d 20 -r 32000 -c 1 -t wav -f S16_LE 
arecord_047.wav
Recording WAVE 'arecord_047.wav' : Signed 16 bit Little Endian, Rate 
32000 Hz, Mono
-bash-3.2#


So I am wondering why such an overrun occurs, can someone please give me 
some hints what my be the reason?

Thanks in Advance!
Tobias
