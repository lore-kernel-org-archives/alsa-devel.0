From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: question to some webcam issue
Date: Fri, 11 Nov 2011 09:21:59 +0100
Message-ID: <4EBCDB27.7030306@fisher-privat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id CF47124467
	for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2011 09:22:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi all,

i working on some issues of usb webcams, especially my current priority 
is uvcvideo driver. with some previous kernel version i expoirianced 
some really nasty crashes if i used skype. i think the problem was the 
control short timeout for control traffic. i think it was encreesed now 
to 1000 again.

on one side i do not have this problem any more, but on other side i 
think it should be prewented for future.

Description of problem (the way i think it is):
- skype usually use really intensively volume controls for echo 
cancellation and proper record level.
- if webcam sound is used then video traffic encreese control delays for 
audio.
- if usb-audio sees this big delay, it will reset the usb device ... 
complete, even video part.
- in this situation many part will die... uvcvideo will be reseted and 
need to cut access to /dev/video0 the capture programm will freeze for 
ever. pulseaudio freeze as well and some time you need to restart 
computer to bring it all back.

i know, other parts should be more error resistant, but may be we can 
prevent at least a part of it. For example do some sort of usb lock if 
one device has two different interfaces and two of them used, one should 
not kill another one?

Hope you understand my description,

Regards,
Alexey.
