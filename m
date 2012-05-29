From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 3/4] ASOC: mmp: add sspa support
Date: Tue, 29 May 2012 13:23:46 +0800
Message-ID: <CAMj5Bkhm2R+WK=_7eb6Y7h=Dg0-BUKqv3k17wRwow7UJrE_R+w@mail.gmail.com>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
	<1337929863-31885-4-git-send-email-zhangfei.gao@marvell.com>
	<20120528145904.GK4032@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
	[209.85.217.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4287B248BB
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2012 07:23:47 +0200 (CEST)
Received: by lban1 with SMTP id n1so2285771lba.38
	for <alsa-devel@alsa-project.org>; Mon, 28 May 2012 22:23:46 -0700 (PDT)
In-Reply-To: <20120528145904.GK4032@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Leo Yan <leoy@marvell.com>, Vinod Koul <vinod.koul@intel.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, alsa-devel@vger.kernel.org, Qiao Zhou <zhouqiao@marvell.com>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 28, 2012 at 10:59 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, May 25, 2012 at 03:11:02PM +0800, Zhangfei Gao wrote:
>> The SSPA is a configurable multi-channel audio serial (TDM) interface.
>> It's configurable at runtime to support up to 128 channels and the
>> number of bits per sample: 8, 12, 16, 20, 24 and 32 bits. It also
>> support stereo format: I2S, left-justified or right-justified.
>
> Mostly looks good. =A0A few fairly minor things...
Thanks Mark for kind review.


>> +
>> + =A0 =A0 if (!cpu_dai->active) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(sysclk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(sspa->clk);
>> + =A0 =A0 }
>
> The clock API is refcounted so you shouldn't need to worry about
> multiple enables, you should just be able to unconditionally enable and
> disable. =A0If this is needed we probably have a problem we should fix.
Will update.

>
>> + =A0 =A0 switch (pll_id) {
>> + =A0 =A0 case MMP_SYSCLK:
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_set_rate(sysclk, freq_out);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case MMP_SSPA_CLK:
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_set_rate(sspa->clk, freq_out);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> You're ignoring the return values here.
will update.

>
>> + =A0 =A0 priv->sspa->clk =3D clk_get(&pdev->dev, NULL);
>> + =A0 =A0 if (IS_ERR(priv->sspa->clk)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(priv->sspa->clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_clk;
>> + =A0 =A0 }
>
> devm_clk_get().
Unfortunately, not find devm_clk_get.

>
>> + =A0 =A0 res =3D request_mem_region(res->start, resource_size(res),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->name);
>> + =A0 =A0 if (res =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to request memory =
resource\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_get_res;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 priv->sspa->mmio_base =3D ioremap(res->start, resource_size(re=
s));
>> + =A0 =A0 if (priv->sspa->mmio_base =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to ioremap() regis=
ters\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
>> + =A0 =A0 }
>
> devm_request_and_ioremap().
will update.
>
>> +err_free_clk:
>> + =A0 =A0 devm_kfree(&pdev->dev, priv->dma_params);
>> +err_priv_dma_params:
>> + =A0 =A0 devm_kfree(&pdev->dev, priv->sspa);
>> +err_priv_sspa:
>> + =A0 =A0 devm_kfree(&pdev->dev, priv);
>
> The whole point of the devm_ stuff is that you don't need to do stuff
> like this.

Thanks confirmation, not sure before, also find devm_kfree is used.
Will remove the devm_kfree etc in err handle as well as remove function.

>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
