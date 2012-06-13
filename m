From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 0/5] mmp audio support
Date: Wed, 13 Jun 2012 19:58:48 +0000
Message-ID: <201206131958.49446.arnd@arndb.de>
References: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
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
Cc: Eric Miao <eric.y.miao@gmail.com>, Leo Yan <leoy@marvell.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, alsa-devel@vger.kernel.org, Qiao Zhou <zhouqiao@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Liam Girdwood <lrg@ti.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Monday 11 June 2012, Zhangfei Gao wrote:
> 
> v1->v2:
> modify accroingly with suggestion from Vinod and Mark
> remove deprecated chan->private and dma.h
> remove prep_slave_sg
> remove module_init and move operation to probe
> misc change

It seems that this driver is missing DT bindings, which really need to get
added. The brownstone platform is currently supported using both DT and
ATAG probing, but we want to remove the ATAG variant eventually, so adding
a new driver for that platform without support for DT booting is a step in
the wrong direction.

	Arnd
