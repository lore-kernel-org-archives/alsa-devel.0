From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/6] ASoC: mxs: use devm_clk_get for
	mxs_saif_probe
Date: Thu, 10 May 2012 17:11:55 +0800
Message-ID: <CAAQ0ZWTvZtK1AsXD=5jfd-hjLoo9bFdps=hCQpHs9sHQxjnxVQ@mail.gmail.com>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
	<1336639333-11561-3-git-send-email-shawn.guo@linaro.org>
	<20120510091204.GH6622@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 32E0E10B9F3
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 11:11:56 +0200 (CEST)
Received: by lagw12 with SMTP id w12so906407lag.38
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2012 02:11:55 -0700 (PDT)
In-Reply-To: <20120510091204.GH6622@shlinux2.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <aisheng.dong@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <dong.aisheng@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 10 May 2012 17:12, Dong Aisheng <aisheng.dong@freescale.com> wrote:
>> =A0 =A0 =A0 dmares =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
>> =A0 =A0 =A0 if (!dmares) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> The 'ret' is used below.

Right, good catch.

> The following has the same issue.
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get dma resou=
rce: %d\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
> I think we can remove the ret here since it does not help too much.
>
Ok, will do.

Regards,
Shawn
