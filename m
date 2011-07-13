From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH V2 04/10] ASoc: mxs: add asoc configuration
	files
Date: Wed, 13 Jul 2011 19:13:10 +0800
Message-ID: <CAA+hA=QEWMqc12wGz6M7ejtVmB3Wx2Wc2wNXyq78QrPrW8qE1Q@mail.gmail.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-5-git-send-email-b29396@freescale.com>
	<20110713090819.GB1928@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6569C24383
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 13:13:12 +0200 (CEST)
Received: by gwj17 with SMTP id 17so2481067gwj.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2011 04:13:10 -0700 (PDT)
In-Reply-To: <20110713090819.GB1928@pengutronix.de>
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

2011/7/13 Wolfram Sang <w.sang@pengutronix.de>:
>> +if SND_MXS_SOC
>> +
>> +config SND_SOC_MXS_SGTL5000
>> + =A0 =A0 tristate "SoC Audio support for i.MX boards with sgtl5000"
>
> depends on I2C
Added.
Thanks.

Regards
Dong Aisheng
