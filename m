From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 0/7] Enablement of BT I2S controller instance
	for AMD APUs
Date: Mon, 12 Mar 2018 12:04:13 +0530
Message-ID: <1520836460-21809-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0089.outbound.protection.outlook.com [104.47.40.89])
 by alsa0.perex.cz (Postfix) with ESMTP id B813A266E77
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 07:31:59 +0100 (CET)
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
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, lgirdwood@gmail.com, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
List-Id: alsa-devel@alsa-project.org

This patch set updates Audio CoProcessor (ACP) audio drivers to enable BT I2S controller instance.
In Audio Coprocessor, There are three I2S controllers can be configured/enabled.(I2S SP, I2S MICSP, BT I2S)
Default enabled I2S controller instance is I2S SP instance.
There is a requirement to enable BT I2S controller Instance along with I2S SP controller instance.
This patch set bring up functionality to render & capture on BT I2S controller instance.

The current code is based on asoc-next, but I'm happy to rebase on whatever tree this ends up going through if there are any problems applying.

Vijendar Mukunda (7):
  ASoC: amd: dma driver changes for BT I2S controller instance
  ASoC: amd: dma descriptor changes for BT I2S Instance
  ASoC: amd: Interrupt handler changes for BT I2S instance
  ASoC: amd: prepare callback modifications for bt i2s instance
  ASoC: amd: pointer and trigger callback modifications for bt i2s
  ASoC: amd: 16bit resolution support for bt i2s instance
  ASoC: amd: enabling bt i2s config after acp reset

 sound/soc/amd/acp-pcm-dma.c | 521 +++++++++++++++++++++++++++++++++++---------
 sound/soc/amd/acp.h         |  52 ++++-
 2 files changed, 460 insertions(+), 113 deletions(-)

-- 
2.7.4
