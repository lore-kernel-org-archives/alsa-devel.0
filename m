From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] ASoC: Do not swap upper and lower byte in
	snd_soc_4_12_spi_write
Date: Thu,  5 May 2011 19:52:44 +0200
Message-ID: <1304617966-4410-2-git-send-email-lars@metafoo.de>
References: <1304617966-4410-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-227.synserver.de
	[212.40.185.227])
	by alsa0.perex.cz (Postfix) with ESMTP id B8C6D2414E
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 19:53:12 +0200 (CEST)
In-Reply-To: <1304617966-4410-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mike Frysinger <vapier@gentoo.org>
Cc: device-driver-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

snd_soc_4_12_spi_write swaps the upper and the lower byte of the to be
transferred data. The function was added for the ad1836, which was used in
16bit mode on the blackfin boards. In this mode the blackfin SPI core swaps the
upper and the lower byte before putting them on the wire (i.e interprets the
word as litte-endian), so the data had to be passed in reversed, so it would
appear in correct order on the wire.
Since this behaviour not necessarily applicable to other configurations
remove the special case.

The blackfin boards using the ad1836 were changed to used 8-bit mode in the
previous commit.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-cache.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index a217db2..080fab2 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -115,8 +115,8 @@ static int snd_soc_4_12_spi_write(void *control_data, const char *data,
 {
 	u8 msg[2];
 
-	msg[0] = data[1];
-	msg[1] = data[0];
+	msg[0] = data[0];
+	msg[1] = data[1];
 
 	return do_spi_write(control_data, msg, len);
 }
-- 
1.7.2.5
