From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH 0/3] Add sai master mode,
	tdm slot operation and add some sample rate support
Date: Mon, 11 May 2015 18:24:40 +0800
Message-ID: <cover.1431337606.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0148.outbound.protection.outlook.com [157.56.111.148])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D3422606F5
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 12:23:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: nicoleotsuka@gmail.com
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Add SAI master mode support.
Add tdm slots operation for SAI master mode.
Add 12kHz, 24kHz, 176.4kHz and 192kHz sample rate support.

Zidan Wang (3):
  SoC: fsl_sai: add sai master mode support
  ASoC: fsl_sai: Add tdm slots operation for SAI master mode
  ASoC: fsl_sai: add 12kHz, 24kHz, 176.4kHz and 192kHz sample rate
    support

 sound/soc/fsl/fsl_sai.c | 165 +++++++++++++++++++++++++++++++++++++++++++++---
 sound/soc/fsl/fsl_sai.h |  12 +++-
 2 files changed, 165 insertions(+), 12 deletions(-)

-- 
1.9.1
