From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 13/16] pcmcia: use dynamic debug infrastructure,
	deprecate CS_CHECK (sound)
Date: Sat, 24 Oct 2009 21:43:03 +0200
Message-ID: <1256413386-20501-13-git-send-email-linux@dominikbrodowski.net>
References: <20091024194219.GA19546@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091024194219.GA19546@comet.dominikbrodowski.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia/>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: linux-pcmcia@lists.infradead.org
Cc: alsa-devel@alsa-project.org, Dominik Brodowski <linux@dominikbrodowski.net>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

Convert PCMCIA drivers to use the dynamic debug infrastructure, instead of
requiring manual settings of PCMCIA_DEBUG.

Also, remove all usages of the CS_CHECK macro and replace them with proper
Linux style calling and return value checking. The extra error reporting may
be dropped, as the PCMCIA core already complains about any (non-driver-author)
errors.

CC: Jaroslav Kysela <perex@perex.cz>
CC: alsa-devel@alsa-project.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 sound/pcmcia/pdaudiocf/pdaudiocf.c |   21 ++++++++++++---------
 sound/pcmcia/vx/vxpocket.c         |   21 ++++++++++++---------
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf.c b/sound/pcmcia/pdaudiocf/pdaudiocf.c
index 7dea74b..64b8599 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf.c
@@ -217,20 +217,25 @@ static void snd_pdacf_detach(struct pcmcia_device *link)
  * configuration callback
  */
 
-#define CS_CHECK(fn, ret) \
-do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
-
 static int pdacf_config(struct pcmcia_device *link)
 {
 	struct snd_pdacf *pdacf = link->priv;
-	int last_fn, last_ret;
+	int ret;
 
 	snd_printdd(KERN_DEBUG "pdacf_config called\n");
 	link->conf.ConfigIndex = 0x5;
 
-	CS_CHECK(RequestIO, pcmcia_request_io(link, &link->io));
-	CS_CHECK(RequestIRQ, pcmcia_request_irq(link, &link->irq));
-	CS_CHECK(RequestConfiguration, pcmcia_request_configuration(link, &link->conf));
+	ret = pcmcia_request_io(link, &link->io);
+	if (ret)
+		goto failed;
+
+	ret = pcmcia_request_irq(link, &link->irq);
+	if (ret)
+		goto failed;
+
+	ret = pcmcia_request_configuration(link, &link->conf);
+	if (ret)
+		goto failed;
 
 	if (snd_pdacf_assign_resources(pdacf, link->io.BasePort1, link->irq.AssignedIRQ) < 0)
 		goto failed;
@@ -238,8 +243,6 @@ static int pdacf_config(struct pcmcia_device *link)
 	link->dev_node = &pdacf->node;
 	return 0;
 
-cs_failed:
-	cs_error(link, last_fn, last_ret);
 failed:
 	pcmcia_disable_device(link);
 	return -ENODEV;
diff --git a/sound/pcmcia/vx/vxpocket.c b/sound/pcmcia/vx/vxpocket.c
index 7445cc8..1492744 100644
--- a/sound/pcmcia/vx/vxpocket.c
+++ b/sound/pcmcia/vx/vxpocket.c
@@ -213,14 +213,11 @@ static int snd_vxpocket_assign_resources(struct vx_core *chip, int port, int irq
  * configuration callback
  */
 
-#define CS_CHECK(fn, ret) \
-do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
-
 static int vxpocket_config(struct pcmcia_device *link)
 {
 	struct vx_core *chip = link->priv;
 	struct snd_vxpocket *vxp = (struct snd_vxpocket *)chip;
-	int last_fn, last_ret;
+	int ret;
 
 	snd_printdd(KERN_DEBUG "vxpocket_config called\n");
 
@@ -235,9 +232,17 @@ static int vxpocket_config(struct pcmcia_device *link)
 		strcpy(chip->card->driver, vxp440_hw.name);
 	}
 
-	CS_CHECK(RequestIO, pcmcia_request_io(link, &link->io));
-	CS_CHECK(RequestIRQ, pcmcia_request_irq(link, &link->irq));
-	CS_CHECK(RequestConfiguration, pcmcia_request_configuration(link, &link->conf));
+	ret = pcmcia_request_io(link, &link->io);
+	if (ret)
+		goto failed;
+
+	ret = pcmcia_request_irq(link, &link->irq);
+	if (ret)
+		goto failed;
+
+	ret = pcmcia_request_configuration(link, &link->conf);
+	if (ret)
+		goto failed;
 
 	chip->dev = &handle_to_dev(link);
 	snd_card_set_dev(chip->card, chip->dev);
@@ -248,8 +253,6 @@ static int vxpocket_config(struct pcmcia_device *link)
 	link->dev_node = &vxp->node;
 	return 0;
 
-cs_failed:
-	cs_error(link, last_fn, last_ret);
 failed:
 	pcmcia_disable_device(link);
 	return -ENODEV;
-- 
1.6.0.4
