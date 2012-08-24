From: Sangbeom Kim <sbkim73@samsung.com>
Subject: Re: [PATCH] ASoC: samsung dma - prepare dma
	in	start/resume trigger path
Date: Fri, 24 Aug 2012 16:41:32 +0900
Message-ID: <00df01cd81cb$e21d2f00$a6578d00$@com>
References: <1345755069-9512-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by alsa0.perex.cz (Postfix) with ESMTP id 98399265B56
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2012 09:41:34 +0200 (CEST)
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M9900DXH1D5JNS0@mailout4.samsung.com> for
 alsa-devel@alsa-project.org; Fri, 24 Aug 2012 16:41:32 +0900 (KST)
Received: from DOSBKIM7302 ([10.90.35.108])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M9900LAV1D7XE90@mmp1.samsung.com> for
 alsa-devel@alsa-project.org; Fri, 24 Aug 2012 16:41:31 +0900 (KST)
In-reply-to: <1345755069-9512-1-git-send-email-dgreid@chromium.org>
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Dylan Reid' <dgreid@chromium.org>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Cc: kgene.kim@samsung.com, ben-linux@fluff.org, jassi.brar@samsung.com, padma.v@samsung.com, broonie@opensource.wolfsonmicro.com, alim.akhtar@samsung.com, olofj@chromium.org
List-Id: alsa-devel@alsa-project.org

Hi!

On Thu, Aug 24, 2012 at 5:51 AM, Dylan Reid wrote:
> On suspend all dma transactions are terminated (by the stop/suspend
> trigger calling ops->stop), they need to be set up again during resume.
> Move the prepare op to the start/resume/unpause trigger path so that dma
> and audio will restart on resume/unpause.
Do you mean that currently, suspend/resume can't be supported?

Thanks,
Sangbeom.
