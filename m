From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 0/6] ASoC: wm_adsp: Couple of updates
Date: Fri,  1 Nov 2013 15:56:51 +0000
Message-ID: <1383321417-1133-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A0D0D26582D
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 17:05:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Patch-set generated against sound/for-next this time.

Dimitris Papastamos (5):
  ASoC: wm_adsp: Print error when regmap reads/writes fail
  ASoC: wm_adsp: Release firmware on memory allocation failure
  ASoC: wm_adsp: Add debug info on get()/put() transfers
  ASoC: wm_adsp: Remove and free algorithm regions for ADSP1
  ASoC: wm_adsp: Print out the firmware version

Nariman Poushin (1):
  ASoC: wm_adsp: Interpret ADSP memory region lengths as 32  bit words

 sound/soc/codecs/wm_adsp.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

-- 
1.8.4.2
