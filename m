From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ALSA: firewire-motu: mark trace helpers as
	__maybe_unused
Date: Wed, 19 Apr 2017 19:51:29 +0200
Message-ID: <20170419175158.5607-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by alsa0.perex.cz (Postfix) with ESMTP id A6B1D266B23
 for <alsa-devel@alsa-project.org>; Wed, 19 Apr 2017 19:52:07 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Two functions were introduced for the purpose of tracing but cause warnings
when tracing is disabled:

sound/firewire/motu/amdtp-motu.c:284:13: error: 'copy_message' defined but not used [-Werror=unused-function]
 static void copy_message(u64 *frames, __be32 *buffer, unsigned int data_blocks,
sound/firewire/motu/amdtp-motu.c:271:13: error: 'copy_sph' defined but not used [-Werror=unused-function]
 static void copy_sph(u32 *frames, __be32 *buffer, unsigned int data_blocks,

Marking them as __maybe_unused will do the right thing here.

Fixes: 17909c1b3058 ("ALSA: firewire-motu: add tracepoints for SPH in IEC 61883-1 fashion")
Fixes: c6b0b9e65f09 ("ALSA: firewire-motu: add tracepoints for messages for unique protocol")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/firewire/motu/amdtp-motu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/motu/amdtp-motu.c b/sound/firewire/motu/amdtp-motu.c
index 996b5f818918..96f0091144bb 100644
--- a/sound/firewire/motu/amdtp-motu.c
+++ b/sound/firewire/motu/amdtp-motu.c
@@ -268,8 +268,9 @@ static void read_midi_messages(struct amdtp_stream *s, __be32 *buffer,
 }
 
 /* For tracepoints. */
-static void copy_sph(u32 *frames, __be32 *buffer, unsigned int data_blocks,
-		     unsigned int data_block_quadlets)
+static void __maybe_unused copy_sph(u32 *frames, __be32 *buffer,
+				    unsigned int data_blocks,
+				    unsigned int data_block_quadlets)
 {
 	unsigned int i;
 
@@ -281,8 +282,9 @@ static void copy_sph(u32 *frames, __be32 *buffer, unsigned int data_blocks,
 }
 
 /* For tracepoints. */
-static void copy_message(u64 *frames, __be32 *buffer, unsigned int data_blocks,
-			 unsigned int data_block_quadlets)
+static void __maybe_unused copy_message(u64 *frames, __be32 *buffer,
+					unsigned int data_blocks,
+					unsigned int data_block_quadlets)
 {
 	unsigned int i;
 
-- 
2.9.0
