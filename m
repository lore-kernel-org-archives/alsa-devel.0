From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 0/2] ASoC: codec: wm8960: Relax bit clock
	computation when using PLL
Date: Tue, 4 Apr 2017 19:45:12 +0300
Message-ID: <1491324314-27067-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0054.outbound.protection.outlook.com [104.47.1.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 27A6B26683C
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 18:45:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, shengjiu.wang@nxp.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org, viorel.suman@nxp.com, mihai.serban@nxp.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This is a follow up of commit 3c01b9ee2ab ("ASoC: codec: wm8960: Relax bit clock computation")
where we relaxed bitclk when sysclk was derived from MCLK.

Now, we do the same thing for sysclk derived using PLL.

Daniel Baluta (2):
  ASoC: codec: wm9860: Refactor PLL out freq search
  ASoC: codec: wm8960: Relax bit clock computation when using PLL

 sound/soc/codecs/wm8960.c | 105 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 76 insertions(+), 29 deletions(-)

-- 
2.7.4
