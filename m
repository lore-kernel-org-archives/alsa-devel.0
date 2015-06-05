From: Adam Goode <agoode@google.com>
Subject: [PATCH - alsa-lib 1/1] Introduce
	snd_seq_client_info_get_card_number,
	for getting the card number of a seq client on recent kernels
Date: Thu,  4 Jun 2015 21:05:12 -0400
Message-ID: <1433466312-31444-1-git-send-email-agoode@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f43.google.com (mail-yh0-f43.google.com
 [209.85.213.43])
 by alsa0.perex.cz (Postfix) with ESMTP id CF1592666BE
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 03:05:20 +0200 (CEST)
Received: by yhpn97 with SMTP id n97so15074447yhp.0
 for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2015 18:05:20 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adam Goode <agoode@google.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Adam Goode <agoode@google.com>

diff --git a/configure.ac b/configure.ac
index 9621d4e..01bb0fb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -14,7 +14,7 @@ dnl remove API = c+1:0:0
 dnl *************************************************
 AC_CANONICAL_HOST
 AM_INIT_AUTOMAKE
-eval LIBTOOL_VERSION_INFO="2:0:0"
+eval LIBTOOL_VERSION_INFO="3:0:1"
 dnl *************************************************
 AM_CONDITIONAL([INSTALL_M4], [test -n "${ACLOCAL}"])
 
diff --git a/include/seq.h b/include/seq.h
index 9576822..e0f9b78 100644
--- a/include/seq.h
+++ b/include/seq.h
@@ -146,6 +146,7 @@ int snd_seq_client_info_get_error_bounce(const snd_seq_client_info_t *info);
 const unsigned char *snd_seq_client_info_get_event_filter(const snd_seq_client_info_t *info);
 int snd_seq_client_info_get_num_ports(const snd_seq_client_info_t *info);
 int snd_seq_client_info_get_event_lost(const snd_seq_client_info_t *info);
+int snd_seq_client_info_get_card_number(const snd_seq_client_info_t *info);
 
 void snd_seq_client_info_set_client(snd_seq_client_info_t *info, int client);
 void snd_seq_client_info_set_name(snd_seq_client_info_t *info, const char *name);
diff --git a/include/sound/asequencer.h b/include/sound/asequencer.h
index 09c8a00..c2a659b 100644
--- a/include/sound/asequencer.h
+++ b/include/sound/asequencer.h
@@ -22,9 +22,10 @@
 #ifndef _UAPI__SOUND_ASEQUENCER_H
 #define _UAPI__SOUND_ASEQUENCER_H
 
+#include <sound/asound.h>
 
 /** version of the sequencer */
-#define SNDRV_SEQ_VERSION SNDRV_PROTOCOL_VERSION (1, 0, 1)
+#define SNDRV_SEQ_VERSION SNDRV_PROTOCOL_VERSION (1, 0, 2)
 
 /**
  * definition of sequencer event types
@@ -356,7 +357,8 @@ struct snd_seq_client_info {
 	unsigned char event_filter[32];	/* event filter bitmap */
 	int num_ports;			/* RO: number of ports */
 	int event_lost;			/* number of lost events */
-	char reserved[64];		/* for future use */
+	int card_number;		/* RO: card number, or -1 if no card. Added in protocol version 1.0.2 */
+	char reserved[60];		/* for future use */
 };
 
 
diff --git a/src/seq/seq.c b/src/seq/seq.c
index 620ca3f..bc39046 100644
--- a/src/seq/seq.c
+++ b/src/seq/seq.c
@@ -1651,6 +1651,18 @@ int snd_seq_client_info_get_event_lost(const snd_seq_client_info_t *info)
 }
 
 /**
+ * \brief Get the card number of a client_info container
+ * \param info client_info container
+ * \return the card number, -1 if no card associated with this client, or -ENOSYS if the
+ *         kernel does not support reporting this field
+ */
+int snd_seq_client_info_get_card_number(const snd_seq_client_info_t *info)
+{
+	assert(info);
+	return info->card_number;
+}
+
+/**
  * \brief Set the client id of a client_info container
  * \param info client_info container
  * \param client client id
diff --git a/src/seq/seq_hw.c b/src/seq/seq_hw.c
index d033367..8502d63 100644
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
+	int version;
 } snd_seq_hw_t;
 #endif /* DOC_HIDDEN */
 
@@ -100,6 +101,10 @@ static int snd_seq_hw_get_client_info(snd_seq_t *seq, snd_seq_client_info_t * in
 		/*SYSERR("SNDRV_SEQ_IOCTL_GET_CLIENT_INFO failed");*/
 		return -errno;
 	}
+	/* The card_number field was added in protocol 1.0.2, so set to -ENOSYS if older. */
+	if (hw->version < SNDRV_PROTOCOL_VERSION(1, 0, 2)) {
+		info->card_number = -ENOSYS;
+	}
 	return 0;
 }
 
@@ -368,6 +373,10 @@ static int snd_seq_hw_query_next_client(snd_seq_t *seq, snd_seq_client_info_t *i
 		/*SYSERR("SNDRV_SEQ_IOCTL_QUERY_NEXT_CLIENT failed");*/
 		return -errno;
 	}
+	/* The card_number field was added in protocol 1.0.2, so set to -ENOSYS if older. */
+	if (hw->version < SNDRV_PROTOCOL_VERSION(1, 0, 2)) {
+		info->card_number = -ENOSYS;
+	}
 	return 0;
 }
 
@@ -480,6 +489,7 @@ int snd_seq_hw_open(snd_seq_t **handle, const char *name, int streams, int mode)
 		return -ENOMEM;
 	}
 	hw->fd = fd;
+	hw->version = ver;
 	if (streams & SND_SEQ_OPEN_OUTPUT) {
 		seq->obuf = (char *) malloc(seq->obufsize = SND_SEQ_OBUF_SIZE);
 		if (!seq->obuf) {
diff --git a/test/seq.c b/test/seq.c
index 34b000f..a4e5f1f 100644
--- a/test/seq.c
+++ b/test/seq.c
@@ -111,7 +111,7 @@ void show_port_info(snd_seq_t *handle, int client, int port)
 
 void show_client_info(snd_seq_t *handle, int client)
 {
-	int err, idx, min, max;
+	int err, idx, min, max, card_number;
 	snd_seq_client_info_t *info;
 
 	snd_seq_client_info_alloca(&info);
@@ -124,11 +124,14 @@ void show_client_info(snd_seq_t *handle, int client)
 			fprintf(stderr, "Client %i info error: %s\n", idx, snd_strerror(err));
 			exit(0);
 		}
+		card_number = snd_seq_client_info_get_card_number(info);
 		printf("Client %i info\n", idx);
 		if (verbose)
 			printf("  Client        : %i\n", snd_seq_client_info_get_client(info));
 		printf("  Type          : %s\n", snd_seq_client_info_get_type(info) == SND_SEQ_KERNEL_CLIENT ? "kernel" : "user");
 		printf("  Name          : %s\n", snd_seq_client_info_get_name(info));
+		if (card_number != -ENOSYS)
+			printf("  Card Number   : %i\n", card_number);
 	}
 }
 
-- 
2.2.0.rc0.207.ga3a616c
