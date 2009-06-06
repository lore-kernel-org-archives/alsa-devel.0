From: Gernot Kohlhaas <gernot.kohlhaas@googlemail.com>
Subject: Testers wanted: New SB X-Fi driver
Date: Sat, 06 Jun 2009 21:02:42 +0200
Message-ID: <4A2ABD52.8000600@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f218.google.com (mail-fx0-f218.google.com
	[209.85.220.218])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F3D82439E
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Jun 2009 21:02:46 +0200 (CEST)
Received: by fxm18 with SMTP id 18so2253158fxm.32
	for <alsa-devel@alsa-project.org>; Sat, 06 Jun 2009 12:02:45 -0700 (PDT)
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

Hi and thanks for this driver.
It works great and even 6- and 8-Channel-Output is supported now.

The only two little things I noticed are:
1. Most programs are looking for "surround51" to use for multichannel
sound. But this driver only provides the "default"-Device (in it's
description it says:

aplay -L
default:CARD=XFi
    Creative X-Fi, Front/WaveIn
    Default Audio Device

)

2. I can hear a gentle grumbling out of my speakers. But nothing serious.
-- 
http://www.gnupp.de/verschluesselung/warum.html
Key ID: 0x4C0B2250
Key: http://home.arcor.de/mr_maniac/ANDERES/public.gpg
