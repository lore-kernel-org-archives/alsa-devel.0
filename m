From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RFC PATCH 0/2] wm8960: Relax bit clock computation
Date: Wed, 15 Mar 2017 17:33:04 +0200
Message-ID: <1489591986-6302-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10071.outbound.protection.outlook.com [40.107.1.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 480DD266861
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 16:33:17 +0100 (CET)
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

This patch series allows running S20_3LE encoded samples on wm8960 codec.

First patch does a small refactoring of sysclk frequency search because
wm8960_configure_sysclk was getting pretty convoluted.

The second patch allows relaxing bitclock computation in the way that
if an exact bitclk couldn't be derived from sysclk it chooses the
smalles available bitclk greater than the desired bitclk.

For a better reviewing experience you can checked the squashed version
of this patches here:

http://pastebin.com/gBJ3DBSu

Note that this is a follow up of:

"ASoC: wm8960: Use physical width for bclk"

discussion archived here:

http://mailman.alsa-project.org/pipermail/alsa-devel/2017-March/118735.html

Daniel Baluta (2):
  ASoC: codec: wm8960: Refactor sysclk freq search
  ASoC: codec: wm8960: Relax bit clock computation

 sound/soc/codecs/wm8960.c | 113 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 91 insertions(+), 22 deletions(-)

-- 
2.7.4
