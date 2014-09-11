From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/6] ALSA: mixart: Use nonatomic PCM ops
Date: Thu, 11 Sep 2014 16:00:22 +0200
Message-ID: <1410444025-22772-4-git-send-email-tiwai@suse.de>
References: <1410444025-22772-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DFDD4265769
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 16:00:32 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2ED65AD3F
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 14:00:30 +0000 (UTC)
In-Reply-To: <1410444025-22772-1-git-send-email-tiwai@suse.de>
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

Like the previous patch for VX boards, miXart device driver can be
also rewritten to use nonatomic PCM ops.  Simply spinlocks are
replaced with mutex, the tasklet code is merged into the threaded irq
handler.  Also, now mgr->msg_mutex is superfluous, so merged to
msg_lock.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/mixart/mixart.c      | 17 ++++-----
 sound/pci/mixart/mixart.h      | 10 ++----
 sound/pci/mixart/mixart_core.c | 79 ++++++++++++++++++------------------------
 sound/pci/mixart/mixart_core.h |  2 +-
 4 files changed, 44 insertions(+), 64 deletions(-)

diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index 75fc342cff2a..1faf47e81570 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -986,6 +986,7 @@ static int snd_mixart_pcm_analog(struct snd_mixart *chip)
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_mixart_capture_ops);
 
 	pcm->info_flags = 0;
+	pcm->nonatomic = true;
 	strcpy(pcm->name, name);
 
 	preallocate_buffers(chip, pcm);
@@ -1018,6 +1019,7 @@ static int snd_mixart_pcm_digital(struct snd_mixart *chip)
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_mixart_capture_ops);
 
 	pcm->info_flags = 0;
+	pcm->nonatomic = true;
 	strcpy(pcm->name, name);
 
 	preallocate_buffers(chip, pcm);
@@ -1303,8 +1305,9 @@ static int snd_mixart_probe(struct pci_dev *pci,
 		}
 	}
 
-	if (request_irq(pci->irq, snd_mixart_interrupt, IRQF_SHARED,
-			KBUILD_MODNAME, mgr)) {
+	if (request_threaded_irq(pci->irq, snd_mixart_interrupt,
+				 snd_mixart_threaded_irq, IRQF_SHARED,
+				 KBUILD_MODNAME, mgr)) {
 		dev_err(&pci->dev, "unable to grab IRQ %d\n", pci->irq);
 		snd_mixart_free(mgr);
 		return -EBUSY;
@@ -1314,24 +1317,18 @@ static int snd_mixart_probe(struct pci_dev *pci,
 	sprintf(mgr->shortname, "Digigram miXart");
 	sprintf(mgr->longname, "%s at 0x%lx & 0x%lx, irq %i", mgr->shortname, mgr->mem[0].phys, mgr->mem[1].phys, mgr->irq);
 
-	/* ISR spinlock  */
-	spin_lock_init(&mgr->lock);
-
 	/* init mailbox  */
 	mgr->msg_fifo_readptr = 0;
 	mgr->msg_fifo_writeptr = 0;
 
-	spin_lock_init(&mgr->msg_lock);
-	mutex_init(&mgr->msg_mutex);
+	mutex_init(&mgr->lock);
+	mutex_init(&mgr->msg_lock);
 	init_waitqueue_head(&mgr->msg_sleep);
 	atomic_set(&mgr->msg_processed, 0);
 
 	/* init setup mutex*/
 	mutex_init(&mgr->setup_mutex);
 
-	/* init message taslket */
-	tasklet_init(&mgr->msg_taskq, snd_mixart_msg_tasklet, (unsigned long) mgr);
-
 	/* card assignment */
 	mgr->num_cards = MIXART_MAX_CARDS; /* 4  FIXME: configurable? */
 	for (i = 0; i < mgr->num_cards; i++) {
diff --git a/sound/pci/mixart/mixart.h b/sound/pci/mixart/mixart.h
index 561634d5c007..0cc17e0ea34a 100644
--- a/sound/pci/mixart/mixart.h
+++ b/sound/pci/mixart/mixart.h
@@ -78,22 +78,18 @@ struct mixart_mgr {
 	char shortname[32];         /* short name of this soundcard */
 	char longname[80];          /* name of this soundcard */
 
-	/* message tasklet */
-	struct tasklet_struct msg_taskq;
-
 	/* one and only blocking message or notification may be pending  */
 	u32 pending_event;
 	wait_queue_head_t msg_sleep;
 
-	/* messages stored for tasklet */
+	/* messages fifo */
 	u32 msg_fifo[MSG_FIFO_SIZE];
 	int msg_fifo_readptr;
 	int msg_fifo_writeptr;
 	atomic_t msg_processed;       /* number of messages to be processed in takslet */
 
-	spinlock_t lock;              /* interrupt spinlock */
-	spinlock_t msg_lock;          /* mailbox spinlock */
-	struct mutex msg_mutex;   /* mutex for blocking_requests */
+	struct mutex lock;              /* interrupt lock */
+	struct mutex msg_lock;		/* mailbox lock */
 
 	struct mutex setup_mutex; /* mutex used in hw_params, open and close */
 
diff --git a/sound/pci/mixart/mixart_core.c b/sound/pci/mixart/mixart_core.c
index 84f67450924e..fe80313674d9 100644
--- a/sound/pci/mixart/mixart_core.c
+++ b/sound/pci/mixart/mixart_core.c
@@ -76,7 +76,6 @@ static int retrieve_msg_frame(struct mixart_mgr *mgr, u32 *msg_frame)
 static int get_msg(struct mixart_mgr *mgr, struct mixart_msg *resp,
 		   u32 msg_frame_address )
 {
-	unsigned long flags;
 	u32  headptr;
 	u32  size;
 	int  err;
@@ -84,7 +83,7 @@ static int get_msg(struct mixart_mgr *mgr, struct mixart_msg *resp,
 	unsigned int i;
 #endif
 
-	spin_lock_irqsave(&mgr->msg_lock, flags);
+	mutex_lock(&mgr->msg_lock);
 	err = 0;
 
 	/* copy message descriptor from miXart to driver */
@@ -133,7 +132,7 @@ static int get_msg(struct mixart_mgr *mgr, struct mixart_msg *resp,
 	writel_be(headptr, MIXART_MEM(mgr, MSG_OUTBOUND_FREE_HEAD));
 
  _clean_exit:
-	spin_unlock_irqrestore(&mgr->msg_lock, flags);
+	mutex_unlock(&mgr->msg_lock);
 
 	return err;
 }
@@ -243,28 +242,24 @@ int snd_mixart_send_msg(struct mixart_mgr *mgr, struct mixart_msg *request, int
 	wait_queue_t wait;
 	long timeout;
 
-	mutex_lock(&mgr->msg_mutex);
-
 	init_waitqueue_entry(&wait, current);
 
-	spin_lock_irq(&mgr->msg_lock);
+	mutex_lock(&mgr->msg_lock);
 	/* send the message */
 	err = send_msg(mgr, request, max_resp_size, 1, &msg_frame);  /* send and mark the answer pending */
 	if (err) {
-		spin_unlock_irq(&mgr->msg_lock);
-		mutex_unlock(&mgr->msg_mutex);
+		mutex_unlock(&mgr->msg_lock);
 		return err;
 	}
 
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	add_wait_queue(&mgr->msg_sleep, &wait);
-	spin_unlock_irq(&mgr->msg_lock);
+	mutex_unlock(&mgr->msg_lock);
 	timeout = schedule_timeout(MSG_TIMEOUT_JIFFIES);
 	remove_wait_queue(&mgr->msg_sleep, &wait);
 
 	if (! timeout) {
 		/* error - no ack */
-		mutex_unlock(&mgr->msg_mutex);
 		dev_err(&mgr->pci->dev,
 			"error: no response on msg %x\n", msg_frame);
 		return -EIO;
@@ -281,7 +276,6 @@ int snd_mixart_send_msg(struct mixart_mgr *mgr, struct mixart_msg *request, int
 	if( request->message_id != resp.message_id )
 		dev_err(&mgr->pci->dev, "RESPONSE ERROR!\n");
 
-	mutex_unlock(&mgr->msg_mutex);
 	return err;
 }
 
@@ -300,34 +294,29 @@ int snd_mixart_send_msg_wait_notif(struct mixart_mgr *mgr,
 	if (snd_BUG_ON(notif_event & MSG_CANCEL_NOTIFY_MASK))
 		return -EINVAL;
 
-	mutex_lock(&mgr->msg_mutex);
-
 	init_waitqueue_entry(&wait, current);
 
-	spin_lock_irq(&mgr->msg_lock);
+	mutex_lock(&mgr->msg_lock);
 	/* send the message */
 	err = send_msg(mgr, request, MSG_DEFAULT_SIZE, 1, &notif_event);  /* send and mark the notification event pending */
 	if(err) {
-		spin_unlock_irq(&mgr->msg_lock);
-		mutex_unlock(&mgr->msg_mutex);
+		mutex_unlock(&mgr->msg_lock);
 		return err;
 	}
 
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	add_wait_queue(&mgr->msg_sleep, &wait);
-	spin_unlock_irq(&mgr->msg_lock);
+	mutex_unlock(&mgr->msg_lock);
 	timeout = schedule_timeout(MSG_TIMEOUT_JIFFIES);
 	remove_wait_queue(&mgr->msg_sleep, &wait);
 
 	if (! timeout) {
 		/* error - no ack */
-		mutex_unlock(&mgr->msg_mutex);
 		dev_err(&mgr->pci->dev,
 			"error: notification %x not received\n", notif_event);
 		return -EIO;
 	}
 
-	mutex_unlock(&mgr->msg_mutex);
 	return 0;
 }
 
@@ -335,13 +324,12 @@ int snd_mixart_send_msg_wait_notif(struct mixart_mgr *mgr,
 int snd_mixart_send_msg_nonblock(struct mixart_mgr *mgr, struct mixart_msg *request)
 {
 	u32 message_frame;
-	unsigned long flags;
 	int err;
 
 	/* just send the message (do not mark it as a pending one) */
-	spin_lock_irqsave(&mgr->msg_lock, flags);
+	mutex_lock(&mgr->msg_lock);
 	err = send_msg(mgr, request, MSG_DEFAULT_SIZE, 0, &message_frame);
-	spin_unlock_irqrestore(&mgr->msg_lock, flags);
+	mutex_unlock(&mgr->msg_lock);
 
 	/* the answer will be handled by snd_struct mixart_msgasklet()  */
 	atomic_inc(&mgr->msg_processed);
@@ -350,19 +338,16 @@ int snd_mixart_send_msg_nonblock(struct mixart_mgr *mgr, struct mixart_msg *requ
 }
 
 
-/* common buffer of tasklet and interrupt to send/receive messages */
+/* common buffer of interrupt to send/receive messages */
 static u32 mixart_msg_data[MSG_DEFAULT_SIZE / 4];
 
 
-void snd_mixart_msg_tasklet(unsigned long arg)
+static void snd_mixart_process_msg(struct mixart_mgr *mgr)
 {
-	struct mixart_mgr *mgr = ( struct mixart_mgr*)(arg);
 	struct mixart_msg resp;
 	u32 msg, addr, type;
 	int err;
 
-	spin_lock(&mgr->lock);
-
 	while (mgr->msg_fifo_readptr != mgr->msg_fifo_writeptr) {
 		msg = mgr->msg_fifo[mgr->msg_fifo_readptr];
 		mgr->msg_fifo_readptr++;
@@ -381,7 +366,7 @@ void snd_mixart_msg_tasklet(unsigned long arg)
 			err = get_msg(mgr, &resp, addr);
 			if( err < 0 ) {
 				dev_err(&mgr->pci->dev,
-					"tasklet: error(%d) reading mf %x\n",
+					"error(%d) reading mf %x\n",
 					err, msg);
 				break;
 			}
@@ -393,12 +378,12 @@ void snd_mixart_msg_tasklet(unsigned long arg)
 			case MSG_STREAM_STOP_OUTPUT_STAGE_PACKET:
 				if(mixart_msg_data[0])
 					dev_err(&mgr->pci->dev,
-						"tasklet : error MSG_STREAM_ST***_***PUT_STAGE_PACKET status=%x\n",
+						"error MSG_STREAM_ST***_***PUT_STAGE_PACKET status=%x\n",
 						mixart_msg_data[0]);
 				break;
 			default:
 				dev_dbg(&mgr->pci->dev,
-					"tasklet received mf(%x) : msg_id(%x) uid(%x, %x) size(%zd)\n",
+					"received mf(%x) : msg_id(%x) uid(%x, %x) size(%zd)\n",
 					   msg, resp.message_id, resp.uid.object_id, resp.uid.desc, resp.size);
 				break;
 			}
@@ -409,7 +394,7 @@ void snd_mixart_msg_tasklet(unsigned long arg)
 			/* get_msg() necessary */
 		default:
 			dev_err(&mgr->pci->dev,
-				"tasklet doesn't know what to do with message %x\n",
+				"doesn't know what to do with message %x\n",
 				msg);
 		} /* switch type */
 
@@ -417,26 +402,17 @@ void snd_mixart_msg_tasklet(unsigned long arg)
 		atomic_dec(&mgr->msg_processed);
 
 	} /* while there is a msg in fifo */
-
-	spin_unlock(&mgr->lock);
 }
 
 
 irqreturn_t snd_mixart_interrupt(int irq, void *dev_id)
 {
 	struct mixart_mgr *mgr = dev_id;
-	int err;
-	struct mixart_msg resp;
-
-	u32 msg;
 	u32 it_reg;
 
-	spin_lock(&mgr->lock);
-
 	it_reg = readl_le(MIXART_REG(mgr, MIXART_PCI_OMISR_OFFSET));
 	if( !(it_reg & MIXART_OIDI) ) {
 		/* this device did not cause the interrupt */
-		spin_unlock(&mgr->lock);
 		return IRQ_NONE;
 	}
 
@@ -450,6 +426,17 @@ irqreturn_t snd_mixart_interrupt(int irq, void *dev_id)
 	/* clear interrupt */
 	writel_le( MIXART_OIDI, MIXART_REG(mgr, MIXART_PCI_OMISR_OFFSET) );
 
+	return IRQ_WAKE_THREAD;
+}
+
+irqreturn_t snd_mixart_threaded_irq(int irq, void *dev_id)
+{
+	struct mixart_mgr *mgr = dev_id;
+	int err;
+	struct mixart_msg resp;
+	u32 msg;
+
+	mutex_lock(&mgr->lock);
 	/* process interrupt */
 	while (retrieve_msg_frame(mgr, &msg)) {
 
@@ -518,9 +505,9 @@ irqreturn_t snd_mixart_interrupt(int irq, void *dev_id)
 						stream->buf_period_frag = (u32)( sample_count - stream->abs_period_elapsed );
 
 						if(elapsed) {
-							spin_unlock(&mgr->lock);
+							mutex_unlock(&mgr->lock);
 							snd_pcm_period_elapsed(stream->substream);
-							spin_lock(&mgr->lock);
+							mutex_lock(&mgr->lock);
 						}
 					}
 				}
@@ -556,7 +543,7 @@ irqreturn_t snd_mixart_interrupt(int irq, void *dev_id)
 			/* no break, continue ! */
 		case MSG_TYPE_ANSWER:
 			/* answer or notification to a message we are waiting for*/
-			spin_lock(&mgr->msg_lock);
+			mutex_lock(&mgr->msg_lock);
 			if( (msg & ~MSG_TYPE_MASK) == mgr->pending_event ) {
 				wake_up(&mgr->msg_sleep);
 				mgr->pending_event = 0;
@@ -566,9 +553,9 @@ irqreturn_t snd_mixart_interrupt(int irq, void *dev_id)
 				mgr->msg_fifo[mgr->msg_fifo_writeptr] = msg;
 				mgr->msg_fifo_writeptr++;
 				mgr->msg_fifo_writeptr %= MSG_FIFO_SIZE;
-				tasklet_schedule(&mgr->msg_taskq);
+				snd_mixart_process_msg(mgr);
 			}
-			spin_unlock(&mgr->msg_lock);
+			mutex_unlock(&mgr->msg_lock);
 			break;
 		case MSG_TYPE_REQUEST:
 		default:
@@ -582,7 +569,7 @@ irqreturn_t snd_mixart_interrupt(int irq, void *dev_id)
 	/* allow interrupt again */
 	writel_le( MIXART_ALLOW_OUTBOUND_DOORBELL, MIXART_REG( mgr, MIXART_PCI_OMIMR_OFFSET));
 
-	spin_unlock(&mgr->lock);
+	mutex_unlock(&mgr->lock);
 
 	return IRQ_HANDLED;
 }
diff --git a/sound/pci/mixart/mixart_core.h b/sound/pci/mixart/mixart_core.h
index c919b734756f..d1722e575409 100644
--- a/sound/pci/mixart/mixart_core.h
+++ b/sound/pci/mixart/mixart_core.h
@@ -564,7 +564,7 @@ int  snd_mixart_send_msg_wait_notif(struct mixart_mgr *mgr, struct mixart_msg *r
 int  snd_mixart_send_msg_nonblock(struct mixart_mgr *mgr, struct mixart_msg *request);
 
 irqreturn_t snd_mixart_interrupt(int irq, void *dev_id);
-void snd_mixart_msg_tasklet(unsigned long arg);
+irqreturn_t snd_mixart_threaded_irq(int irq, void *dev_id);
 
 void snd_mixart_reset_board(struct mixart_mgr *mgr);
 
-- 
2.1.0
