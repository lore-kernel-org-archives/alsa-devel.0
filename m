From: Daniel Drake <drake@endlessm.com>
Subject: Neverending HDA pin quirks, how does Windows cope?
Date: Thu, 28 Jul 2016 11:59:09 -0600
Message-ID: <CAD8Lp470UQhi9JXbaN-V3f-grC9Hk1A0voavUemKgj0R0KvVig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
 [209.85.218.54])
 by alsa0.perex.cz (Postfix) with ESMTP id CD210266922
 for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2016 19:59:10 +0200 (CEST)
Received: by mail-oi0-f54.google.com with SMTP id l65so73819876oib.1
 for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2016 10:59:10 -0700 (PDT)
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
Cc: Endless Linux Upstreaming Team <linux@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Hi,

We're constantly having to support new laptop models from vendors and
the majority of them always seem to need some kind of HDA quirk
adding, especially for pin usage info where the BIOS data is clearly
incorrect. From the vast collection of quirks present in Linux's HDA
drivers I see we are not alone.

We're trying to figure out if there is a way the BIOS can be fixed for
the cases that come from our partners, but I am also curious as to how
this is managed on Windows and if we can learn anything from that.

I had a look at the windows driver for some affected hardware. I was
unable to identify any hardware-specific quirks in the .inf files, but
using "strings" I found that various binary .sys, .dll and .dat files
refer to hundreds of different laptop models.

That might suggest that for each new laptop model, they make a
modification to the windows driver, recompile, and get the new version
signed again by MS? Sounds insane, anyone know for sure how this is
handled?

Thanks
Daniel
