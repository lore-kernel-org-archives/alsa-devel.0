From: pavel.hofman@ivitera.com
Subject: [PATCH - ice1724 2/3] ALSA: ice1724 - Allow card info
	based on model only
Date: Tue, 10 Jan 2012 20:28:47 +0100
Message-ID: <1326223728-3085-2-git-send-email-pavel.hofman@ivitera.com>
References: <1326223728-3085-1-git-send-email-pavel.hofman@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1326223728-3085-1-git-send-email-pavel.hofman@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Pavel Hofman <pavel.hofman@ivitera.com>

When two different cards share the same PCI vendor/subvendor
identification, allow card info based on model only.
Do not require subvendor ID.

Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>

diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index e797823..352f3ff 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -2282,7 +2282,7 @@ static int __devinit snd_vt1724_read_eeprom(struct snd_ice1712 *ice,
 		}
 	}
 	for (tbl = card_tables; *tbl; tbl++) {
-		for (c = *tbl; c->subvendor; c++) {
+		for (c = *tbl; c->name; c++) {
 			if (modelname && c->model &&
 			    !strcmp(modelname, c->model)) {
 				printk(KERN_INFO "ice1724: Using board model %s\n",
@@ -2591,8 +2591,10 @@ static int __devinit snd_vt1724_probe(struct pci_dev *pci,
 	ice->ext_clock_count = 0;
 
 	for (tbl = card_tables; *tbl; tbl++) {
-		for (c = *tbl; c->subvendor; c++) {
-			if (c->subvendor == ice->eeprom.subvendor) {
+		for (c = *tbl; c->name; c++) {
+			if ((model[dev] && c->model &&
+			     !strcmp(model[dev], c->model)) ||
+			    (c->subvendor == ice->eeprom.subvendor)) {
 				strcpy(card->shortname, c->name);
 				if (c->driver) /* specific driver? */
 					strcpy(card->driver, c->driver);
-- 
1.7.0.4
