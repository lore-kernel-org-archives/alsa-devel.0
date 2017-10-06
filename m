From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH v2 0/2] dma: img-spdif-out: Add power management
Date: Fri,  6 Oct 2017 15:56:05 +0100
Message-ID: <20171006145607.13709-1-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10070.outbound.protection.outlook.com [40.107.1.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BD84266991
 for <alsa-devel@alsa-project.org>; Fri,  6 Oct 2017 16:56:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Ed Blake <ed.blake@sondrel.com>
List-Id: alsa-devel@alsa-project.org

This patch set adds power managment to the img-spdif-out driver.  The
first patch adds system PM suspend / resume handling and the second
patch adds control of the sys clock to runtime PM.

Changes in v2:
 - Changed from ASoC specific pm callbacks to device ones

Ed Blake (2):
  ASoC: img-spdif-out: Add suspend / resume handling
  ASoC: img-spdif-out: Add control of sys clock to runtime PM

 sound/soc/img/img-spdif-out.c | 73 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 13 deletions(-)

-- 
2.11.0
