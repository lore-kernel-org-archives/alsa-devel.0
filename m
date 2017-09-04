From: Sergej Sawazki <sergej@taudac.com>
Subject: [PATCH 0/3] ASoC: wm8741: Varios enhancements
Date: Mon,  4 Sep 2017 21:34:10 +0200
Message-ID: <1504553653-8144-1-git-send-email-sergej@taudac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s62.goserver.host (s62.goserver.host [37.17.224.62])
 by alsa0.perex.cz (Postfix) with ESMTP id 9145826683B
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 21:34:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, ckeepax@opensource.cirrus.com
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, Sergej Sawazki <sergej@taudac.com>
List-Id: alsa-devel@alsa-project.org

This patch series contains the following 3 patches for the WM8741 codec driver.

 1) Adds digital mute callback.
 2) Sets oversampling rate mode (OSR), required for sampling rates > 48kHz.
 3) Sets MCLK/LRCLK sampling rate ratio (SR), avoids relying on auto-detection.

Sergej Sawazki (3):
  ASoC: wm8741: Add digital mute callback
  ASoC: wm8741: Set OSR mode in hw_params()
  ASoC: wm8741: Set SR mode in hw_params()

 sound/soc/codecs/wm8741.c | 49 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

-- 
2.7.4
