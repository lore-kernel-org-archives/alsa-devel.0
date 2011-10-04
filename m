From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: oss-mixer - use strlcpy() instead
	strcpy()
Date: Tue, 4 Oct 2011 09:29:39 +0300
Message-ID: <20111004062939.GA29901@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C7E624521
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 08:29:55 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

This is mostly a static checker fix more than anything else.  We're
copying from a 64 char buffer into a 44 char buffer.

The 64 character buffer is str[] in snd_mixer_oss_build_test_all().
The call tree is:
	snd_mixer_oss_build_test_all()
	-> snd_mixer_oss_build_test()
	   -> snd_mixer_oss_build_test().

We never actually do fill str[] buffer all the way to 64 characters.
The longest string is:
	sprintf(str, "%s Playback Switch", ptr->name);
ptr->name is a 32 character buffer so 32 plus 16 characters for
" Playback Switch" still puts us over the 44 limit from "id.name".

Most likely ptr->name never gets filled to the limit, but we can't
really change the size of that buffer so lets just use strlcpy() here
and be safe.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index 27ac611..18297f7 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -500,7 +500,7 @@ static struct snd_kcontrol *snd_mixer_oss_test_id(struct snd_mixer_oss *mixer, c
 	
 	memset(&id, 0, sizeof(id));
 	id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-	strcpy(id.name, name);
+	strlcpy(id.name, name, sizeof(id.name));
 	id.index = index;
 	return snd_ctl_find_id(card, &id);
 }
