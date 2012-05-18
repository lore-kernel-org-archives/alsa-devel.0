From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: add pxa-squ dma support
Date: Fri, 18 May 2012 12:25:58 +0800
Message-ID: <CAN1soZzQQVtaRRYKMZig95bxZDP6umEG+Om6M5HTKsGUNJf2=w@mail.gmail.com>
References: <1337308751-6126-1-git-send-email-zhouqiao@marvell.com>
	<1337308751-6126-2-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1337308751-6126-2-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 18, 2012 at 10:39 AM, Qiao Zhou <zhouqiao@marvell.com> wrote:
> this patch adds ASoC pxa-squ DMA audio support.
>
> Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
> +/*
> + * Descriptor structure for PXA's SQU engine
> + * Note: this structure must always be aligned to a 16-byte boundary.
> + */
> +struct pxa_squ_desc {
> + =A0 =A0 =A0 __iomem u32 byte_cnt; =A0 /* byte count */
> + =A0 =A0 =A0 __iomem u32 src_addr; =A0 /* source address */
> + =A0 =A0 =A0 __iomem u32 dst_addr; =A0 /* target address */
> + =A0 =A0 =A0 __iomem u32 nxt_desc; =A0 /* next descriptor dress */
Why do you use __iomem at here?

> +};
> +
