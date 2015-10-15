From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: oss: underflow in snd_mixer_oss_proc_write()
Date: Thu, 15 Oct 2015 10:01:42 +0300
Message-ID: <20151015070141.GA6422@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@intel.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We cap the upper bound of "idx" but not the negative side.  Let's make
it unsigned to fix this.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index a99f720..7a8c79d 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -1177,7 +1177,8 @@ static void snd_mixer_oss_proc_write(struct snd_info_entry *entry,
 	struct snd_mixer_oss *mixer = entry->private_data;
 	char line[128], str[32], idxstr[16];
 	const char *cptr;
-	int ch, idx;
+	unsigned int idx;
+	int ch;
 	struct snd_mixer_oss_assign_table *tbl;
 	struct slot *slot;
 
