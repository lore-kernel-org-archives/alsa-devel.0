From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH v2 0/2] ASoC: img-spdif-in: Add power management
Date: Fri,  6 Oct 2017 15:53:53 +0100
Message-ID: <20171006145355.13616-1-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0055.outbound.protection.outlook.com [104.47.2.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 01774266991
 for <alsa-devel@alsa-project.org>; Fri,  6 Oct 2017 16:54:01 +0200 (CEST)
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

This patch set adds power managment to the img-spdif-in driver.  The
first patch adds system PM suspend / resume handling and the second
patch adds runtime PM.

Changes in v2:
 - Changed from ASoC specific pm callbacks to device ones

Ed Blake (2):
  ASoC: img-spdif-in: Add suspend / resume handling
  ASoC: img-spdif-in: Add runtime PM

 sound/soc/img/img-spdif-in.c | 110 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 99 insertions(+), 11 deletions(-)

-- 
2.11.0
