From: Jaime T <enopatch@gmail.com>
Subject: usx2y: usx2yhwdeppcm.c gives "should not be here with
 counts=40" (linux 4.9.0)
Date: Fri, 14 Apr 2017 12:03:51 +0100
Message-ID: <CAAbCkmJJ7=bDWaDOC37fNzFmQyf5kvdr0uVjoXOFZj9QmciDsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
 [209.85.218.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E41626696B
 for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2017 13:03:53 +0200 (CEST)
Received: by mail-oi0-f41.google.com with SMTP id b187so89919399oif.0
 for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2017 04:03:53 -0700 (PDT)
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

Hi all.

I'm running a fresh and cleanly-installed debian testing (stretch)
with my tascam us-122. After about 6 hours of perfect, joyous sound,
the kernel (4.9.0-2-686) emits:

should not be here with counts=40

and my jack server stops working. I'm aware that I should be running a
vanilla kernel before logging a bug against the driver - is that my
next step? (it might take a very long time!)

(FWIW, I've run alsa-info.sh and the results are available at
http://www.alsa-project.org/db/?f=f5e0f8f654ef467cedaaed7ae129b02267c46a95)

Many thanks, Jaime
