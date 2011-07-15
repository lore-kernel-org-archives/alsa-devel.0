From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH V2 06/10] ARM: mxs: add saif device
Date: Sat, 16 Jul 2011 01:22:16 +0800
Message-ID: <CAA+hA=RSXQJ1QhSMrdkxhpDvAwib-HDxO7wOQ6-XOOVgBq9hyA@mail.gmail.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-7-git-send-email-b29396@freescale.com>
	<20110715133241.GG2021@pengutronix.de>
	<CAA+hA=TtBrDoAMfv0fqj30_heEJuZJFH=QjTUG8zTys0G+vgvA@mail.gmail.com>
	<20110715153450.GA31640@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51]) by alsa0.perex.cz (Postfix) with ESMTP id B118A243C1
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jul 2011 19:22:17 +0200 (CEST)
Received: by yib2 with SMTP id 2so641227yib.38
	for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2011 10:22:16 -0700 (PDT)
In-Reply-To: <20110715153450.GA31640@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, Dong Aisheng <b29396@freescale.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2011/7/15 Wolfram Sang <w.sang@pengutronix.de>:
> If you just do playback, do you need to mux SAIF1-clk to SAIF0-clk ? If not
> (what I'd think), just leave changing DIGCTL out completely since the
> reset-default for that register should work. If you do need changing DIGCTL,
> some helper function like mentioned above would be better, I think.

You're right.
I will remove that line of code firstly before doing record and we will provide
that helper funtion later.
Thanks for your suggestions.

Regards
Dong Aisheng
