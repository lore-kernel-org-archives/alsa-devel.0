From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: dmix: Disable var_periodsize as
	default
Date: Mon, 10 Apr 2017 11:49:35 +0200
Message-ID: <20170410094935.18898-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D80942666E1
 for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2017 11:49:37 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2DFDAAAB2
 for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2017 09:49:37 +0000 (UTC)
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

The recently added variable period-size feature for dmix & co seems
causing a regression on some old applications; e.g. Audacious aborts
with an error:

  ALSA error: snd_pcm_hw_params_set_buffer_time_near failed: Invalid argument.

As a quick fix, disable the feature as default.  One can still enable
it via asoundrc.

Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=1033179
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 8a75c421dd7b..89468d3537d0 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -1875,7 +1875,7 @@ int snd_pcm_direct_parse_open_conf(snd_config_t *root, snd_config_t *conf,
 	rec->ipc_gid = -1;
 	rec->slowptr = 1;
 	rec->max_periods = 0;
-	rec->var_periodsize = 1;
+	rec->var_periodsize = 0;
 	rec->direct_memory_access = 1;
 
 	/* read defaults */
-- 
2.11.1
