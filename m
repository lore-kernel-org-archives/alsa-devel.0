From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 04/29] pcmcia: pass FORCED_PULSE parameter in
	pcmcia_request_configuration()
Date: Wed, 19 May 2010 08:42:40 +0200
Message-ID: <1274251385-6196-4-git-send-email-linux@dominikbrodowski.net>
References: <20100519064149.GA5755@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100519064149.GA5755@comet.dominikbrodowski.net>
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
Cc: alsa-devel@alsa-project.org, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: alsa-devel@alsa-project.org

As it's only used there it makes no sense relying on pcmcia_request_irq().

CC: alsa-devel@alsa-project.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/pcmcia/pcmcia_resource.c             |   11 +++--------
 drivers/staging/comedi/drivers/ni_labpc_cs.c |    5 +++--
 include/pcmcia/cs.h                          |    1 +
 sound/pcmcia/pdaudiocf/pdaudiocf.c           |    6 +++---
 4 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resource.c
index cefc4cd..8dce223 100644
--- a/drivers/pcmcia/pcmcia_resource.c
+++ b/drivers/pcmcia/pcmcia_resource.c
@@ -426,10 +426,6 @@ static int pcmcia_release_irq(struct pcmcia_device *p_dev, irq_req_t *req)
 	if (c->state & CONFIG_LOCKED)
 		goto out;
 
-	if (c->irq.Attributes != req->Attributes) {
-		dev_dbg(&s->dev, "IRQ attributes must match assigned ones\n");
-		goto out;
-	}
 	if (s->pcmcia_irq != req->AssignedIRQ) {
 		dev_dbg(&s->dev, "IRQ must match assigned one\n");
 		goto out;
@@ -553,9 +549,9 @@ int pcmcia_request_configuration(struct pcmcia_device *p_dev,
 			if (req->Present & PRESENT_IOBASE_0)
 				c->Option |= COR_ADDR_DECODE;
 		}
-		if (req->Attributes & CONF_ENABLE_IRQ)
-			if (!(c->irq.Attributes & IRQ_FORCED_PULSE))
-				c->Option |= COR_LEVEL_REQ;
+		if ((req->Attributes & CONF_ENABLE_IRQ) &&
+			!(req->Attributes & CONF_ENABLE_PULSE_IRQ))
+			c->Option |= COR_LEVEL_REQ;
 		pcmcia_write_cis_mem(s, 1, (base + CISREG_COR)>>1, 1, &c->Option);
 		mdelay(40);
 	}
@@ -730,7 +726,6 @@ int pcmcia_request_irq(struct pcmcia_device *p_dev, irq_req_t *req)
 		}
 	}
 
-	c->irq.Attributes = req->Attributes;
 	req->AssignedIRQ = irq;
 
 	p_dev->_irq = 1;
diff --git a/drivers/staging/comedi/drivers/ni_labpc_cs.c b/drivers/staging/comedi/drivers/ni_labpc_cs.c
index 8ad1055..6e4ed0d 100644
--- a/drivers/staging/comedi/drivers/ni_labpc_cs.c
+++ b/drivers/staging/comedi/drivers/ni_labpc_cs.c
@@ -230,7 +230,7 @@ static int labpc_cs_attach(struct pcmcia_device *link)
 	link->priv = local;
 
 	/* Interrupt setup */
-	link->irq.Attributes = IRQ_TYPE_DYNAMIC_SHARING | IRQ_FORCED_PULSE;
+	link->irq.Attributes = IRQ_TYPE_DYNAMIC_SHARING;
 	link->irq.Handler = NULL;
 
 	/*
@@ -307,7 +307,8 @@ static int labpc_pcmcia_config_loop(struct pcmcia_device *p_dev,
 
 	/* Do we need to allocate an interrupt? */
 	if (cfg->irq.IRQInfo1 || dflt->irq.IRQInfo1)
-		p_dev->conf.Attributes |= CONF_ENABLE_IRQ;
+		p_dev->conf.Attributes |=
+			(CONF_ENABLE_IRQ | CONF_ENABLE_PULSE_IRQ);
 
 	/* IO window settings */
 	p_dev->io.NumPorts1 = p_dev->io.NumPorts2 = 0;
diff --git a/include/pcmcia/cs.h b/include/pcmcia/cs.h
index 75fa353..af61571 100644
--- a/include/pcmcia/cs.h
+++ b/include/pcmcia/cs.h
@@ -85,6 +85,7 @@ typedef struct config_req_t {
 #define CONF_ENABLE_IRQ		0x01
 #define CONF_ENABLE_DMA		0x02
 #define CONF_ENABLE_SPKR	0x04
+#define CONF_ENABLE_PULSE_IRQ	0x08
 #define CONF_VALID_CLIENT	0x100
 
 /* IntType field */
diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf.c b/sound/pcmcia/pdaudiocf/pdaudiocf.c
index edaa729..dcf8539 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf.c
@@ -142,12 +142,12 @@ static int snd_pdacf_probe(struct pcmcia_device *link)
 	link->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
 	link->io.NumPorts1 = 16;
 
-	link->irq.Attributes = IRQ_TYPE_EXCLUSIVE | IRQ_FORCED_PULSE;
+	link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
 	/* FIXME: This driver should be updated to allow for dynamic IRQ sharing */
-	/* link->irq.Attributes = IRQ_TYPE_DYNAMIC_SHARING | IRQ_FORCED_PULSE; */
+	/* link->irq.Attributes = IRQ_TYPE_DYNAMIC_SHARING; */
 
 	link->irq.Handler = pdacf_interrupt;
-	link->conf.Attributes = CONF_ENABLE_IRQ;
+	link->conf.Attributes = CONF_ENABLE_IRQ | CONF_ENABLE_PULSE_IRQ;
 	link->conf.IntType = INT_MEMORY_AND_IO;
 	link->conf.ConfigIndex = 1;
 	link->conf.Present = PRESENT_OPTION;
-- 
1.6.3.3
