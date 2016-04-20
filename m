From: Petr Kulhavy <petr@barix.com>
Subject: GPIO control from ALSA
Date: Wed, 20 Apr 2016 10:03:48 +0200
Message-ID: <571737E4.5030908@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id D5763261B0A
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 10:03:52 +0200 (CEST)
Received: by mail-wm0-f51.google.com with SMTP id n3so67591047wmn.0
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 01:03:52 -0700 (PDT)
Received: from [192.168.11.170] (dynamic-31-25-120-010.ftth.glattnet.ch.
 [31.25.120.10])
 by smtp.gmail.com with ESMTPSA id gl8sm4207960wjb.30.2016.04.20.01.03.48
 for <alsa-devel@alsa-project.org> (version=TLSv1/SSLv3 cipher=OTHER);
 Wed, 20 Apr 2016 01:03:49 -0700 (PDT)
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

I'm writing a driver for ASoC "sound card" hardware which uses CPU GPIO 
to mute/unmute an analogue amplifier and another GPIO to control an 
analogue switch for line/mic switching. Is there an abstraction in ALSA 
to model this kind of hardware?

Thanks
Petr
