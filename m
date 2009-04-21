From: Mihai Tanasescu <mihai@duras.ro>
Subject: PS3 Eye Microphone support
Date: Tue, 21 Apr 2009 07:53:57 +0300
Message-ID: <49ED5165.50608@duras.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from thor.allsoft.ro (thor.ang.ro [85.204.231.208])
	by alsa0.perex.cz (Postfix) with ESMTP id 4523024541
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Apr 2009 06:54:34 +0200 (CEST)
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

Hello guys,



I don't know if this is the proper list to address the question but here 
it goes and sorry if I'm wrong.

I wanted to ask if there is any support for the Playstation3 Eye USB 
Camera Microphone provided by alsa at the moment or if there are plans 
to support it.

Currently from what I could figure out:

root@Mihai:~# cat /proc/asound/cards
 0 [Audigy         ]: Audigy - Audigy 1 [SB0090]
                      Audigy 1 [SB0090] (rev.3, serial:0x531102) at 
0xb880, irq 23
 1 [CameraB304061  ]: USB-Audio - USB Camera-B3.04.06.1
                      OmniVision Technologies, Inc. USB 
Camera-B3.04.06.1 at usb-0000:00:1d.7-5.1, hi

the Microphone Camera is seen there.


I successfully recorded something using Audacity and the OSS driver that 
was reported in the recording options.

What I can't do is control the sound levels via the gnome volume control 
applet (which uses alsactl store and restore).

Also, alsamixer won't work.

root@Mihai:~# alsactl store
alsactl: get_control:262: Cannot read control '2,0,0,Mic Capture 
Volume,0': Invalid argument


root@Mihai:~# alsamixer -c 1

alsamixer: function snd_mixer_load failed: Invalid argument


Cheers,
Mihai
