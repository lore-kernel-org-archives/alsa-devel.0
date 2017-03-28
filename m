From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 0/2] imx-wm8962: Let codec driver
	enable/disable its MCLK
Date: Tue, 28 Mar 2017 11:58:50 +0300
Message-ID: <1490691532-2086-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30058.outbound.protection.outlook.com [40.107.3.58])
 by alsa0.perex.cz (Postfix) with ESMTP id EC48C266703
 for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2017 10:59:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: nicoleotsuka@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: timur@tabi.org, Xiubo.Lee@gmail.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

This is a small cleanup patch series which removes MLCK enable/disable
from imx-wm8962 machine driver and lets the codec handle that.

While reviewing this, Nicolin noticed that codec_clk cleanup is not correct
so the second patch fixes this.

Changes since v2:
	* added 2/2 patch to fix codec_clk cleanup
	* fixed prefix subject

Daniel Baluta (2):
  ASoC: imx-wm8962: Let codec driver enable/disable its MCLK
  ASoC: imx-wm8962: Fix codec_clk cleanup

 sound/soc/fsl/imx-wm8962.c | 41 +++++++++--------------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

-- 
2.7.4
