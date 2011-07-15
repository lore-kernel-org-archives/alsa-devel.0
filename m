From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH V2 06/10] ARM: mxs: add saif device
Date: Fri, 15 Jul 2011 23:02:36 +0800
Message-ID: <CAA+hA=TtBrDoAMfv0fqj30_heEJuZJFH=QjTUG8zTys0G+vgvA@mail.gmail.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-7-git-send-email-b29396@freescale.com>
	<20110715133241.GG2021@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51]) by alsa0.perex.cz (Postfix) with ESMTP id AB0D424503
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jul 2011 17:02:37 +0200 (CEST)
Received: by yib2 with SMTP id 2so580128yib.38
	for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2011 08:02:36 -0700 (PDT)
In-Reply-To: <20110715133241.GG2021@pengutronix.de>
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
>> +#define DIGCTRL_BASE_ADDR =A0 =A0 =A0MX28_IO_ADDRESS(MX28_DIGCTL_BASE_A=
DDR)
>> +
>
> Hmm, maybe define a function mx28_set_saif_clkmux(val)?
>
>> + =A0 =A0 mx28_add_saif(0);
>> + =A0 =A0 mx28_add_saif(1);
>> +
>> + =A0 =A0 /*set the saif clk mux, both saif0/saif1 use saif0 clk*/
>> + =A0 =A0 __raw_writel(0x2 << 10, DIGCTRL_BASE_ADDR);
>
> You might overwrite previous settings here. The hardcoded numbers need
> defines, too.

It's correct.
I'm originally going to do that when implement record because this
setting may affect both
machine driver and saif driver on recording.
Since currently we only implement playback, so i just hardcode it.
Do you think if that's ok?
Or i need to do it now?

Regards
Dong Aisheng
