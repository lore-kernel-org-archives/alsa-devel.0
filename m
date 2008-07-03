From: Matthias Dahl <ml_alsa@mortal-soul.de>
Subject: Sound distortions with Realtek ALC889A
Date: Thu, 3 Jul 2008 13:15:17 +0200
Message-ID: <200807031315.18249.ml_alsa@mortal-soul.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GTLbI/Egu6diCjW"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dd15922.kasserver.com (dd15922.kasserver.com [85.13.137.18])
	by alsa0.perex.cz (Postfix) with ESMTP id 03A972489B
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jul 2008 13:15:20 +0200 (CEST)
Received: from marvin (88-134-158-176-dynip.superkabel.de [88.134.158.176])
	by dd15922.kasserver.com (Postfix) with ESMTP id 0CC3D2C73E23D
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jul 2008 13:15:22 +0200 (CEST)
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

--Boundary-00=_GTLbI/Egu6diCjW
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello.

Due to a hw defect, I recently bought a Gigabyte X48-DQ6 board which utilizes 
a Realtek ALC889A for sound output. At first glance everything seemed fine 
but during day-to-day use I figured that during playback of a 5.1 file, I've 
to turn up the volume quite a bit to match normal 2.0 playback or the volume 
levels of my old board (ADI1988B). And to make matters worse, the surround 
channel produces (static) noise on the center channel. If I mute every 
channel but the surround channel, the distortions are clearly hearable. 
During normal 5.1 playback, they are only hearable during scenes with a lot 
of talk or quieter scenes which is still very annoying unfortunately. Muting 
the surround channel also stops the distortions on the center channel.

Also the model is not properly recognized, I've to pass model=6stack-dig to 
get all channels properly working with digital out.

By the way, this is with a 2.6.26-rc7 x86_64 kernel running a alsa git 
checkout from last monday.

I'd appreciate any help or hints I can get. Thanks in advance.

Best regards,
Matthias Dahl

--Boundary-00=_GTLbI/Egu6diCjW
Content-Type: text/plain;
  charset="us-ascii";
  name="cards.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cards.txt"

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xea400000 irq 310

--Boundary-00=_GTLbI/Egu6diCjW
Content-Type: application/x-zip;
  charset="us-ascii";
  name="devices.txt.zip"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="devices.txt.zip"

UEsDBBQAAAAIADhp4zjXnAOvgwAAABkBAAALAAAAZGV2aWNlcy50eHR9z0sKAjEQBND9nKIuICQz
fiBXkVm0SaPBmMSYIN7eRkacTexl8yiqAGVwhJoBGNgUa0lhALTBcgYPvjeOlov89x+9wTgbXKi4
JxWG48zRcawD9BcoAc6ffaUAas4n5ECvE9mroMOC9B80brtJlnJthcXsukE/s67cMdO0mlv9Taa+
AVBLAQIUAxQAAAAIADhp4zjXnAOvgwAAABkBAAALAAkAAAAAAAAAAACkgQAAAABkZXZpY2VzLnR4
dFVUBQAHfbNsSFBLBQYAAAAAAQABAEIAAACsAAAAAAA=

--Boundary-00=_GTLbI/Egu6diCjW
Content-Type: text/plain;
  charset="us-ascii";
  name="pcm.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pcm.txt"

00-02: ALC882 Analog : ALC882 Analog : capture 2
00-01: ALC882 Digital : ALC882 Digital : playback 1 : capture 1
00-00: ALC882 Analog : ALC882 Analog : playback 1 : capture 1

--Boundary-00=_GTLbI/Egu6diCjW
Content-Type: application/x-zip;
  charset="us-ascii";
  name="proc.interrupts.txt.zip"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="proc.interrupts.txt.zip"

UEsDBBQAAAAIADhp4zgI+y1SwgEAABkFAAATAAAAcHJvYy5pbnRlcnJ1cHRzLnR4dJWT3W6jMBCF
73kKX+5KjeQxxti9y7KVipS0EWmvVxTcYi2BiJ/u6+8QINjbZKUgIR1gvjkz44GQ8xXtXukiYZIe
IfT+HCODJV7iHT+v1rs4Wun8Q49vO3PQDUKwQARc+RUyknKGkLIg6soZek/bTtcG36TZ0XgEmMUw
V141AjFCIAKAcJI88MVFo77IzK8iy+/79s2/I9WnyU2KSeTk7DPJ2VkCv5hEW0ngzskZuI8SU982
CITdFKFH2HRqjCvK2CyVvJyiTdMQuCDf6HdE4RZ325cjvJwH0MCV/8IY7d9iZc+QuR0Lz4epY6BU
BXSW46Huoni13cfWJjz+XJO46nSJ4NwvV2wuGeVpVF/BYdrInNtkgfAXCRcZ3RXUe9rG15t9qqvV
IW1/p2+lJgbrapr+2LXe5jk6QcxXEFJxaoqHQshBbuosLcc/zmaSh/1oJKgK2bjeRHChhjVIdJsV
Ou9LU33YULTezNX5VEzrzJgMB/69r7LO1BVBv9KmXjY/JopRIdUkgfOhPPxI2qKuu7z+U2Fssr3e
/0uhmwM2oz911TkOj8n/qEajQ5mTYVNsbL97vY7tj31j6r61gYfE8fH+AlBLAQIUAxQAAAAIADhp
4zgI+y1SwgEAABkFAAATAAkAAAAAAAAAAACkgQAAAABwcm9jLmludGVycnVwdHMudHh0VVQFAAd8
s2xIUEsFBgAAAAABAAEASgAAAPMBAAAAAA==

--Boundary-00=_GTLbI/Egu6diCjW
Content-Type: application/x-zip;
  charset="us-ascii";
  name="proc.asound.Intel.codec2.txt.zip"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="proc.asound.Intel.codec2.txt.zip"

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

--Boundary-00=_GTLbI/Egu6diCjW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_GTLbI/Egu6diCjW--
