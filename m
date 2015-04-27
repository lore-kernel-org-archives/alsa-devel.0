From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: emux: Fix mutex deadlock at unloading
Date: Mon, 27 Apr 2015 14:59:54 +0200
Message-ID: <1430139594-3194-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 62ABA260581
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 14:59:55 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 21878AB22
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 12:59:55 +0000 (UTC)
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

The emux-synth driver has a possible AB/BA mutex deadlock at unloading
the emu10k1 driver:

  snd_emux_free() ->
    snd_emux_detach_seq(): mutex_lock(&emu->register_mutex) ->
      snd_seq_delete_kernel_client() ->
        snd_seq_free_client(): mutex_lock(&register_mutex)

  snd_seq_release() ->
    snd_seq_free_client(): mutex_lock(&register_mutex) ->
      snd_seq_delete_all_ports() ->
        snd_emux_unuse(): mutex_lock(&emu->register_mutex)

Basically snd_emux_detach_seq() doesn't need a protection of
emu->register_mutex as it's already being unregistered.  So, we can
get rid of this for avoiding the deadlock.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/synth/emux/emux_seq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/synth/emux/emux_seq.c b/sound/synth/emux/emux_seq.c
index 7778b8e19782..188fda0effb0 100644
--- a/sound/synth/emux/emux_seq.c
+++ b/sound/synth/emux/emux_seq.c
@@ -124,12 +124,10 @@ snd_emux_detach_seq(struct snd_emux *emu)
 	if (emu->voices)
 		snd_emux_terminate_all(emu);
 		
-	mutex_lock(&emu->register_mutex);
 	if (emu->client >= 0) {
 		snd_seq_delete_kernel_client(emu->client);
 		emu->client = -1;
 	}
-	mutex_unlock(&emu->register_mutex);
 }
 
 
-- 
2.3.5
