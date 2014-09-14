From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 0/9] Misc fixes related to rewinds
Date: Sun, 14 Sep 2014 16:53:56 +0800
Message-ID: <CAN8cciY=sOrAyNHzqUo6tsuz0MOFj5aF=ieM4EmUGJVKt0XEhA@mail.gmail.com>
References: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 72380262629
 for <alsa-devel@alsa-project.org>; Sun, 14 Sep 2014 10:53:57 +0200 (CEST)
Received: by mail-qc0-f179.google.com with SMTP id i17so2733174qcy.24
 for <alsa-devel@alsa-project.org>; Sun, 14 Sep 2014 01:53:56 -0700 (PDT)
In-Reply-To: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

>
> Note: this series touches pcm_dmix.c, but does not make it rewindable. In
> other words, a variant of the test in [2] now produces a tone instead of
> failing due to snd_pcm_rewind() returning 0. But it should ideally produce
> silence. Obviously, there is some bug left that I have not pinpointed yet.
>

It is better to let dmix not support rewind and force your rewind program
to fail

You rewind program should not affect the other application playing through
dmix
