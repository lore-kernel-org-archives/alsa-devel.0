From: =?ISO-8859-15?Q?Richard_K=F6rber?= <alsa@ml.shredzone.de>
Subject: SoundBlaster X-fi HD SPDIF fix
Date: Sun, 06 Apr 2014 23:36:31 +0200
Message-ID: <5341C8DF.9020604@ml.shredzone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arrietty.shredzone.net (arrietty.shredzone.net [176.9.40.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A7D7260859
 for <alsa-devel@alsa-project.org>; Sun,  6 Apr 2014 23:36:33 +0200 (CEST)
Received: from xdsl-84-44-176-158.netcologne.de ([84.44.176.158]
 helo=localhost.localdomain)
 by arrietty.shredzone.net with esmtpsa (TLSv1:AES128-SHA:128)
 (Exim 4.72) (envelope-from <alsa@ml.shredzone.de>)
 id 1WWujw-0005gL-BD
 for alsa-devel@alsa-project.org; Sun, 06 Apr 2014 23:36:32 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

I own a Creative USB SoundBlaster X-fi HD and tried to use its SPDIF optical
output. However it didn't work with ALSA out of the box. The reason is that
for SPDIF output device #1 must be used.

The fix is: In /usr/share/alsa/cards/USB-Audio.conf, change the iec958_devi=
ce
block like this:

USB-Audio.pcm.iec958_device {
        "USB Sound Blaster HD" 1
}

Digital output works fine for me after that.

BTW, I tried this line in /etc/asound.conf

  cards.USB-Audio.pcm.iec958_device."USB Sound Blaster HD" 1

but it didn't have any effect. Why was that?

Thank you!

Regards
Richard K=F6rber
