From: Alexandre Bique <bique.alexandre@gmail.com>
Subject: Getting stable PCM device id
Date: Wed, 8 Jul 2015 17:19:27 +0200
Message-ID: <CAP737oJhCD_20qobOBZYfy60e0mXEjO9OP8hmxb3J5bod=ZDvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com
 [209.85.215.42])
 by alsa0.perex.cz (Postfix) with ESMTP id BB90A2615F7
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 17:19:47 +0200 (CEST)
Received: by laar3 with SMTP id r3so228164497laa.0
 for <alsa-devel@alsa-project.org>; Wed, 08 Jul 2015 08:19:47 -0700 (PDT)
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

Hi,

I wonder how to get a PCM identifier that would be stable if you
reboot or plug/unplug sound cards in a random order.

I want to be able to store a sound card configuration and be able to
restore it without relying on the card index or the device name,
because if you have two times the same sound card it is not going to
be unique.

I'm not an expert in hardware ids, yet I imagine that we could use the
hardware serial number or equivalent?

Thank you very much,
-- 
Alexandre Bique
