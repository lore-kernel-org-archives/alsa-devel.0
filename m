From: xiphmont@xiph.org
Subject: Re: [Vorbis-dev] libao problem (Re: No dmix/dsnoop on
 Intel ICH4/5 by default?)
Date: Thu, 7 Mar 2013 03:20:13 -0500
Message-ID: <CACrD=+9THyqQKPj_V6Oeg1FaJwj8CRZ1YC+8SxFqR_bGbmpDGg@mail.gmail.com>
References: <50F6FF00.7020706@gmail.com> <50F71312.1000009@ladisch.de>
 <50F7D0E3.3020401@gmail.com> <50F7EAA1.7040504@ladisch.de>
 <50F7F23C.4070006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f47.google.com (mail-la0-f47.google.com
 [209.85.215.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 810C12615EC
 for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2013 09:20:14 +0100 (CET)
Received: by mail-la0-f47.google.com with SMTP id fj20so170658lab.20
 for <alsa-devel@alsa-project.org>; Thu, 07 Mar 2013 00:20:14 -0800 (PST)
In-Reply-To: <50F7F23C.4070006@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: alsa-devel@alsa-project.org, vorbis-dev@xiph.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

> I can, now, set it to dev=default manually but what this means is that
> libao-1.1.0 by default kills alsa default software mixing.

The only alternative is to have any attempt at playing surround always
fail to play more than stereo on a default setup.  The bug reports
about _that_ prompted the change to the current behavior.

> These days
> everybody seems to have regressed to using a soundserver again anyway

Part of the reason for that is that ALSA provides so precious little
in the way of programmatic configuration discovery.  So far as I can
tell, each and every user gets to script/configure his own setup, and
then also explicitly configure the applications what to do.
Applications can't even tell if a default setup is in use.  It's all
plug-n-pray.

If that's not the case, I'd love to hear about it. I agree the current
behavior sucks.

Monty
