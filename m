From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v2 0/3] Add support for Wolfson Micro WM8998
	codec
Date: Mon, 28 Sep 2015 14:01:06 +0100
Message-ID: <1443445269-11746-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 69549265090
 for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2015 15:01:13 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This set of patches is based on broonie/regulator.git/for-next and
broonie/sound.git/for-next branches.

Richard Fitzgerald (3):
  regulator: arizona: add support for WM8998 and WM1814
  ASoC: arizona: add defines for single-input gain control
  ASoC: wm8998: Initial WM8998 codec driver

 drivers/regulator/arizona-ldo1.c |    2 +
 sound/soc/codecs/Kconfig         |    6 +
 sound/soc/codecs/Makefile        |    2 +
 sound/soc/codecs/arizona.c       |   33 +
 sound/soc/codecs/arizona.h       |   12 +-
 sound/soc/codecs/wm8998.c        | 1430 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8998.h        |   23 +
 7 files changed, 1507 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/wm8998.c
 create mode 100644 sound/soc/codecs/wm8998.h

-- 
1.9.1
