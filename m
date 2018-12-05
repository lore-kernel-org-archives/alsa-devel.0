From: Rob Herring <robh@kernel.org>
Subject: [PATCH] ALSA: Use of_node_name_eq for node name
	comparisons
Date: Wed,  5 Dec 2018 13:50:46 -0600
Message-ID: <20181205195050.4759-30-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 235FE267BA5
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2018 20:51:25 +0100 (CET)
Received: by mail-oi1-f194.google.com with SMTP id u18so18624460oie.10
 for <alsa-devel@alsa-project.org>; Wed, 05 Dec 2018 11:51:25 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Michael Ellerman <mpe@ellerman.id.au>, Takashi Iwai <tiwai@suse.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

A couple of open coded iterating thru the child node names are converted
to use for_each_child_of_node() instead.

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: alsa-devel@alsa-project.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/aoa/fabrics/layout.c       | 2 +-
 sound/aoa/soundbus/i2sbus/core.c | 6 +++---
 sound/ppc/pmac.c                 | 4 ++--
 sound/ppc/tumbler.c              | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index 3a23fd032611..8797d42e2b76 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -776,7 +776,7 @@ static int check_codec(struct aoa_codec *codec,
 	struct codec_connection *cc;
 
 	/* if the codec has a 'codec' node, we require a reference */
-	if (codec->node && (strcmp(codec->node->name, "codec") == 0)) {
+	if (of_node_name_eq(codec->node, "codec")) {
 		snprintf(propname, sizeof(propname),
 			 "platform-%s-codec-ref", codec->name);
 		ref = of_get_property(ldev->sound, propname, NULL);
diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index bd7c5029fc59..c3f57a3fb1a5 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -154,7 +154,7 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 			  struct device_node *np)
 {
 	struct i2sbus_dev *dev;
-	struct device_node *child = NULL, *sound = NULL;
+	struct device_node *child, *sound = NULL;
 	struct resource *r;
 	int i, layout = 0, rlen, ok = force;
 	char node_name[6];
@@ -177,8 +177,8 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 		return 0;
 
 	i = 0;
-	while ((child = of_get_next_child(np, child))) {
-		if (strcmp(child->name, "sound") == 0) {
+	for_each_child_of_node(np, child) {
+		if (of_node_name_eq(child, "sound")) {
 			i++;
 			sound = child;
 		}
diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index 48dd44f8e914..d692e4070167 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -908,7 +908,7 @@ static void detect_byte_swap(struct snd_pmac *chip)
 
 	/* if seems that Keylargo can't byte-swap  */
 	for (mio = chip->node->parent; mio; mio = mio->parent) {
-		if (strcmp(mio->name, "mac-io") == 0) {
+		if (of_node_name_eq(mio, "mac-io")) {
 			if (of_device_is_compatible(mio, "Keylargo"))
 				chip->can_byte_swap = 0;
 			break;
@@ -1313,7 +1313,7 @@ int snd_pmac_new(struct snd_card *card, struct snd_pmac **chip_return)
 	} else if (chip->is_pbook_G3) {
 		struct device_node* mio;
 		for (mio = chip->node->parent; mio; mio = mio->parent) {
-			if (strcmp(mio->name, "mac-io") == 0) {
+			if (of_node_name_eq(mio, "mac-io")) {
 				struct resource r;
 				if (of_address_to_resource(mio, 0, &r) == 0)
 					chip->macio_base =
diff --git a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
index 0779a2912237..6d7ffffcce95 100644
--- a/sound/ppc/tumbler.c
+++ b/sound/ppc/tumbler.c
@@ -1365,8 +1365,8 @@ int snd_pmac_tumbler_init(struct snd_pmac *chip)
 	mix->anded_reset = 0;
 	mix->reset_on_sleep = 1;
 
-	for (np = chip->node->child; np; np = np->sibling) {
-		if (!strcmp(np->name, "sound")) {
+	for_each_child_of_node(chip->node, np) {
+		if (of_node_name_eq(np, "sound")) {
 			if (of_get_property(np, "has-anded-reset", NULL))
 				mix->anded_reset = 1;
 			if (of_get_property(np, "layout-id", NULL))
-- 
2.19.1
