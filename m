From: Martin Koegler <martin.koegler@chello.at>
Subject: [PATCH] Provide sequencer sound card number / PID via
	alsa-lib
Date: Sat, 13 Feb 2016 14:42:15 +0100
Message-ID: <1455370937-501-1-git-send-email-martin@mail.zuhause>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe03-1.mx.upcmail.net
 (vie01a-dmta-pe03-1.mx.upcmail.net [62.179.121.160])
 by alsa0.perex.cz (Postfix) with ESMTP id 6420F260536
 for <alsa-devel@alsa-project.org>; Sat, 13 Feb 2016 14:42:23 +0100 (CET)
Received: from [172.31.216.43] (helo=vie01a-pemc-psmtp-pe01)
 by vie01a-dmta-pe03.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <martin.koegler@chello.at>) id 1aUaSs-0000VR-Vq
 for alsa-devel@alsa-project.org; Sat, 13 Feb 2016 14:42:22 +0100
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
Cc: Martin Koegler <martin.koegler@chello.at>
List-Id: alsa-devel@alsa-project.org

From: Martin Koegler <martin.koegler@chello.at>

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
 include/seq.h              |  1 +
 include/sound/asequencer.h |  5 +++--
 src/seq/seq.c              | 11 +++++++++++
 src/seq/seq_hw.c           |  8 +++++++-
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/seq.h b/include/seq.h
index 9576822..77996e5 100644
--- a/include/seq.h
+++ b/include/seq.h
@@ -143,6 +143,7 @@ snd_seq_client_type_t snd_seq_client_info_get_type(const snd_seq_client_info_t *
 const char *snd_seq_client_info_get_name(snd_seq_client_info_t *info);
 int snd_seq_client_info_get_broadcast_filter(const snd_seq_client_info_t *info);
 int snd_seq_client_info_get_error_bounce(const snd_seq_client_info_t *info);
+int snd_seq_client_info_get_owner(const snd_seq_client_info_t *info);
 const unsigned char *snd_seq_client_info_get_event_filter(const snd_seq_client_info_t *info);
 int snd_seq_client_info_get_num_ports(const snd_seq_client_info_t *info);
 int snd_seq_client_info_get_event_lost(const snd_seq_client_info_t *info);
diff --git a/include/sound/asequencer.h b/include/sound/asequencer.h
index 09c8a00..7ebf7fd 100644
--- a/include/sound/asequencer.h
+++ b/include/sound/asequencer.h
@@ -24,7 +24,7 @@
 
 
 /** version of the sequencer */
-#define SNDRV_SEQ_VERSION SNDRV_PROTOCOL_VERSION (1, 0, 1)
+#define SNDRV_SEQ_VERSION SNDRV_PROTOCOL_VERSION (1, 0, 2)
 
 /**
  * definition of sequencer event types
@@ -356,7 +356,8 @@ struct snd_seq_client_info {
 	unsigned char event_filter[32];	/* event filter bitmap */
 	int num_ports;			/* RO: number of ports */
 	int event_lost;			/* number of lost events */
-	char reserved[64];		/* for future use */
+	int owner;			/* RO: card number[kernel] / PID[user] */
+	char reserved[64 - sizeof(int)]; /* for future use */
 };
 
 
diff --git a/src/seq/seq.c b/src/seq/seq.c
index 620ca3f..2505293 100644
--- a/src/seq/seq.c
+++ b/src/seq/seq.c
@@ -1522,6 +1522,17 @@ int snd_seq_client_info_get_error_bounce(const snd_seq_client_info_t *info)
 }
 
 /**
+ * \brief Get the sound card number (kernel) or owning PID
+ * \param info client_info container
+ * \return card number/PID/-1 if value is not available.
+ */
+int snd_seq_client_info_get_owner(const snd_seq_client_info_t *info)
+{
+	assert(info);
+	return info->owner;
+}
+
+/**
  * \brief (DEPRECATED) Get the event filter bitmap of a client_info container
  * \param info client_info container
  * \return NULL if no event filter, or pointer to event filter bitmap
diff --git a/src/seq/seq_hw.c b/src/seq/seq_hw.c
index d033367..a4c083a 100644
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
 
@@ -100,6 +101,8 @@ static int snd_seq_hw_get_client_info(snd_seq_t *seq, snd_seq_client_info_t * in
 		/*SYSERR("SNDRV_SEQ_IOCTL_GET_CLIENT_INFO failed");*/
 		return -errno;
 	}
+	if (hw->micro_version < SNDRV_PROTOCOL_MICRO(SNDRV_SEQ_VERSION_MAX))
+		info->owner = -1;
 	return 0;
 }
 
@@ -368,6 +371,8 @@ static int snd_seq_hw_query_next_client(snd_seq_t *seq, snd_seq_client_info_t *i
 		/*SYSERR("SNDRV_SEQ_IOCTL_QUERY_NEXT_CLIENT failed");*/
 		return -errno;
 	}
+	if (hw->micro_version < SNDRV_PROTOCOL_MICRO(SNDRV_SEQ_VERSION_MAX))
+		info->owner = -1;
 	return 0;
 }
 
@@ -480,6 +485,7 @@ int snd_seq_hw_open(snd_seq_t **handle, const char *name, int streams, int mode)
 		return -ENOMEM;
 	}
 	hw->fd = fd;
+	hw->micro_version = SNDRV_PROTOCOL_MICRO(ver);
 	if (streams & SND_SEQ_OPEN_OUTPUT) {
 		seq->obuf = (char *) malloc(seq->obufsize = SND_SEQ_OBUF_SIZE);
 		if (!seq->obuf) {
-- 
2.6.2
