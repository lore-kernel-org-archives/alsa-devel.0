From: Martin Koegler <martin.koegler@chello.at>
Subject: Re: [PATCH] Provide card number / PID via sequencer
 client	info
Date: Mon, 15 Feb 2016 22:44:54 +0100
Message-ID: <20160215214454.GA11052@mail.zuhause>
References: <1455370937-501-1-git-send-email-martin@mail.zuhause>
 <1455370937-501-3-git-send-email-martin@mail.zuhause>
 <s5htwlab70o.wl-tiwai@suse.de>
 <20160215183243.GA26482@mail.zuhause>
 <s5hziv194gz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe03-1.mx.upcmail.net
 (vie01a-dmta-pe03-1.mx.upcmail.net [62.179.121.160])
 by alsa0.perex.cz (Postfix) with ESMTP id 61E07260695
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 22:44:56 +0100 (CET)
Received: from [172.31.216.43] (helo=vie01a-pemc-psmtp-pe01)
 by vie01a-dmta-pe03.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <martin.koegler@chello.at>) id 1aVQwy-0002iZ-1d
 for alsa-devel@alsa-project.org; Mon, 15 Feb 2016 22:44:56 +0100
Content-Disposition: inline
In-Reply-To: <s5hziv194gz.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Martin Koegler <martin.koegler@chello.at>
List-Id: alsa-devel@alsa-project.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 15, 2016 at 08:08:12PM +0100, Takashi Iwai wrote:
> On Mon, 15 Feb 2016 19:32:43 +0100,
> Martin Koegler wrote:
> > 
> > On Mon, Feb 15, 2016 at 11:30:15AM +0100, Takashi Iwai wrote:
> > > The idea looks good.  One remaining question is whether only providing
> > > the card number or pid is sufficient for all cases.
> > 
> > I only care about the kernel client. 
> 
> Well, the question is whether only card number is enough.  What if
> cards provide multiple rawmidi devices?

Aren't they currently ports?
seq_midi.c creates just one sequencer device per card number.

Regards,
Martin

--nFreZHaLTZJo0R7j
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Show-sequencer-sound-card-numer-PID-via-aconnect.patch"

>From 797b71aeb533d1111b8aada6b7e0ad8e2b133325 Mon Sep 17 00:00:00 2001
From: Martin Koegler <martin.koegler@chello.at>
Date: Fri, 12 Feb 2016 19:53:32 +0100
Subject: [PATCH] Show sequencer sound card numer/PID via aconnect

rawmidi devices expose the card number via IOCTLs, which allows to
find the corresponding device in sysfs.

The sequencer provides no identifing data. Chromium works around this
issue by scanning rawmidi as well as sequencer devices and matching
them by using assumtions, how the kernel register sequencer devices.

This patch adds support for displaying the sound card number/PID to
aconnect.

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 seq/aconnect/aconnect.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/seq/aconnect/aconnect.c b/seq/aconnect/aconnect.c
index 8d6cebb..d299f5c 100644
--- a/seq/aconnect/aconnect.c
+++ b/seq/aconnect/aconnect.c
@@ -166,11 +166,22 @@ static void print_port(snd_seq_t *seq, snd_seq_client_info_t *cinfo,
 		       snd_seq_port_info_t *pinfo, int count)
 {
 	if (! count) {
-		printf(_("client %d: '%s' [type=%s]\n"),
+		int card, pid;
+
+		printf(_("client %d: '%s' [type=%s"),
 		       snd_seq_client_info_get_client(cinfo),
 		       snd_seq_client_info_get_name(cinfo),
 		       (snd_seq_client_info_get_type(cinfo) == SND_SEQ_USER_CLIENT ?
 			_("user") : _("kernel")));
+
+		card = snd_seq_client_info_get_card(cinfo);
+		if (card != -1)
+			printf(",card=%d", card);
+
+		pid = snd_seq_client_info_get_pid(cinfo);
+		if (pid != -1)
+			printf(",pid=%d", pid);
+		printf("]\n");
 	}
 	printf("  %3d '%-16s'\n",
 	       snd_seq_port_info_get_port(pinfo),
-- 
2.1.4


--nFreZHaLTZJo0R7j
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Provide-sequencer-sound-card-number-PID-via-alsa-lib.patch"

>From aabf924538588a65cbbdb2d702712338279fd9c1 Mon Sep 17 00:00:00 2001
From: Martin Koegler <martin.koegler@chello.at>
Date: Fri, 12 Feb 2016 19:54:15 +0100
Subject: [PATCH] Provide sequencer sound card number / PID via alsa-lib

rawmidi devices expose the card number via IOCTLs, which allows to
find the corresponding device in sysfs.

The sequencer provides no identifing data. Chromium works around this
issue by scanning rawmidi as well as sequencer devices and matching
them by using assumtions, how the kernel register sequencer devices.

This changes adds support for exposing the card number for kernel clients
as well as the PID for user client.

It supports kernels with and without the required support.

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 include/seq.h              |  2 ++
 include/sound/asequencer.h |  6 ++++--
 src/seq/seq.c              | 26 ++++++++++++++++++++++++++
 src/seq/seq_hw.c           | 12 +++++++++++-
 4 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/include/seq.h b/include/seq.h
index 9576822..d05940e 100644
--- a/include/seq.h
+++ b/include/seq.h
@@ -143,6 +143,8 @@ snd_seq_client_type_t snd_seq_client_info_get_type(const snd_seq_client_info_t *
 const char *snd_seq_client_info_get_name(snd_seq_client_info_t *info);
 int snd_seq_client_info_get_broadcast_filter(const snd_seq_client_info_t *info);
 int snd_seq_client_info_get_error_bounce(const snd_seq_client_info_t *info);
+int snd_seq_client_info_get_card(const snd_seq_client_info_t *info);
+int snd_seq_client_info_get_pid(const snd_seq_client_info_t *info);
 const unsigned char *snd_seq_client_info_get_event_filter(const snd_seq_client_info_t *info);
 int snd_seq_client_info_get_num_ports(const snd_seq_client_info_t *info);
 int snd_seq_client_info_get_event_lost(const snd_seq_client_info_t *info);
diff --git a/include/sound/asequencer.h b/include/sound/asequencer.h
index 09c8a00..3ac70fd 100644
--- a/include/sound/asequencer.h
+++ b/include/sound/asequencer.h
@@ -24,7 +24,7 @@
 
 
 /** version of the sequencer */
-#define SNDRV_SEQ_VERSION SNDRV_PROTOCOL_VERSION (1, 0, 1)
+#define SNDRV_SEQ_VERSION SNDRV_PROTOCOL_VERSION (1, 0, 2)
 
 /**
  * definition of sequencer event types
@@ -356,7 +356,9 @@ struct snd_seq_client_info {
 	unsigned char event_filter[32];	/* event filter bitmap */
 	int num_ports;			/* RO: number of ports */
 	int event_lost;			/* number of lost events */
-	char reserved[64];		/* for future use */
+	int card;			/* RO: card number[kernel] */
+	int pid;			/* RO: pid[user] */
+	char reserved[56];		/* for future use */
 };
 
 
diff --git a/src/seq/seq.c b/src/seq/seq.c
index 620ca3f..4405e68 100644
--- a/src/seq/seq.c
+++ b/src/seq/seq.c
@@ -1522,6 +1522,32 @@ int snd_seq_client_info_get_error_bounce(const snd_seq_client_info_t *info)
 }
 
 /**
+ * \brief Get the sound card number.
+ * \param info client_info container
+ * \return card number or -1 if value is not available.
+ *
+ * Only available for SND_SEQ_KERNEL_CLIENT clients.
+ */
+int snd_seq_client_info_get_card(const snd_seq_client_info_t *info)
+{
+	assert(info);
+	return info->card;
+}
+
+/**
+ * \brief Get the owning PID.
+ * \param info client_info container
+ * \return pid or -1 if value is not available.
+ *
+ * Only available for SND_SEQ_USER_CLIENT clients.
+ */
+int snd_seq_client_info_get_pid(const snd_seq_client_info_t *info)
+{
+	assert(info);
+	return info->pid;
+}
+
+/**
  * \brief (DEPRECATED) Get the event filter bitmap of a client_info container
  * \param info client_info container
  * \return NULL if no event filter, or pointer to event filter bitmap
diff --git a/src/seq/seq_hw.c b/src/seq/seq_hw.c
index d033367..24350b6 100644
--- a/src/seq/seq_hw.c
+++ b/src/seq/seq_hw.c
@@ -32,10 +32,11 @@ const char *_snd_module_seq_hw = "";
 #ifndef DOC_HIDDEN
 #define SNDRV_FILE_SEQ		ALSA_DEVICE_DIRECTORY "seq"
 #define SNDRV_FILE_ALOADSEQ	ALOAD_DEVICE_DIRECTORY "aloadSEQ"
-#define SNDRV_SEQ_VERSION_MAX	SNDRV_PROTOCOL_VERSION(1, 0, 1)
+#define SNDRV_SEQ_VERSION_MAX	SNDRV_PROTOCOL_VERSION(1, 0, 2)
 
 typedef struct {
 	int fd;
+	int micro_version;
 } snd_seq_hw_t;
 #endif /* DOC_HIDDEN */
 
@@ -100,6 +101,10 @@ static int snd_seq_hw_get_client_info(snd_seq_t *seq, snd_seq_client_info_t * in
 		/*SYSERR("SNDRV_SEQ_IOCTL_GET_CLIENT_INFO failed");*/
 		return -errno;
 	}
+	if (hw->micro_version < SNDRV_PROTOCOL_MICRO(SNDRV_SEQ_VERSION_MAX)) {
+		info->card = -1;
+		info->pid = -1;
+	}
 	return 0;
 }
 
@@ -368,6 +373,10 @@ static int snd_seq_hw_query_next_client(snd_seq_t *seq, snd_seq_client_info_t *i
 		/*SYSERR("SNDRV_SEQ_IOCTL_QUERY_NEXT_CLIENT failed");*/
 		return -errno;
 	}
+	if (hw->micro_version < SNDRV_PROTOCOL_MICRO(SNDRV_SEQ_VERSION_MAX)) {
+		info->card = -1;
+		info->pid = -1;
+	}
 	return 0;
 }
 
@@ -480,6 +489,7 @@ int snd_seq_hw_open(snd_seq_t **handle, const char *name, int streams, int mode)
 		return -ENOMEM;
 	}
 	hw->fd = fd;
+	hw->micro_version = SNDRV_PROTOCOL_MICRO(ver);
 	if (streams & SND_SEQ_OPEN_OUTPUT) {
 		seq->obuf = (char *) malloc(seq->obufsize = SND_SEQ_OBUF_SIZE);
 		if (!seq->obuf) {
-- 
2.1.4


--nFreZHaLTZJo0R7j
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Provide-card-number-PID-via-sequencer-client-info.patch"

>From 133a8b3e059a09bf50ce62ae9960472dc09e71d2 Mon Sep 17 00:00:00 2001
From: Martin Koegler <martin.koegler@chello.at>
Date: Thu, 11 Feb 2016 20:07:20 +0100
Subject: [PATCH] Provide card number / PID via sequencer client info

rawmidi devices expose the card number via IOCTLs, which allows to
find the corresponding device in sysfs.

The sequencer provides no identifing data. Chromium works around this
issue by scanning rawmidi as well as sequencer devices and matching
them by using assumtions, how the kernel register sequencer devices.

This changes adds support for exposing the card number for kernel clients
as well as the PID for user client.

The minor of the API version is changed to distinguish between the zero
initialised reserved field and card number 0.

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 include/uapi/sound/asequencer.h |  6 ++++--
 sound/core/seq/seq_clientmgr.c  | 14 ++++++++++++++
 sound/core/seq/seq_clientmgr.h  |  2 ++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/asequencer.h b/include/uapi/sound/asequencer.h
index 5a5fa49..8c7da5a 100644
--- a/include/uapi/sound/asequencer.h
+++ b/include/uapi/sound/asequencer.h
@@ -25,7 +25,7 @@
 #include <sound/asound.h>
 
 /** version of the sequencer */
-#define SNDRV_SEQ_VERSION SNDRV_PROTOCOL_VERSION (1, 0, 1)
+#define SNDRV_SEQ_VERSION SNDRV_PROTOCOL_VERSION (1, 0, 2)
 
 /**
  * definition of sequencer event types
@@ -357,7 +357,9 @@ struct snd_seq_client_info {
 	unsigned char event_filter[32];	/* event filter bitmap */
 	int num_ports;			/* RO: number of ports */
 	int event_lost;			/* number of lost events */
-	char reserved[64];		/* for future use */
+	int card;			/* RO: card number[kernel] */
+	int pid;			/* RO: pid[user] */
+	char reserved[56];		/* for future use */
 };
 
 
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 58e79e0..d6d9419 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -364,6 +364,7 @@ static int snd_seq_open(struct inode *inode, struct file *file)
 	/* fill client data */
 	user->file = file;
 	sprintf(client->name, "Client-%d", c);
+	client->data.user.owner = get_pid(task_pid(current));
 
 	/* make others aware this new client */
 	snd_seq_system_client_ev_client_start(c);
@@ -380,6 +381,7 @@ static int snd_seq_release(struct inode *inode, struct file *file)
 		seq_free_client(client);
 		if (client->data.user.fifo)
 			snd_seq_fifo_delete(&client->data.user.fifo);
+		put_pid(client->data.user.owner);
 		kfree(client);
 	}
 
@@ -1197,6 +1199,17 @@ static void get_client_info(struct snd_seq_client *cptr,
 	info->event_lost = cptr->event_lost;
 	memcpy(info->event_filter, cptr->event_filter, 32);
 	info->num_ports = cptr->num_ports;
+
+	if (cptr->type == USER_CLIENT)
+		info->pid = pid_vnr(cptr->data.user.owner);
+	else
+		info->pid = -1;
+
+	if (cptr->type == KERNEL_CLIENT)
+		info->card = cptr->data.kernel.card ? cptr->data.kernel.card->number : -1;
+	else
+		info->card = -1;
+
 	memset(info->reserved, 0, sizeof(info->reserved));
 }
 
@@ -2271,6 +2284,7 @@ int snd_seq_create_kernel_client(struct snd_card *card, int client_index,
 
 	client->accept_input = 1;
 	client->accept_output = 1;
+	client->data.kernel.card = card;
 		
 	va_start(args, name_fmt);
 	vsnprintf(client->name, sizeof(client->name), name_fmt, args);
diff --git a/sound/core/seq/seq_clientmgr.h b/sound/core/seq/seq_clientmgr.h
index 20f0a72..031462e 100644
--- a/sound/core/seq/seq_clientmgr.h
+++ b/sound/core/seq/seq_clientmgr.h
@@ -33,6 +33,7 @@
 struct snd_seq_user_client {
 	struct file *file;	/* file struct of client */
 	/* ... */
+	struct pid* owner;
 	
 	/* fifo */
 	struct snd_seq_fifo *fifo;	/* queue for incoming events */
@@ -41,6 +42,7 @@ struct snd_seq_user_client {
 
 struct snd_seq_kernel_client {
 	/* ... */
+	struct snd_card* card;
 };
 
 
-- 
2.1.4


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--nFreZHaLTZJo0R7j--
