From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [GIT PULL] ASoC: DMA deferred probe dependencies
Date: Tue, 10 Dec 2013 10:18:40 -0700
Message-ID: <1386695920-1447-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E21A2652AC
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 18:18:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

Mark,

The following branch/patch is a dependency for my "ASoC: dmaengine:
support deferred probe for DMA channels". If you could pull the branch
below into your topic/dma, then merge my ASoC patch, that would be
great. I would then like to merge your topic/dma into the Tegra tree as
a baseline for the Tegra conversion to the standard DMA DT bindings.

Vinod has confirmed this his topic/defer_probe branch is stable, and
won't be rebased:

https://lkml.org/lkml/2013/12/10/463 
Re: [PATCH V4] dma: add channel request API that supports deferred probe

Thanks.

----------------------------------------------------------------

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1

are available in the git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git topic/defer_probe

for you to fetch changes up to 0ad7c00057dc1640647c1dc81ccbd009de17a767:

  dma: add channel request API that supports deferred probe

----------------------------------------------------------------

Stephen Warren (1):
      dma: add channel request API that supports deferred probe

 drivers/dma/dmaengine.c   | 35 +++++++++++++++++++++++++++++++----
 drivers/dma/of-dma.c      | 15 +++++++++------
 include/linux/dmaengine.h |  8 ++++++++
 3 files changed, 48 insertions(+), 10 deletions(-)
