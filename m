From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH 0/6] ASoC: Convert ALC5632 codec to use regmap
	API
Date: Wed, 16 Nov 2011 12:06:57 +0200
Message-ID: <1321438023-29660-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CFEF24434
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 11:07:17 +0100 (CET)
Received: by eyz10 with SMTP id 10so213890eyz.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 02:07:15 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

Leon Romanovsky (6):
  ASoC: Convert ALC5632 codec to use regmap API
  ASoC: alc5632: Fix compile without CONFIG_I2C
  ASoC: alc5632: Fix compile without CONFIG_PM
  ASoC: alc5632: Remove unrelevant registers and name the relevant
  ASoC: alc5632: Added support of two undocumented registers
  ASoC: alc5632: Update of i2c_probe function to use regmap API only

 sound/soc/codecs/alc5632.c |  222 ++++++++++++++++++++++++++------------------
 sound/soc/codecs/alc5632.h |    2 +
 2 files changed, 135 insertions(+), 89 deletions(-)

-- 
1.7.3.4
