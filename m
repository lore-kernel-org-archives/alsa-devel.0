From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 14/16] ASoC: Ux500: Add platform-driver
Date: Wed, 14 Mar 2012 11:50:28 +0100
Message-ID: <CACRpkdZdZpB+hP1sz-p11Tm=bgS4VjfKWnEJDezHZ7n-kHEU_A@mail.gmail.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-15-git-send-email-ola.o.lilja@stericsson.com>
	<20120313224840.GM3177@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 566351044BF
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 11:50:29 +0100 (CET)
Received: by ggni2 with SMTP id i2so1671216ggn.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 03:50:28 -0700 (PDT)
In-Reply-To: <20120313224840.GM3177@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 13, 2012 at 11:48 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

>> + =A0 =A0 cdesc =3D dma_dev->device_prep_dma_cyclic(ux500_pcm_data->pipe=
id, dma_addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 period_cnt * period_len, period_len,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 direction);
>
> You're using dmaengine here it seems. =A0Please refactor to use the
> dmaengine helper library that was recently contributed by Lars-Peter -
> it should save a bunch of code and make rolling out dmaengine framework
> improvements much easier.

That stuff is not even in linux-next so I don't know it it will even be
in v3.4. But let's see.

Yours,
Linus Walleij
