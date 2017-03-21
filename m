From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 0/2] wm8960: Relax bit clock computation
Date: Tue, 21 Mar 2017 17:03:23 +0200
Message-ID: <1490108605-20538-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0040.outbound.protection.outlook.com [104.47.1.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 147BF266718
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 16:03:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com
Cc: shengjiu.wang@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, viorel.suman@nxp.com, mihai.serban@nxp.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This patch series allows playing S20_3LE .wav samples with wm8960 codec.

First patch does a small refactoring of sysclk frequency search because
wm8960_configure_sysclk was getting pretty convoluted.

The second patch allows relaxing bitclock computation in the way that
if an exact bitclk couldn't be derived from sysclk it chooses the
smalles available bitclk greater than the desired bitclk.

Changes since v2:
	* do not differentiate between relaxed and exact match

Changes since v1:
        * dropped the RFC tag
        * comments in each individual patch

Daniel Baluta (2):
  ASoC: codec: wm8960: Refactor sysclk freq search
  ASoC: codec: wm8960: Relax bit clock computation

 sound/soc/codecs/wm8960.c | 90 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 19 deletions(-)

-- 
2.7.4
