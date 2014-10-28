From: dE <de.techno@gmail.com>
Subject: Selecting correct input device port.
Date: Tue, 28 Oct 2014 09:57:18 +0530
Message-ID: <544F1B26.2070502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id EDF6F261987
 for <Alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 05:28:00 +0100 (CET)
Received: by mail-lb0-f170.google.com with SMTP id u10so6942249lbd.15
 for <Alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 21:28:00 -0700 (PDT)
Received: from [192.168.1.2] ([59.89.143.167])
 by mx.google.com with ESMTPSA id ya10sm134725lbb.6.2014.10.27.21.27.57
 for <Alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 27 Oct 2014 21:27:59 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

As I learn't in this mailng list, a device can typically handle only one 
stream at a time unless it supports hardware mixing which's exposed via 
subdevices in ALSA

What does subdevice mean for input device? Do they mark physical ports 
for input? If not how do I record from a specific input port? Is it 
automatically selected by the card?

And what's 'input source' in ALSA mixer?
