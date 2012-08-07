From: nerwusek <luk0104@gmail.com>
Subject: uda1380 and pxa255 plays nothing but noise
Date: Tue, 07 Aug 2012 21:18:41 +0200
Message-ID: <50216A11.3050407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 243A0265F98
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 20:49:22 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so1447953bkc.38
 for <alsa-devel@alsa-project.org>; Tue, 07 Aug 2012 12:19:07 -0700 (PDT)
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
I'm trying to enable sound on my iPAQ h2200 device using ALSA ASoC. I've =

created driver basing on hx4700.c and magician.c files, but I can't hear =

is anything. When I am playing music on device file =

uda1380-codec.0-0018/dapm/Playback shows that stream Playback is active, =

but in DAC that stream is inactive (but DAC is on). I also noticed that =

on I2S bus is nothing going on. I've lost many hours on looking for =

problem. Is there anyone who could help me?

=A3ukasz Da=B3ek
