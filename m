From: Jan Engelhardt <jengelh@inai.de>
Subject: Regression for Lenovo X240 sound in 3.18
Date: Mon, 29 Dec 2014 13:51:36 +0100 (CET)
Message-ID: <alpine.LSU.2.11.1412291303200.30351@nerf08.vanv.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ares08.inai.de (ares08.inai.de [46.4.84.70])
 by alsa0.perex.cz (Postfix) with ESMTP id ECDD8267580
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 13:51:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, mr.bobukas@gmail.com
List-Id: alsa-devel@alsa-project.org


I have a X240 (without any dock), and in Linux 3.17.4, I used to have
- "Speaker" with switch and volume bar (in alsamixer),
- "PCM" with switch and volume bar,
- the headphone output volume would be controlled by both Master and PCM.

With 3.18.1, bisected down to below commit, this all went bonkers.
- "Speaker" has only a switch but no volume bar,
- speakers do not output _any_ sound whatsoever anymore
- changing the PCM volume does not affect either Headphone or Speaker.


commit 7c21539c45eace48e9f6fbdd59347d8416960af5
Author: Lukas Bossard <mr.bobukas@gmail.com>
Date:   Wed Oct 29 18:31:07 2014 +0100

    ALSA: hda - Add ultra dock support for Thinkpad X240.
    
    Adding ultra doch support for Lenovo Thinkpad X240 (17aa:2214).
    [Actually replaced the entry with ALC292_FIXUP_TPT440_DOCK -- tiwai]


Reverting this commit on top of v3.18.1 restores the sought 
functionality.
