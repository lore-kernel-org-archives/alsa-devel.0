From: Prasant J <pj0585@gmail.com>
Subject: ASoC: mmap or read/write?
Date: Thu, 18 Oct 2012 14:08:40 +0530
Message-ID: <CAA2DH4uhwV0NmxEbLKN=m+VC9ruOHM13Vpu1m33j0DNm+n6yKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 65B4C2652B4
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 10:38:41 +0200 (CEST)
Received: by mail-la0-f51.google.com with SMTP id m15so5170326lah.38
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 01:38:41 -0700 (PDT)
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

I'm writing an alsa application for recording & playing 16 channel audio.

The application is intended to run on an embedded platform & the
resources are highly constrained.
My application is not performing well with read/write methods. I'm
considering using mmap but not able to get the right documentation or
start, so I want to know whether mmap really offers any advantages or
not.

Does the mmap method has any advantages over read/write?
Is there any thumb rule to decide when to use mmap or read/write?

-Prasant
