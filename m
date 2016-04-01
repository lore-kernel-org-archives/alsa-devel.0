From: Adam Goode <agoode@google.com>
Subject: [PATCH - alsa-lib 1/1] Change card/pid get functions
	to return -ENOSYS if the kernel is too old
Date: Fri,  1 Apr 2016 13:33:50 -0400
Message-ID: <1459532030-6387-1-git-send-email-agoode@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f178.google.com (mail-yw0-f178.google.com
 [209.85.161.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 1409B261A0A
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2016 19:34:31 +0200 (CEST)
Received: by mail-yw0-f178.google.com with SMTP id h65so176018000ywe.0
 for <alsa-devel@alsa-project.org>; Fri, 01 Apr 2016 10:34:30 -0700 (PDT)
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
Cc: Adam Goode <agoode@google.com>, alsa-devel@alsa-project.org, martin.koegler@chello.at
List-Id: alsa-devel@alsa-project.org

When trying to get the pid or card of a client, the get functions will
return -1 if there is no pid or card for a client. Clients have zero or
one of these, so -1 is correct for these cases. But we also need to detect
the case where the kernel cannot tell us if there is a card or pid, so
that userspace can fallback to probing this information in the old way.

Signed-off-by: Adam Goode <agoode@google.com>

diff --git a/src/seq/seq.c b/src/seq/seq.c
index 4405e68..7de1e81 100644
--- a/src/seq/seq.c
+++ b/src/seq/seq.c
@@ -1522,9 +1522,10 @@ int snd_seq_client_info_get_error_bounce(const snd_seq_client_info_t *info)
 }
 
 /**
- * \brief Get the sound card number.
+ * \brief Get the sound card number if the kernel supports this.
  * \param info client_info container
- * \return card number or -1 if value is not available.
+ * \return card number, -1 if there is no card for this client,
+ *  or \c -ENOSYS if the kernel does not have support for this operation
  *
  * Only available for SND_SEQ_KERNEL_CLIENT clients.
  */
@@ -1535,9 +1536,10 @@ int snd_seq_client_info_get_card(const snd_seq_client_info_t *info)
 }
 
 /**
- * \brief Get the owning PID.
+ * \brief Get the owning PID if the kernel supports this.
  * \param info client_info container
- * \return pid or -1 if value is not available.
+ * \return pid, -1 if there is no PID for this client,
+ *  or \c -ENOSYS if the kernel does not have support for this operation
  *
  * Only available for SND_SEQ_USER_CLIENT clients.
  */
diff --git a/src/seq/seq_hw.c b/src/seq/seq_hw.c
index 578ef12..a1d1e4a 100644
--- a/src/seq/seq_hw.c
+++ b/src/seq/seq_hw.c
@@ -102,8 +102,8 @@ static int snd_seq_hw_get_client_info(snd_seq_t *seq, snd_seq_client_info_t * in
 		return -errno;
 	}
 	if (hw->version < SNDRV_PROTOCOL_VERSION(1, 0, 2)) {
-		info->card = -1;
-		info->pid = -1;
+		info->card = -ENOSYS;
+		info->pid = -ENOSYS;
 	}
 	return 0;
 }
@@ -374,8 +374,8 @@ static int snd_seq_hw_query_next_client(snd_seq_t *seq, snd_seq_client_info_t *i
 		return -errno;
 	}
 	if (hw->version < SNDRV_PROTOCOL_VERSION(1, 0, 2)) {
-		info->card = -1;
-		info->pid = -1;
+		info->card = -ENOSYS;
+		info->pid = -ENOSYS;
 	}
 	return 0;
 }
-- 
2.8.0.rc3.226.g39d4020
