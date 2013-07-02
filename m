From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 0/2] ASoC: atmel-pcm: use generic dmaengine
	framework
Date: Tue,  2 Jul 2013 15:55:16 +0800
Message-ID: <1372751718-1437-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id EFBA7265307
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2013 09:58:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, richard.genoud@gmail.com, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-sound@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

this patch series is based on next-20130701

Bo Shen (2):
  ASoC: atmel_ssc_dai: move set dma data to startup callback
  ASoC: atmel-pcm: use generic dmaengine framework

 sound/soc/atmel/atmel-pcm-dma.c |  118 ++++++---------------------------------
 sound/soc/atmel/atmel_ssc_dai.c |   33 ++++++-----
 2 files changed, 32 insertions(+), 119 deletions(-)

-- 
1.7.9.5
