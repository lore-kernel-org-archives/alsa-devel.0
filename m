From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 0/2] ASoC: codec: wm8960: Relax bit clock
	computation when using PLL
Date: Thu, 6 Apr 2017 14:51:52 +0300
Message-ID: <1491479514-24862-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0055.outbound.protection.outlook.com [104.47.0.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 26361267283
 for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2017 13:52:04 +0200 (CEST)
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

This is a follow up of patch series sent here:

http://mailman.alsa-project.org/pipermail/alsa-devel/2017-April/119517.html

where only patch 1/2 was merged.

In this new patch series, we fix a problem with patch already merged and
then we relax bit clock computation when using PLL the same as we did
in patch 2/2 of previous series.

Daniel Baluta (2):
  ASoC: codec: wm8960: Stop when a matching PLL freq is found
  ASoC: codec: wm8960: Relax bit clock computation when using PLL

 sound/soc/codecs/wm8960.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

-- 
2.7.4
