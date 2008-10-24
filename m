From: Jelle de Jong <jelledejong@powercraft.nl>
Subject: bluetooth alsa and software mixing
Date: Fri, 24 Oct 2008 19:39:13 +0200
Message-ID: <49020841.5020802@powercraft.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020200050105070505010102"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from node03.cambriumhosting.nl (node03.cambriumhosting.nl
	[217.19.16.164]) by alsa0.perex.cz (Postfix) with ESMTP id 8EF0D245BB
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 19:39:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by node03.cambriumhosting.nl (Postfix) with ESMTP id 0A3C9B000301
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 19:39:16 +0200 (CEST)
Received: from node03.cambriumhosting.nl ([127.0.0.1])
	by localhost (node03.cambriumhosting.nl [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id Pns7B0JUX9Kq for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 19:39:15 +0200 (CEST)
Received: from ashley.powercraft.nl (84-245-3-195.dsl.cambrium.nl
	[84.245.3.195])
	by node03.cambriumhosting.nl (Postfix) with ESMTP id 64D4AB0002F6
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 19:39:15 +0200 (CEST)
Received: from [192.168.1.180] (unknown [192.168.1.180])
	by ashley.powercraft.nl (Postfix) with ESMTPSA id 387EF23BC6E9
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 19:39:15 +0200 (CEST)
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

This is a multi-part message in MIME format.
--------------020200050105070505010102
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everybody,

I have a bunch of bluetooth audio devices, and I can currently only play
one audio stream as once, and i would like to be able to listen to radio
and other sounds at the same time. So i think some sort of software
mixing is needed to get this working. I attached my .asound / also
configuration. How can I configure my bluetooth system so that I can
listen to different sources of audio at the same time?

Thank for any information in advance,

Kind regards,

Jelle

--------------020200050105070505010102
Content-Type: application/x-sh;
 name="setup-bluetooth-motorola-s805.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setup-bluetooth-motorola-s805.sh"

#!/bin/bash

echo 'pcm.headset {
    type bluetooth
    #~ device 00:0D:18:A0:35:70
    #~ device 00:53:53:FB:7E:9C # Nokia BH-801
    device 00:0C:55:D1:C9:78 # Motorola S805
    #~ device 00:0D:FD:18:6E:3C # Motorola S9
    #~ device 20:07:09:15:A9:5A # Samsung WEP210
    profile hifi
    #~ profile voice
    #profile auto
}
pcm.softvol {
    type softvol
    slave.pcm headset
    control.name Headset
    control.card 0
}
pcm.!default {
    #~ type hw
    #~ card 0
    type plug
    slave.pcm softvol
}' > ~/.asoundrc

sudo /etc/init.d/bluetooth restart
sudo /etc/init.d/alsa-utils restart

exit

--------------020200050105070505010102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020200050105070505010102--
