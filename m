From: Vasily Postnicov <shamaz.mazum@gmail.com>
Subject: Recording with asus xonar essence st card
Date: Sat, 25 Oct 2014 15:16:43 +0400
Message-ID: <CADnZ6B=orUbdou9R6Hbi=n60euOetoXzhs=ALcHtEyBTp8T0jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f175.google.com (mail-vc0-f175.google.com
 [209.85.220.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 692162605F2
 for <alsa-devel@alsa-project.org>; Sat, 25 Oct 2014 13:16:44 +0200 (CEST)
Received: by mail-vc0-f175.google.com with SMTP id id10so1079997vcb.34
 for <alsa-devel@alsa-project.org>; Sat, 25 Oct 2014 04:16:43 -0700 (PDT)
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

Hello. This is not related to alsa, but I decided to write this message
here, because as far as I know alsa has the best open source driver for
asus xonar series. I am using DragonFlyBSD and a bit modified driver
originally written for FreeBSD by Alexander Polakov
https://github.com/shamazmazum/xonar-dragonfly

It lacks support for recording. I am trying to add this functionality from
alsa/OSS drivers, but I have some unanswered questions. There are they here:

1) How do I  initialize my soundcard for recording properly? I think I must
enable CS5381 ADC using GPIO registers,  but what are OXYGEN_REC_ROUTING,
OXYGEN_ADC_MONITOR and OXYGEN_A_MONITOR_ROUTING for? Does MONITOR mean the
same thing as in the user manual? If ROUTING registers are just switches
for source of a signal to be recorded, is it enough to use
OXYGEN_REC_B_ROUTE_I2S_ADC_2 for ST card to record from line-in/mic jack?

2) How do I control volume of sound while recording? Have Xonar Essence
cards any controls for this? I cannot find it out looking at oxygen_mixer.c
