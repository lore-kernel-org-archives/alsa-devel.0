From: =?UTF-8?Q?Giedrius_Trainavi=C4=8Dius?= <giedrius.trainavicius@gmail.com>
Subject: Getting a notification of snd_kcontrol value change,
 defined in codec, in machine driver
Date: Sun, 8 Jul 2018 02:10:59 +0300
Message-ID: <CABpuRUMrVKFniRGm8zM1SYsR8vprb+9rRMyJf=4Q7K2pfSwa6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com
 [209.85.217.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C1F6267650
 for <alsa-devel@alsa-project.org>; Sun,  8 Jul 2018 01:11:01 +0200 (CEST)
Received: by mail-ua0-f173.google.com with SMTP id y8-v6so9666185uan.3
 for <alsa-devel@alsa-project.org>; Sat, 07 Jul 2018 16:11:01 -0700 (PDT)
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

Hey,

What would be the best way in machine driver to learn about changes of alsa
mixer control values? The controls are defined in the codec driver.

The intended use case would be to use the current volume setting for the
codec on the board to forward to a dedicated microcontroller for visual
feedback.

I am aware that this could be bridged over via a user space program, but I
will have to forward the current PCM stream format to the MCU anyway from
hw_params, so ideally I would like all of this functionality contained in
the machine driver.

Thank you,
Giedrius.
