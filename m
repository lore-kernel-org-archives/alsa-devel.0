From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] Input: add microphone insert switch
	definition
Date: Sun, 27 Jul 2008 12:12:23 +0100
Message-ID: <1217157145-7647-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080727111107.GA6667@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2329A103812
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jul 2008 13:12:33 +0200 (CEST)
In-Reply-To: <20080727111107.GA6667@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dmitry Torokhov <dtor@mail.ru>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Add a new switch type to the input API for reporting microphone
insertion. This will be used by the ALSA jack reporting API.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 include/linux/input.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index d150c57..d297dec 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -640,6 +640,7 @@ struct input_absinfo {
 #define SW_RFKILL_ALL		0x03  /* rfkill master switch, type "any"
 					 set = radio enabled */
 #define SW_RADIO		SW_RFKILL_ALL	/* deprecated */
+#define SW_MICROPHONE_INSERT	0x04  /* set = inserted */
 #define SW_MAX			0x0f
 #define SW_CNT			(SW_MAX+1)
 
-- 
1.5.4.3
