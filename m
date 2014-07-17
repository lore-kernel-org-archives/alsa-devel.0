From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: ASOC: support for Allwinner on-chip codec
Date: Thu, 17 Jul 2014 10:18:06 -0400
Message-ID: <CAKON4Ox19bhm47RG-phyzXkdKq3fuW8yQ4b0E6Rvhg0jDPuuyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f45.google.com (mail-la0-f45.google.com
 [209.85.215.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F6ED265555
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 16:18:07 +0200 (CEST)
Received: by mail-la0-f45.google.com with SMTP id ty20so1794193lab.32
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 07:18:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

We have the first pass of the ASOC driver for the Allwinner on-chip
codec making some noise that makes sense.  Code is here...
https://github.com/jonsmirl/lpc31xx/blob/codec/sound/soc/sunxi/sunxi-codec.c

Something isn't right in the channel assignments. If I play a mono
clip I hear it. If I play a stereo clip I get silence. If I use
speaker-test to play eight channels, I hear Center and Side Right
channels.  Not Front left/right as expected. Device only does stereo.

If anyone want to do a first pass code revue I can start making the
needed changes.

-- 
Jon Smirl
jonsmirl@gmail.com
