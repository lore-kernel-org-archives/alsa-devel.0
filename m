From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 0/2] tlv320aic31xx PLL programming fix and
	cleanup
Date: Wed, 3 Sep 2014 15:52:32 +0300
Message-ID: <cover.1409747234.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id D08482655E3
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 14:52:39 +0200 (CEST)
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
Cc: peter.ujfalusi@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org, linux-omap@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The first patch is the fix and the second is only a cleanup.

Jyri Sarha (2):
  ASoC: tlv320aic31xx: Fix 24bit samples with I2S format and 12MHz mclk
  ASoC: tlv320aic31xx: Choose PLL p divider automatically

 sound/soc/codecs/tlv320aic31xx.c |  128 +++++++++++++++++++++++---------------
 1 file changed, 77 insertions(+), 51 deletions(-)

-- 
1.7.9.5
