From: sylvain.bertrand@gmail.com
Subject: right way to enumerate pcm devices
Date: Tue, 12 Feb 2019 12:33:33 +0000
Message-ID: <20190212123333.GB6441@freedom>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 25E692673F8
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 13:34:24 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id r17so2725435wmh.5
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 04:34:24 -0800 (PST)
Received: from localhost (78.205.93.92.rev.sfr.net. [92.93.205.78])
 by smtp.gmail.com with ESMTPSA id 90sm21641187wrk.95.2019.02.12.04.34.23
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Feb 2019 04:34:23 -0800 (PST)
Content-Disposition: inline
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

I got some code based on hints which, unfortunately, seems not sufficient.

I can list the hardware cards, but what is the proper way to enumerate the pcm devices?

For instance, I don't get basic user defined pcm devices, I get all the
surround pcm devices for the USB mic from my webcam etc...
The real question: how I build a clean list of pcm devices I would present to a
user to choose from without confusing him/her?

Wherever I look I get only this hint based code. I presume I am looking the
wrong way.

regards,

-- 
Sylvain
