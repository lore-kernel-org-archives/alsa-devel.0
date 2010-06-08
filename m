From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 2/2] pxa: modify the pxa2xx-ac97 file for
	pxa168
Date: Tue, 8 Jun 2010 19:23:34 +0800
Message-ID: <AANLkTimNwtScfKYVc4qPZFEP6GYklPoHLgr2AE7yquQL@mail.gmail.com>
References: <4C0E21A1.4000909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AD264243B1
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jun 2010 13:24:01 +0200 (CEST)
Received: by gyd10 with SMTP id 10so3059066gyd.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Jun 2010 04:24:00 -0700 (PDT)
In-Reply-To: <4C0E21A1.4000909@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

2010/6/8 Wan ZongShun <mcuos.com@gmail.com>:
> In order to allow the sharing of the pxa2xx-ac97 driver file with pxa168,
> we have to do a little change to pxa2xx-ac97 file.
>
> All private register addresses were located in mach/include/ac97.h.

This is not the right way to go, as suggested already. I hope the ac97
driver is more self-contained. i.e. having a platform device for:

 - where the registers are mapped from
 - drcmr channel numbers can be encoded within dma resource
 - ac97 register definitions are not exposed everywhere
