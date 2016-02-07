From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] ALSA: firewire-digi00x: Drop bogus const type
	qualifier on dot_scrt()
Date: Sun,  7 Feb 2016 15:14:15 +0100
Message-ID: <1454854455-20894-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
 by alsa0.perex.cz (Postfix) with ESMTP id BA679260474
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 08:59:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

sound/firewire/digi00x/amdtp-dot.c:67: warning: type qualifiers ignored on function return type

Drop the bogus "const" type qualifier on the return type of dot_scrt()
to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 sound/firewire/digi00x/amdtp-dot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/digi00x/amdtp-dot.c b/sound/firewire/digi00x/amdtp-dot.c
index b02a5e8cad448c40..0ac92aba5bc1c9a4 100644
--- a/sound/firewire/digi00x/amdtp-dot.c
+++ b/sound/firewire/digi00x/amdtp-dot.c
@@ -63,7 +63,7 @@ struct amdtp_dot {
 #define BYTE_PER_SAMPLE (4)
 #define MAGIC_DOT_BYTE (2)
 #define MAGIC_BYTE_OFF(x) (((x) * BYTE_PER_SAMPLE) + MAGIC_DOT_BYTE)
-static const u8 dot_scrt(const u8 idx, const unsigned int off)
+static u8 dot_scrt(const u8 idx, const unsigned int off)
 {
 	/*
 	 * the length of the added pattern only depends on the lower nibble
-- 
1.9.1
