From: Sayem Ahmed <sayem64@gmail.com>
Subject: Opening a PCM device in shared mode
Date: Sun, 20 Nov 2011 14:54:30 +0600
Message-ID: <4EC8C046.4030706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 721A724784
	for <alsa-devel@alsa-project.org>; Sun, 20 Nov 2011 09:54:45 +0100 (CET)
Received: by faaa20 with SMTP id a20so5619046faa.38
	for <alsa-devel@alsa-project.org>; Sun, 20 Nov 2011 00:54:43 -0800 (PST)
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

Hello all,

I am a beginner in ALSA API. I am developing a sound application where I 
need to open a PCM device for recording/playback audio data. I want to 
open this device in shared mode so that other applications can use the 
same device. I have downloaded the example ALSA program from here 
<http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html> 
and run it on my PC. It works fine when it runs alone. But when I start 
a song on a media player and then run this example, it shows an error 
saying -

|Playback  open error:  Device  or resource busy

|

Looking at the source code of this example I could say that 
thesnd_pcm_open 
<http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#gb7eaaec6f27e4ca48cada9795cd2479b>function 
at line 882 is throwing this error. It finds the device busy since 
another process is currently using it. I also tried the reverse way - 
first started the example then tried to start a song. In this case the 
media player stays idle, showing "idle" just beside the progress bar (I 
am using Banshee). I am assuming that snd_pcm_open gains exclusive right 
of the device resource so that no other process can use it.

But I don't want that. I want to play sound to a audio device without 
requiring any exclusive rights so that other processes in the PC can 
share the same device for outputting audio data.

How can I do that? How can I open a PCM device so that other processes 
can also share the same device?

P.S. : I have two sound cards on my system, one is built-in in 
motherboard, another one is a USB Card. I tried opening the USB (by 
specifying "plughw:1,0" as argument in the snd_pcm_open) card and then 
got this error.


Thank you in advance.



Regards,
Sayem Ahmed
