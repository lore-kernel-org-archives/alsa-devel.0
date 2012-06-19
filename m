From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v2 1/5] dmaengine: mmp_tdma: add mmp tdma
	support
Date: Tue, 19 Jun 2012 20:21:27 +0800
Message-ID: <CAMj5Bkh+DeQCVc5OVMUwxxsMUGMaGz5=BxA_9gd-FcyYtGH6=w@mail.gmail.com>
References: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
	<1339409081-10097-2-git-send-email-zhangfei.gao@marvell.com>
	<1339670638.1927.1641.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AE2C244CF
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2012 14:21:28 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so4746845wgb.20
	for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2012 05:21:28 -0700 (PDT)
In-Reply-To: <1339670638.1927.1641.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Leo Yan <leoy@marvell.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, alsa-devel@vger.kernel.org, Qiao Zhou <zhouqiao@marvell.com>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 14, 2012 at 6:43 PM, Vinod Koul <vinod.koul@linux.intel.com> wr=
ote:
> On Mon, 2012-06-11 at 18:04 +0800, Zhangfei Gao wrote:
>> +static int mmp_tdma_clear_chan_irq(struct mmp_tdma_chan *tdmac)
>> +{
>> + =A0 =A0 =A0 u32 reg =3D readl(tdmac->reg_base + TDISR);
>> +
>> + =A0 =A0 =A0 if (reg & TDISR_COMP) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* clear irq */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~TDISR_COMP;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(reg, tdmac->reg_base + TDISR);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 return -1;
>> +}
> -1?
> Please return a proper linux error code.
>
>
> --
> ~Vinod

Hi, Vinod

The patch is updated, would you mind take a look, thanks.
