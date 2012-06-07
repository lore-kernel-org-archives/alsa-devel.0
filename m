From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v1 2/5] ASoC: mmp: add audio dma support
Date: Thu, 7 Jun 2012 21:17:30 +0800
Message-ID: <CAMj5BkhrxhvGEe3EinSQycb9aBo4rZriU7=Um9z=0mKyBz71HA@mail.gmail.com>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
	<1338791851-21038-3-git-send-email-zhangfei.gao@marvell.com>
	<1339061042.1927.61.camel@vkoul-udesk3>
	<CAMj5Bkj+4qQqoDgz_d7eLK+QuVm41fnN5204tRpJ8NKrNsAjcg@mail.gmail.com>
	<1339063547.1927.63.camel@vkoul-udesk3>
	<CAMj5BkhtHaF=b=VDMoif_RxWR_Wdxc7qMpjH-SBO=yoA4W9LTA@mail.gmail.com>
	<1339068025.1927.66.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id BA69D2434B
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 15:17:30 +0200 (CEST)
Received: by werh12 with SMTP id h12so338553wer.38
	for <alsa-devel@alsa-project.org>; Thu, 07 Jun 2012 06:17:30 -0700 (PDT)
In-Reply-To: <1339068025.1927.66.camel@vkoul-udesk3>
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

On Thu, Jun 7, 2012 at 7:20 PM, Vinod Koul <vinod.koul@linux.intel.com> wro=
te:
> On Thu, 2012-06-07 at 18:44 +0800, zhangfei gao wrote:
>> Only exception is dmaengine_slave_config, since we have some specific co=
nfig.
> And why?
>
>> +static bool filter(struct dma_chan *chan, void *param)
>> +{
>> + =A0 =A0 struct mmp_dma_data *dma_data =3D param;
>> + =A0 =A0 bool found =3D false;
>> + =A0 =A0 char *devname;
>> +
>> + =A0 =A0 devname =3D kasprintf(GFP_KERNEL, "%s.%d", dma_data->dma_res->=
name,
>> + =A0 =A0 =A0 =A0 =A0 =A0 dma_data->ssp_id);
>> + =A0 =A0 if ((strcmp(dev_name(chan->device->dev), devname) =3D=3D 0) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 (chan->chan_id =3D=3D dma_data->dma_res->start=
)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 chan->private =3D &dma_data->tdma_data;
> chan->private is deprecated and should not be used

Thanks for the info, will update accordingly.
The concern is DMA_SLAVE_BUSWIDTH_4_BYTES is used for S20, S24, S32.
And our controller handles differently, though they not seen much.

Besides, dmaengine_slave_config still have to be used for src/dst_addr
and src/dst_maxburst.

>> + =A0 =A0 =A0 =A0 =A0 =A0 found =3D true;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 kfree(devname);
>> + =A0 =A0 return found;
>> +}
>
>
> --
> ~Vinod
>
