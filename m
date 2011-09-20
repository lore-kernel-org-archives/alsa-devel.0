From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: [PATCH] alsa-lib: if card driver name is empty string,
	use card name instead
Date: Tue, 20 Sep 2011 13:15:44 -0400
Message-ID: <1316538944-31853-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
	by alsa0.perex.cz (Postfix) with ESMTP id C684C10380B
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 07:17:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Scott Jiang <scott.jiang.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

Some drivers don't have a card driver name, but they have a nice card name containing enough info.
So we can use card name to search card config if we found driver name is not valid.

Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
---
 src/confmisc.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/src/confmisc.c b/src/confmisc.c
index 80b0027..3c4b5aa 100644
--- a/src/confmisc.c
+++ b/src/confmisc.c
@@ -666,6 +666,7 @@ int snd_determine_driver(int card, char **driver)
 	snd_ctl_t *ctl = NULL;
 	snd_ctl_card_info_t *info;
 	char *res = NULL;
+	const char *name = NULL;
 	int err;
 
 	assert(card >= 0 && card <= 32);
@@ -680,7 +681,12 @@ int snd_determine_driver(int card, char **driver)
 		SNDERR("snd_ctl_card_info error: %s", snd_strerror(err));
 		goto __error;
 	}
-	res = strdup(snd_ctl_card_info_get_driver(info));
+	name = snd_ctl_card_info_get_driver(info);
+	/* if card driver name is empty string, try to use card name */
+	if (name[0] == '\0')
+		name = snd_ctl_card_info_get_name(info);
+
+	res = strdup(name);
 	if (res == NULL)
 		err = -ENOMEM;
 	else {
-- 
1.7.0.4
