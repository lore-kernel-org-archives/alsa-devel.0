From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH 0/3] dma: img-spdif-out: Add power management
Date: Mon,  2 Oct 2017 11:01:54 +0100
Message-ID: <1506938517-810-1-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0075.outbound.protection.outlook.com [104.47.0.75])
 by alsa0.perex.cz (Postfix) with ESMTP id F1DE8267541
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 12:02:09 +0200 (CEST)
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
first patch renames existing 'suspend' and 'resume' functions to
'runtime_suspend' and 'runtime_resume', which is what they actually
are, the second patch adds system PM suspend / resume handling and the
third patch adds control of the sys clock to runtime PM.

Ed Blake (3):
  ASoC: img-spdif-out: Rename suspend / resume funcs
  ASoC: img-spdif-out: Add suspend / resume handling
  ASoC: img-spdif-out: Add control of sys clock to runtime PM

 sound/soc/img/img-spdif-out.c | 89 +++++++++++++++++++++++++++++++++----------
 1 file changed, 68 insertions(+), 21 deletions(-)

-- 
1.9.1
