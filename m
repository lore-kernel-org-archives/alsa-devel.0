From: Simon Derr <ddrsimon@gmail.com>
Subject: snd-hda-intel : issues with mic boost on ALC3236
Date: Fri, 24 Apr 2015 21:34:19 +0200
Message-ID: <CAP1KSYf_wsief6OCx8hMta5Bq0zN8meCzfxkyjt2ab8hXettMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A8632605FA
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 21:34:40 +0200 (CEST)
Received: by wgin8 with SMTP id n8so60738219wgi.0
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 12:34:40 -0700 (PDT)
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

Hello,

I'm having issues with the internal microphone on an Asus R553 (or S551) laptop.

With the boost set to zero the microphone works but the level of the
recording is very low.
If I try another boost setting I don't get any signal anymore.

I have uploaded alsa-info data here :
http://www.alsa-project.org/db/?f=55b7fb0b4998757d099addae0a411e6a7cebc079

This is on a Linux 4.0 kernel.

Any help is welcome,

Regards,

   Simon
