From: Tommi Uimonen <tee.uimonen@gmail.com>
Subject: ice1712 suspend/resume for M-Audio Audiophile 2496
Date: Sat, 13 Jul 2013 01:32:09 +0300
Message-ID: <CA+Z4o-rKcFYAcq_ug8gpt80bMiJn71bbHkzXz1cjbj2tsHtbOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f46.google.com (mail-qe0-f46.google.com
 [209.85.128.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 075A6265A76
 for <alsa-devel@alsa-project.org>; Sat, 13 Jul 2013 00:32:10 +0200 (CEST)
Received: by mail-qe0-f46.google.com with SMTP id nd7so5389933qeb.19
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 15:32:10 -0700 (PDT)
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

Hello, the lack of suspend/resume support for ice1712 driver has been
bugging me a lot, and I was wondering if it's possible to implement it
by following how it's done in 1724.c?

I don't really know much about the driver, but after some comparison
between 1712.c and 1724.c it seems doable.

At least the suspend part seems straightforward, just changing
ICEMT1724 with ICEMT and ICEREG1724 with ICEREG. To resume, I should
add some new functions like snd_ice1712_chip_reset (I guess it follows
the same logic as in 1724.c, just use ICE1712_RESET instead) and maybe
some spdif stuff but I think the 1724 has different spdif options. I
don't have any 1724 cards so can't be sure, but 1712 does not have
spdif rate. Maybe it will work without those, at least for me since I
don't use spdif.

And then add this to the pci_driver ice1712_driver struct:

.driver = {
.pm = SND_ICE1712_PM_OPS,
}

and define the SIMPLE_DEV_PM_OPS accordingly.

Or is this already under work by someone?

Tommi
