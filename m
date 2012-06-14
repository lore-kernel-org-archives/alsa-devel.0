From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v2 0/5] mmp audio support
Date: Thu, 14 Jun 2012 09:59:53 +0800
Message-ID: <CAMj5Bkg-JVbZivKJHun6otu95=9idkLj9ozT834NwbF0iv19wQ@mail.gmail.com>
References: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
	<201206131958.49446.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <201206131958.49446.arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Leo Yan <leoy@marvell.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lrg@ti.com>, Qiao Zhou <zhouqiao@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, alsa-devel@vger.kernel.org, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 14, 2012 at 3:58 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 11 June 2012, Zhangfei Gao wrote:
>>
>> v1->v2:
>> modify accroingly with suggestion from Vinod and Mark
>> remove deprecated chan->private and dma.h
>> remove prep_slave_sg
>> remove module_init and move operation to probe
>> misc change
>
> It seems that this driver is missing DT bindings, which really need to get
> added. The brownstone platform is currently supported using both DT and
> ATAG probing, but we want to remove the ATAG variant eventually, so adding
> a new driver for that platform without support for DT booting is a step in
> the wrong direction.
>
> =A0 =A0 =A0 =A0Arnd

Thanks Arnd, we will add DT support in the next step.
The driver will support both DT and non-DT, just as what Chris do for
mmc driver.

> --
> To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
