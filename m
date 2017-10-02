From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH 0/3] ASoC: img-i2s-out: Add power management
Date: Mon,  2 Oct 2017 10:59:44 +0100
Message-ID: <1506938387-627-1-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10079.outbound.protection.outlook.com [40.107.1.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 60D2B26719A
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 11:59:58 +0200 (CEST)
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

This patch set adds power managment to the img-i2s-out driver.  The
first patch renames existing 'suspend' and 'resume' functions to
'runtime_suspend' and 'runtime_resume', which is what they actually
are, the second patch adds system PM suspend / resume handling and the
third patch adds control of the sys clock to runtime PM.

Ed Blake (3):
  ASoC: img-i2s-out: Rename suspend / resume funcs
  ASoC: img-i2s-out: Add suspend / resume handling
  ASoC: img-i2s-out: Add control of sys clock to runtime PM

 sound/soc/img/img-i2s-out.c | 116 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 87 insertions(+), 29 deletions(-)

-- 
1.9.1
