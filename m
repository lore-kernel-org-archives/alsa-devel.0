From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Constant headphone noise on Dell XPS 13 9365
Date: Wed, 31 May 2017 11:50:30 -0500
Message-ID: <CAMP44s000FA3BAQEwqxPQxUGeR4U=PhByJfAAA9q74M8=6iTyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f181.google.com (mail-ua0-f181.google.com
 [209.85.217.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A32B26691F
 for <alsa-devel@alsa-project.org>; Wed, 31 May 2017 18:50:32 +0200 (CEST)
Received: by mail-ua0-f181.google.com with SMTP id j17so12923951uag.3
 for <alsa-devel@alsa-project.org>; Wed, 31 May 2017 09:50:32 -0700 (PDT)
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

Since I bought this machine I've always heard audio noise when I plug
the headphones. This laptop has Intel HDA with the Realtec codec.

This has happened in all the Linux versions I've tried, and I've also
tried HDA Analyzer and changed every value I could find and nothing
helps.

The only value that seems to have an effect is "Headphone Playback
Switch"; if I mute it I don't hear the noise any more, but I don't
hear any audio either.

Lowering the volume to zero doesn't help either, the noise remains at
the same audible level.

I'm running 4.11.3 at the moment. Any ideas?

Cheers.

-- 
Felipe Contreras
