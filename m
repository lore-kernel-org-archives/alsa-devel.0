From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: emux: remove unused redundant variable p2
Date: Mon, 16 Oct 2017 12:18:39 +0100
Message-ID: <20171016111839.11365-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EB21267193
 for <alsa-devel@alsa-project.org>; Mon, 16 Oct 2017 13:18:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The variable p2 is being assigned but never used, it is redundant
and can be safely removed.  Cleans up clang warning: Value stored to
'p2' is never read.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/synth/emux/emux_oss.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/synth/emux/emux_oss.c b/sound/synth/emux/emux_oss.c
index de19e108974a..764ff4bc2089 100644
--- a/sound/synth/emux/emux_oss.c
+++ b/sound/synth/emux/emux_oss.c
@@ -430,7 +430,6 @@ gusspec_control(struct snd_emux *emu, struct snd_emux_port *port, int cmd,
 {
 	int voice;
 	unsigned short p1;
-	short p2;
 	int plong;
 	struct snd_midi_channel *chan;
 
@@ -445,7 +444,6 @@ gusspec_control(struct snd_emux *emu, struct snd_emux_port *port, int cmd,
 	chan = &port->chset.channels[voice];
 
 	p1 = *(unsigned short *) &event[4];
-	p2 = *(short *) &event[6];
 	plong = *(int*) &event[4];
 
 	switch (cmd) {
-- 
2.14.1
