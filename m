From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v2 1/5] dmaengine: mmp_tdma: add mmp tdma
	support
Date: Fri, 15 Jun 2012 11:02:02 +0800
Message-ID: <CAMj5Bkhz8UPxRT6B6v8Ds-jPqXBnOCSgd6nUKx9e+x3SZwxRQw@mail.gmail.com>
References: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
	<1339409081-10097-2-git-send-email-zhangfei.gao@marvell.com>
	<1339670638.1927.1641.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by alsa0.perex.cz (Postfix) with ESMTP id ADE9E24371
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2012 05:02:02 +0200 (CEST)
Received: by wibhj6 with SMTP id hj6so78268wib.2
	for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2012 20:02:02 -0700 (PDT)
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

Thanks Vinod for careful review, my mistake, will resend the patch.

> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
