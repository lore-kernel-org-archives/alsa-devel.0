From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 1/2] ARM: MMP: add pxa910-ssp into
	ssp_id_table
Date: Tue, 22 May 2012 15:04:07 +0800
Message-ID: <CAN1soZwZNN5=hpK1J3-2c_4DiZiNVEYNso2zhByPydcw5+SYUQ@mail.gmail.com>
References: <1337669853-12701-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1337669853-12701-1-git-send-email-zhouqiao@marvell.com>
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
Cc: Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 22, 2012 at 2:57 PM, Qiao Zhou <zhouqiao@marvell.com> wrote:
> add pxa910-ssp into ssp_id_table, and fix pxa-ssp compiling issue
> under mach-mmp architect.
>
> Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
> ---
> =A0arch/arm/plat-pxa/ssp.c =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0include/linux/pxa2xx_ssp.h =A0 =A0 | =A0 =A01 +
> =A0include/linux/spi/pxa2xx_spi.h | =A0 =A02 +-
> =A03 files changed, 3 insertions(+), 1 deletions(-)
>
Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
