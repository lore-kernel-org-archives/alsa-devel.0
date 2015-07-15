From: James Miller <jamesstewartmiller@gmail.com>
Subject: armv7 raspberry pi kernel compilation and
 snd_usb_us122l tascam us122 module requires x86
Date: Wed, 15 Jul 2015 11:47:18 +0100
Message-ID: <CAKJvYZHP+aUpWKKaxUfmSASb3XCW94DBkBtXhUHfaeU1wjgNPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f49.google.com (mail-vn0-f49.google.com
 [209.85.216.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 54FCC265A56
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 12:47:19 +0200 (CEST)
Received: by vnbf62 with SMTP id f62so4043273vnb.9
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 03:47:18 -0700 (PDT)
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

hi - I am compiling a rt kernel for my raspberry pi, and I notice I am
unable to select the us122l driver for inclusion as a module as it is
listed as requiring x86 to be selected.

Many of the other modules are available and use the same codebase as the
us122l driver, so I was wondering if the x86 requirement is strictly
necessary?

Is it possible to check that the us122l module requires x86 and is
incompatible with arm architecture please.

Many thanks

James

-- 
James Stewart Miller Bsc(hons) Psych.
