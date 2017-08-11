From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: seq: Fix CONFIG_SND_SEQ_MIDI dependency
Date: Fri, 11 Aug 2017 11:14:13 +0200
Message-ID: <20170811091413.9329-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F0F026648D
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 11:14:15 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 72584ABB8
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 09:14:15 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

The commit 0181307abc1d ("ALSA: seq: Reorganize kconfig and build")
rewrote the dependency of each sequencer module in a standard way, but
there was one change applied mistakenly: CONFIG_SND_SEQ_MIDI isn't
enabled properly by CONFIG_SND_RAWMIDI.  I seem to have changed the
wrong one instead, CONFIG_SND_SEQ_MIDI_EMUL, which is eventually
reverse-selected by CONFIG_SND_SEQ_MIDI itself.  This ended up the
lack of snd-seq-midi module as reported below.

The fix is to put def_tristate properly to CONFIG_SND_SEQ_MIDI instead
of *_MIDI_EMUL entry.

Fixes: 0181307abc1d ("ALSA: seq: Reorganize kconfig and build")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=196633
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/Kconfig b/sound/core/seq/Kconfig
index a536760a94c2..45c1336c6597 100644
--- a/sound/core/seq/Kconfig
+++ b/sound/core/seq/Kconfig
@@ -47,10 +47,10 @@ config SND_SEQ_HRTIMER_DEFAULT
 	  timer.
 
 config SND_SEQ_MIDI_EVENT
-	def_tristate SND_RAWMIDI
+	tristate
 
 config SND_SEQ_MIDI
-	tristate
+	def_tristate SND_RAWMIDI
 	select SND_SEQ_MIDI_EVENT
 
 config SND_SEQ_MIDI_EMUL
-- 
2.13.3
