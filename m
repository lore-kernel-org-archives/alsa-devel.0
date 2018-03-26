From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 0/8] Enablement of BT I2S controller instance
	for AMD APUs
Date: Mon, 26 Mar 2018 18:42:55 +0530
Message-ID: <1522069983-11381-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0077.outbound.protection.outlook.com [104.47.33.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 79012266FA1
 for <alsa-devel@alsa-project.org>; Mon, 26 Mar 2018 15:11:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, lgirdwood@gmail.com, Akshu.Agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

This patch set updates Audio CoProcessor (ACP) audio drivers to enable
BT I2S controller instance. In Audio Coprocessor, There are three I2S
controllers can be configured/enabled.(I2S SP, I2S MICSP, BT I2S)
Default enabled I2S controller instance is I2S SP instance.
There is a requirement to enable BT I2S controller Instance along with
I2S SP controller instance. This patch set bring up functionality to render
& capture on BT I2S controller instance.

The current patch set also includes a new dependent patch.

The current code is based on asoc-next, but I'm happy to rebase on whatever
tree this ends up going through if there are any problems applying.

Vijendar Mukunda (8):
  ASoC: dwc: I2S Controller instance param added
  ASoC: amd: dma driver changes for BT I2S controller instance
  ASoC: amd: dma descriptor changes for BT I2S Instance
  ASoC: amd: Interrupt handler changes for BT I2S instance
  ASoC: amd: prepare callback modifications for bt i2s instance
  ASoC: amd: pointer and trigger callback modifications for bt i2s
  ASoC: amd: 16bit resolution support for bt i2s instance
  ASoC: amd: enabling bt i2s config after acp reset

 include/sound/designware_i2s.h |   6 +
 sound/soc/amd/acp-pcm-dma.c    | 531 +++++++++++++++++++++++++++++++++--------
 sound/soc/amd/acp.h            |  50 +++-
 sound/soc/dwc/dwc-i2s.c        |   1 +
 sound/soc/dwc/local.h          |   1 +
 5 files changed, 481 insertions(+), 108 deletions(-)

-- 
2.7.4
