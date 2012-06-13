From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v2 0/5] mmp audio support
Date: Wed, 13 Jun 2012 22:01:55 +0800
Message-ID: <CAMj5BkiOtgc1rPb1usHCahna8V_2PJceh9v9SGBduzChKjqoEQ@mail.gmail.com>
References: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
	<20120613121743.GN4545@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9754A2454D
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2012 16:01:56 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so450425wgb.20
	for <alsa-devel@alsa-project.org>; Wed, 13 Jun 2012 07:01:56 -0700 (PDT)
In-Reply-To: <20120613121743.GN4545@opensource.wolfsonmicro.com>
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

On Wed, Jun 13, 2012 at 8:17 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jun 11, 2012 at 06:04:36PM +0800, Zhangfei Gao wrote:
>
>> These patches provide mmp audio support under alsa via dmaengine
>> Support platfrom pxa688 and pxa910
>> mmp_tdma.c and mmp-pcm.c is shared for pxa688 and pxa910
>> pxa688 (mmp2) use mmp2-sspa.c
>> pxa910 directly use pxa-ssp.c
>> mmp_tdma.c is under dmaengine framework
>
> Applied 2-4. =A0I'm not seeing a direct code dependency between this and
> the dmaengine driver in patch 1 (or review of it from Vinod yet) so I'm
> expecting that to go via the dmaengine tree.

Great, thanks Mark.
By the way, patch 05 "ASoC: add ttc-dkb machine support" also based on
these patches.
ttc-dkb (pxa910) and brownstone (pxa688) are sharing mmp-pcm.c and mmp-tdma=
.c.
