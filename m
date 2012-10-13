From: Dan MacDonald <allcoms@gmail.com>
Subject: bit depth issue for Scarlett 2i4
Date: Sat, 13 Oct 2012 08:43:06 +0100
Message-ID: <CANOoOjtrGHCjtEjQ+6jAZ1un4pXsGD5=YyJV9F2mrUVbXpoO8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 40DC7261687
 for <alsa-devel@alsa-project.org>; Sat, 13 Oct 2012 09:43:07 +0200 (CEST)
Received: by mail-vc0-f179.google.com with SMTP id f13so4027380vcb.38
 for <alsa-devel@alsa-project.org>; Sat, 13 Oct 2012 00:43:06 -0700 (PDT)
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

I recently bought a Focusrite Scarlett 2i4 which is advertised as being
capable of recording at a max of 24bit/96Khz but when I run alsacap it
reports it as 32bit:

./alsacap -R -d hw:1
*** Exploring configuration space of device `hw:1' for recording ***
2 channels
Sampling rate 44100..96000 Hz
Sample formats: S32_LE
Significant bits: 32

It does seem to record OK but that output seems wrong and I'm slightly
concerned about the waste of disk space when multitracking if I end up with
32bit files but only 24 of those bits per sample are actually being used.

Thanks for your help!

Dan
