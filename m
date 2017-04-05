From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 0/2] ASoC: codec: wm8960: Relax bit clock
	computation when using PLL
Date: Wed, 5 Apr 2017 16:26:36 +0300
Message-ID: <1491398798-27829-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00066.outbound.protection.outlook.com [40.107.0.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B365266BA4
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 15:26:52 +0200 (CEST)
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

Changes since v1:
	* fixed "may be used uninitialized" warnings [i strongly believe
	they were compiler false positive - see full warning log here (1)]
	* fixed break for inner loop

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2017-April/119513.html

Daniel Baluta (2):
  ASoC: codec: wm9860: Refactor PLL out freq search
  ASoC: codec: wm8960: Relax bit clock computation when using PLL

 sound/soc/codecs/wm8960.c | 109 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 80 insertions(+), 29 deletions(-)

-- 
2.7.4
