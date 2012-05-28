From: Chao Xie <xiechao.mail@gmail.com>
Subject: Re: FW: [alsa-devel] [PATCH 2/4] ASoC: mmp: add audio dma support
Date: Mon, 28 May 2012 10:00:52 +0800
Message-ID: <CADApbei-dKRgt7GifamF7HJKEP1FmDcwHk+RUfD2cimc_AxmwA@mail.gmail.com>
References: <AAD1C6EB06EE3649B35B7E026785068D1A74C045C0@SC-VEXCH2.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AAD1C6EB06EE3649B35B7E026785068D1A74C045C0@SC-VEXCH2.marvell.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux@arm.linux.org.uk
Cc: vinod.koul@linux.intel.com, eric.y.miao@gmail.com, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, haojian.zhuang@gmail.com, alsa-devel@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Friday, May 25, 2012 5:43 PM
> To: zhangfei gao
> Cc: Vinod Koul; alsa-devel@alsa-project.org; linux-arm-kernel@lists.infra=
dead.org; Eric Miao; Leo Yan; Mark Brown; Haojian Zhuang; alsa-devel@vger.k=
ernel.org; Qiao Zhou; Zhangfei Gao; Liam Girdwood; Chao Xie
> Subject: Re: [alsa-devel] [PATCH 2/4] ASoC: mmp: add audio dma support
>
> On Fri, May 25, 2012 at 04:47:20PM +0800, zhangfei gao wrote:
>> Do you mean at open time, like snd_dmaengine_pcm_open.
>> The channel resource is limited and better get dynamically.
>> As a =A0result the pcm_new and preallocate already called before.
>
> This is where dealing with slave DMA channels in a virtualized setup
> becomes a far better solution than trying to assign a particular
> physical channel at request time.
>
> What we may wish to think about is having a way for slave drivers to
> assert to DMA engine the priority of a channel, which they can change
> dynamically according to what they're doing. =A0Eg, an ALSA driver would
> leave the channel low priority while it's not expecting to be used, but
> as soon as we see the prepare call, set it to high priority.
>
> The DMA engine driver could use that to decide to assign a physical
> channel to the virtual channel, so that DMA can start as soon as
> possible even with other activity on the DMA engine.
>
> However, I've yet to see any setup where the number of physical DMA
> channels available exceeds the number of actual _simultaneous_ users.
> Even with the five channels on SA11x0 shared between 12? peripherals,
> with my DMA engine driver I've only seen one or two physical channels
> being used simultaneously.
>
I can understand that the virtual channel and physical channel. But i
do not know that why you said that buf->dev.dev uses the right device,
and we don't need set the coherent_mask and dma_mask. As i understand
that buf->dev.dev should be the audio device, so why do you said that
it is the dma engine device?
