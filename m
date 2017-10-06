From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH v2 0/2] ASoC: img-i2s-in: Add power management
Date: Fri,  6 Oct 2017 15:50:38 +0100
Message-ID: <20171006145040.13436-1-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20052.outbound.protection.outlook.com [40.107.2.52])
 by alsa0.perex.cz (Postfix) with ESMTP id E1F5C266991
 for <alsa-devel@alsa-project.org>; Fri,  6 Oct 2017 16:50:51 +0200 (CEST)
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

This patch set adds power managment to the img-i2s-in driver. The first
patch adds system PM suspend / resume handling and the second patch
adds runtime PM.

Changes in v2:
 - Changed from ASoC specific pm callbacks to device ones
 - Errors returned from pm_runtime_get_sync are now handled

Ed Blake (2):
  ASoC: img-i2s-in: Add suspend / resume handling
  ASoC: img-i2s-in: Add runtime PM

 sound/soc/img/img-i2s-in.c | 130 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 118 insertions(+), 12 deletions(-)

-- 
2.11.0
