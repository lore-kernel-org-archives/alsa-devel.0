From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/2] ALSA: firewire-tascam: Use do { } while
	for loops executed at least once
Date: Mon, 15 May 2017 10:19:10 +0200
Message-ID: <1494836350-28790-2-git-send-email-geert@linux-m68k.org>
References: <1494836350-28790-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FC482672BC
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 10:19:13 +0200 (CEST)
In-Reply-To: <1494836350-28790-1-git-send-email-geert@linux-m68k.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

If a loop is intended to be executed at least once, it is better to use
"do { ... } while (...)" instead of "while (...) { ... }".
The former is easier to understand for the casual reviewer, and doesn't
require preinitializing the canary variable.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.
---
 sound/firewire/tascam/tascam-stream.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/tascam/tascam-stream.c b/sound/firewire/tascam/tascam-stream.c
index e433b92ac6904db5..4ea6845aae87fdef 100644
--- a/sound/firewire/tascam/tascam-stream.c
+++ b/sound/firewire/tascam/tascam-stream.c
@@ -80,17 +80,17 @@ static int set_clock(struct snd_tscm *tscm, unsigned int rate,
 
 int snd_tscm_stream_get_rate(struct snd_tscm *tscm, unsigned int *rate)
 {
-	u32 data = 0x0;
 	unsigned int trials = 0;
+	u32 data;
 	int err;
 
-	while (data == 0x0 && trials++ < 5) {
+	do {
 		err = get_clock(tscm, &data);
 		if (err < 0)
 			return err;
 
 		data = (data & 0xff000000) >> 24;
-	}
+	} while (data == 0x0 && ++trials < 5);
 
 	/* Check base rate. */
 	if ((data & 0x0f) == 0x01)
-- 
2.7.4
