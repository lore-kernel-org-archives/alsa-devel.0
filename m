From: maruthi srinivas <maruthi.srinivas.b@gmail.com>
Subject: compressed audio support
Date: Sun, 1 Dec 2013 23:23:06 +0530
Message-ID: <CANv6ZMbWdO9F0DPeTwWHwo9mn5Xp1zuewS7U6tK9JCsMhVX9rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f53.google.com (mail-pb0-f53.google.com
 [209.85.160.53])
 by alsa0.perex.cz (Postfix) with ESMTP id EBDE02608E8
 for <alsa-devel@alsa-project.org>; Sun,  1 Dec 2013 18:53:07 +0100 (CET)
Received: by mail-pb0-f53.google.com with SMTP id ma3so17403150pbc.12
 for <alsa-devel@alsa-project.org>; Sun, 01 Dec 2013 09:53:06 -0800 (PST)
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

I saw that compressed audio framework being used with Asoc (alsa soc).
Can the framework be used with other than Asoc ? I mean with ALSA pci based
cards.

I see the implementation in the following files. which one is to be used ?
Does tinycompress in userspace can be used with either approaches ?

http://lxr.free-electrons.com/source/sound/core/compress_offload.c
http://lxr.free-electrons.com/source/sound/soc/soc-compress.c


Regards,
Maruthi
