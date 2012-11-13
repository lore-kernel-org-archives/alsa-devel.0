From: Dan MacDonald <allcoms@gmail.com>
Subject: CM6206, S/PDIF + JACK
Date: Tue, 13 Nov 2012 11:41:18 +0000
Message-ID: <CANOoOjsvRWz6N7eUgJRyFohqih4_d9-sCXhHpWs3M7i4wXjbWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id C879E260309
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 12:41:19 +0100 (CET)
Received: by mail-vc0-f179.google.com with SMTP id f13so7051479vcb.38
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 03:41:19 -0800 (PST)
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

Hi ALSA devs!

I've got a Startech USB device based on the CM6206 chipset. It does work
with JACK although I can only access the two mic inputs as JACK capture
ports even though under alsamixer I can also see line in and SPDIF In. I
bought it in the hope of using its SPDIF input under JACK.

SPDIF is enabled under alsamixer and even when I start JACK with a signal
coming in to SPDIF, I still get no SPDIF capture port.I have posted various
ALSA logs and more details here:

http://www.linuxmusicians.com/viewtopic.php?f=27&t=8898

I've already spoke to las about this but he couldn't help me, no knowing
anything about these devices.

Might I be able to get this working under JACK? Maybe I need a special ALSA
config to enable SPDIF?

Thanks!

Dan
