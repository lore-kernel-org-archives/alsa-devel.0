From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 1/2] ARM: MMP: add pxa-squ header file
Date: Tue, 22 May 2012 09:36:39 +0800
Message-ID: <CAN1soZzvTKNYGCk-+XzjegbTncM6rVYi4ph0+AQREsCrwVKfvA@mail.gmail.com>
References: <1337330621-9072-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1337330621-9072-1-git-send-email-zhouqiao@marvell.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, eric.y.miao@gmail.com, Liam Girdwood <lrg@ti.com>, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 18, 2012 at 4:43 PM, Qiao Zhou <zhouqiao@marvell.com> wrote:
> add pxa-squ header file to support SQU DMA.
>
> Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
> ---
> =A0arch/arm/mach-mmp/include/mach/pxa-squ.h | =A0 39 ++++++++++++++++++++=
++++++++++
> =A01 files changed, 39 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/mach-mmp/include/mach/pxa-squ.h
>
> diff --git a/arch/arm/mach-mmp/include/mach/pxa-squ.h b/arch/arm/mach-mmp=
/include/mach/pxa-squ.h
> new file mode 100644
> index 0000000..3ee187f
> --- /dev/null
> +++ b/arch/arm/mach-mmp/include/mach/pxa-squ.h
> @@ -0,0 +1,39 @@
> +#ifndef __MACH_SQU_H
> +#define __MACH_SQU_H
> +
> +#include <mach/addr-map.h>
> +
> +#define SQU_REGS_VIRT =A0(AXI_VIRT_BASE + 0xA0000)
> +#define SQU_REG(x) =A0 =A0 (*((__iomem u32 *)(SQU_REGS_VIRT + (x))))
> +
> + /*SQU*/
> +#define SDSAR(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 SQU_REG(0x810 + ((x) << 2))
> +#define SDDAR(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 SQU_REG(0x820 + ((x) << 2))
> +#define SDNDPR(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0SQU_REG(0x830 + ((x) << 2))
> +#define SDCR(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SQU_REG(0=
x840 + ((x) << 2))
> +#define SDIMR(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 SQU_REG(0x880 + ((x) << 2))
> +#define SDISR(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 SQU_REG(0x8a0 + ((x) << 2))
> +#define SDCR_SSPMOD =A0 =A0 =A0 =A0 =A0 =A0(1 << 21) =A0 =A0 =A0 /* SSPM=
od */
> +#define SDCR_FETCHND =A0 (1 << 13)
> +#define SDCR_CHANEN =A0 =A0 =A0 =A0 =A0 =A0(1 << 12) =A0 =A0 =A0 /* Chan=
nel Enable */
> +#define SDCR_DST_ADDR_INC =A0 =A0 =A0(0 << 4)
> +#define SDCR_DST_ADDR_HOLD =A0 =A0 (0x2 << 4)
> +#define SDCR_SRC_ADDR_INC =A0 =A0 =A0(0 << 2)
> +#define SDCR_SRC_ADDR_HOLD =A0 =A0 (0x2 << 2)
> +#define SDCR_DMA_BURST_4B =A0 =A0 =A0(0x0 << 6)
> +#define SDCR_DMA_BURST_8B =A0 =A0 =A0(0x1 << 6)
> +#define SDCR_DMA_BURST_16B =A0 =A0 (0x3 << 6)
> +#define SDCR_DMA_BURST_1B =A0 =A0 =A0(0x5 << 6)
> +#define SDCR_DMA_BURST_2B =A0 =A0 =A0(0x6 << 6)
> +#define SDCR_DMA_BURST_32B =A0 =A0 (0x7 << 6)
> +#define SDIMR_COMP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 0)
> +
> +struct pxa_squ_platdata {
> + =A0 =A0 =A0 char *pool_name;
> + =A0 =A0 =A0 int irq;
> + =A0 =A0 =A0 int period_max_out; =A0 =A0 =A0 =A0 =A0 =A0 /* max period s=
ize for playback */
> + =A0 =A0 =A0 int period_max_in; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* max period=
 size for capture */
> + =A0 =A0 =A0 int buffer_max_out; =A0 =A0 =A0 =A0 =A0 =A0 /* max buffer s=
ize for playback */
> + =A0 =A0 =A0 int buffer_max_in; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* max buffer=
 size for capture */
> +};
> +#endif /* __MACH_SQU_H */
> --
> 1.7.4.1
>

Acked all.

Mark,

Would you mind to apply this patch series?

Thanks
Haojian
