From: Lucas Takejame <lucas@takejame.com.br>
Subject: snd-usb driver
Date: Wed, 11 Dec 2013 14:59:32 -0200
Message-ID: <CAJUVNopomSJU_+WE8U8kjOP5Bh_670H2w=DTRLBF37fDsQfg4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 535E9261B19
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 17:59:53 +0100 (CET)
Received: by mail-wg0-f46.google.com with SMTP id m15so6652950wgh.25
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 08:59:53 -0800 (PST)
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

Hello guys, I'm new here. The company that i work for is developing a LV2
host pedal board (http://portalmod.com/en/index.html) and my job now is to
find if I can improve in anyway our usb driver (which is the kernel's
snd-usb driver). I know the code is already optimized but I was hoping
that, since we only use one specific sound card and we won't need a generic
driver, I could change something in the code to optimize it latency wise. I
have only a brief knowledge on the USB protocol and even less on writing
drivers, so I'm here first to ask if it's possible to improve latency by
changing the driver's code and, if possible, if you guys could give me some
directions on how to do it.

Thanks in advance,

Lucas
