From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib] Allow specifying the max number of
	cards
Date: Fri, 24 May 2013 17:23:33 +0200
Message-ID: <1369409013-7745-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CA20F2651A9
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2013 17:23:13 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 535C9A67C5
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2013 17:23:13 +0200 (CEST)
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

Add --with-max-cards option to specify the max number of cards in
configure script, when the support for more than 32 cards is
required.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 configure.in             | 14 ++++++++++++++
 src/confmisc.c           |  2 +-
 src/control/cards.c      |  6 +++---
 src/control/control_hw.c |  2 +-
 src/hwdep/hwdep_hw.c     |  2 +-
 5 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/configure.in b/configure.in
index 35b8e84..3d394fc 100644
--- a/configure.in
+++ b/configure.in
@@ -632,6 +632,20 @@ for t in $CTL_PLUGIN_LIST; do
   fi
 done
 
+dnl Max number of cards
+AC_MSG_CHECKING(for max number of cards)
+AC_ARG_WITH(max-cards,
+  AS_HELP_STRING([--with-max-cards], [Specify the max number of cards (default = 32)]),
+  [ max_cards="$withval" ], [ max_cards="32" ])
+AC_MSG_RESULT([$max_cards])
+
+if test "$max_cards" -lt 1; then
+   AC_ERROR([Invalid max cards $max_cards])
+elif test "$max_cards" -gt 256; then
+   AC_ERROR([Invalid max cards $max_cards])
+fi
+AC_DEFINE_UNQUOTED(SND_MAX_CARDS, $max_cards, [Max number of cards])
+
 dnl Make a symlink for inclusion of alsa/xxx.h
 if test ! -L "$srcdir"/include/alsa ; then
   echo "Making a symlink include/alsa"
diff --git a/src/confmisc.c b/src/confmisc.c
index 80b0027..af686be 100644
--- a/src/confmisc.c
+++ b/src/confmisc.c
@@ -668,7 +668,7 @@ int snd_determine_driver(int card, char **driver)
 	char *res = NULL;
 	int err;
 
-	assert(card >= 0 && card <= 32);
+	assert(card >= 0 && card <= SND_MAX_CARDS);
 	err = open_ctl(card, &ctl);
 	if (err < 0) {
 		SNDERR("could not open control for card %i", card);
diff --git a/src/control/cards.c b/src/control/cards.c
index b528e33..5d7376c 100644
--- a/src/control/cards.c
+++ b/src/control/cards.c
@@ -103,7 +103,7 @@ int snd_card_next(int *rcard)
 		return -EINVAL;
 	card = *rcard;
 	card = card < 0 ? 0 : card + 1;
-	for (; card < 32; card++) {
+	for (; card < SND_MAX_CARDS; card++) {
 		if (snd_card_load(card)) {
 			*rcard = card;
 			return 0;
@@ -134,7 +134,7 @@ int snd_card_get_index(const char *string)
 	    (isdigit(*string) && isdigit(*(string + 1)) && *(string + 2) == 0)) {
 		if (sscanf(string, "%i", &card) != 1)
 			return -EINVAL;
-		if (card < 0 || card > 31)
+		if (card < 0 || card >= SND_MAX_CARDS)
 			return -EINVAL;
 		err = snd_card_load1(card);
 		if (err >= 0)
@@ -143,7 +143,7 @@ int snd_card_get_index(const char *string)
 	}
 	if (string[0] == '/')	/* device name */
 		return snd_card_load2(string);
-	for (card = 0; card < 32; card++) {
+	for (card = 0; card < SND_MAX_CARDS; card++) {
 #ifdef SUPPORT_ALOAD
 		if (! snd_card_load(card))
 			continue;
diff --git a/src/control/control_hw.c b/src/control/control_hw.c
index 90c4ba7..148097f 100644
--- a/src/control/control_hw.c
+++ b/src/control/control_hw.c
@@ -382,7 +382,7 @@ int snd_ctl_hw_open(snd_ctl_t **handle, const char *name, int card, int mode)
 
 	*handle = NULL;	
 
-	if (CHECK_SANITY(card < 0 || card >= 32)) {
+	if (CHECK_SANITY(card < 0 || card >= SND_MAX_CARDS)) {
 		SNDMSG("Invalid card index %d", card);
 		return -EINVAL;
 	}
diff --git a/src/hwdep/hwdep_hw.c b/src/hwdep/hwdep_hw.c
index e4fcdc3..4314e32 100644
--- a/src/hwdep/hwdep_hw.c
+++ b/src/hwdep/hwdep_hw.c
@@ -112,7 +112,7 @@ int snd_hwdep_hw_open(snd_hwdep_t **handle, const char *name, int card, int devi
 
 	*handle = NULL;
 	
-	if (card < 0 || card >= 32)
+	if (card < 0 || card >= SND_MAX_CARDS)
 		return -EINVAL;
 	sprintf(filename, SNDRV_FILE_HWDEP, card, device);
 	fd = snd_open_device(filename, mode);
-- 
1.8.2.3
