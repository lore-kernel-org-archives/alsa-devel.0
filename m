From: prashant chopade <prashantchopade@yahoo.com>
Subject: aplay: set_params:984: Channels count non available
Date: Mon, 17 Aug 2009 18:44:00 +0530 (IST)
Message-ID: <441745.41319.qm@web94705.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n7-vm0.bullet.mail.in.yahoo.com
	(n7-vm0.bullet.mail.in.yahoo.com [202.86.4.134])
	by alsa0.perex.cz (Postfix) with SMTP id 2FABD246EB
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 15:14:02 +0200 (CEST)
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

Hello,

I am using alsa library 1.0.20.
I am using linux-2.6.27.

But I have shown certain useful messages:

# cat /etc/asound.conf
pcm.!default { type hw card 0 } ctl.!default { type hw 
card 0 }

# aplay -l
**** List of PLAYBACK Hardware Devices 
****
card 0: AC97 [Atmel AC97], device 0: Atmel AC97 [Atmel 
AC97]
Subdevices: 1/1
Subdevice #0: subdevice #0


# aplay 
/home/Front_Center.wav -c 1
Playing WAVE '/home/Front_Center.wav' : Signed 16 
bit Little Endian, Rate 48000
Hz, Mono
aplay: set_params:984: Channels 
count non available

To remove this error which channel i have to used or 
set and how?

Thanks & Regards,
Prashant C.




      Looking for local information? Find it on Yahoo! Local http://in.local.yahoo.com/
