From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 0/2] Relax bitclk computation when using PLL
Date: Wed, 26 Apr 2017 16:09:50 +0300
Message-ID: <1493212192-7930-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0083.outbound.protection.outlook.com [104.47.41.83])
 by alsa0.perex.cz (Postfix) with ESMTP id 81A7B266FEC
 for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2017 15:10:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.com, ckeepax@opensource.wolfsonmicro.com, arnd@arndb.de, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Daniel Baluta <daniel.baluta@nxp.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Using strict bitclk requirements we cannot support all promised
rates and formats. For this reason we relax bitclk computation
by choosing the best available bitclk.

First patch in the series is based on Arnd's patch:

http://mailman.alsa-project.org/pipermail/alsa-devel/2017-April/119899.html

Second one does the actual bitclk relaxation.

Daniel Baluta (2):
  ASoC: codec: wm9860: avoid maybe-uninitialized warning
  ASoC: codec: wm8960: Relax bit clock computation when using PLL

 sound/soc/codecs/wm8960.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

-- 
2.7.4
