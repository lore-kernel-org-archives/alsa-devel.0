From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Lost Interrput on VIA VT1708S
Date: Fri, 17 Apr 2015 21:35:18 +0800
Message-ID: <CAN8cciamohWLD4WNpE3HwSx3H3g=pCm2jgMr4LYRACHC7C8+hw@mail.gmail.com>
References: <CAN8ccib13GCoT+LW-kYqGTbER3epC6hHty1Rjeveq-rDNpgHGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
 [209.85.218.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B6E226587C
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 15:35:20 +0200 (CEST)
Received: by oiko83 with SMTP id o83so75302588oik.1
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 06:35:19 -0700 (PDT)
In-Reply-To: <CAN8ccib13GCoT+LW-kYqGTbER3epC6hHty1Rjeveq-rDNpgHGQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, tiwai@suse.de, rkfg@rkfg.me
List-Id: alsa-devel@alsa-project.org

>
> The second opint is what you have an issue with - see "Lost interrupts"
in comment #28.
>
>

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/core/pcm_lib.c?id=f5914908a5b7b2338f210e56827a1ef35585dc6d

hwptr tracking was replaced by tracepoint

This seem to be the reason that you only find those Lost Interrput in the
system log

https://bugs.freedesktop.org/show_bug.cgi?id=49608#c28

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/core/pcm_trace.h
