From: Tomas Pospisek <tpo2@sourcepole.ch>
Subject: Request for HW auto-recognition: HP Pavilion dv7 with
	STAC92xx
Date: Wed, 12 Dec 2012 18:08:25 +0100
Message-ID: <f1d85d07d48763e792148f67cb6f842c@sourcepole.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from brisi.sourcepole.ch (brisi.sourcepole.ch [5.9.57.43])
 by alsa0.perex.cz (Postfix) with ESMTP id EA73A26028E
 for <Alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 18:08:36 +0100 (CET)
Received: from brisi-br ([192.168.138.1] helo=sourcepole.ch)
 by vilan-mail with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.80) (envelope-from <tpo2@sourcepole.ch>) id 1TipnK-0005lf-Pc
 for Alsa-devel@alsa-project.org; Wed, 12 Dec 2012 18:08:36 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I have a HP Pavilion dv7 laptop (LS066EA#UUZ), with:

  # cat /proc/asound/card0/codec* | grep Codec
  Codec: IDT 92HD81B1X5
  Codec: Intel CougarPoint HDMI

when play sound without any tweaks, I get a very weak sound output. If I
want to have "beats audio", that is subwoofer and all speakers, I need to
set:

  # cat /etc/modprobe.d/alsa-base.conf 
  options snd-hda-intel model=hp-dv7-4000

Could the snd_hda_intel alsa driver be updated to recognize and setup the
driver accordingly?

alsa-info.sh output here:

 
http://www.alsa-project.org/db/?f=54ea874f43f12c1572aff3ee3113dc4b0ad0b398

Thanks,
*t
