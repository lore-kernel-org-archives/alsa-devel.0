From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 4/4] soc-cache: let reg be AND'ed by 0xff
	instead of data buffer for 8_8 mode
Date: Thu, 18 Mar 2010 16:17:01 +0800
Message-ID: <1268900221-6833-5-git-send-email-21cnbao@gmail.com>
References: <1268900221-6833-1-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-2-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-3-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-4-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B68A24590
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 09:18:08 +0100 (CET)
In-Reply-To: <1268900221-6833-4-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

The registers for AD193X are defined as 0x800-0x810 for spi which uses 16_8 mode,
for i2c to support AD1937, we will use 8_8 mode, only the low byte of 0x800-0x810
is valid.
The patch will not destory other codecs, but make soc cache interface more useful.

Signed-off-by: Barry Song <barry.song@analog.com>
---
 sound/soc/soc-cache.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 91db7af..9dfe9a5 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -159,7 +159,8 @@ static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
 
 	BUG_ON(codec->volatile_register);
 
-	data[0] = reg & 0xff;
+	reg &= 0xff;
+	data[0] = reg;
 	data[1] = value & 0xff;
 
 	if (reg < codec->reg_cache_size)
@@ -180,6 +181,7 @@ static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
 	u8 *cache = codec->reg_cache;
+	reg &= 0xff;
 	if (reg >= codec->reg_cache_size)
 		return -1;
 	return cache[reg];
-- 
1.5.6.3
