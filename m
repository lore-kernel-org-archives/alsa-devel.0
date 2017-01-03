From: Adam Goode <agoode@google.com>
Subject: [PATCH - seq 1/1] seq: improve documentation about new
	get pid/card functions
Date: Tue,  3 Jan 2017 08:33:42 -0500
Message-ID: <1483450422-8577-1-git-send-email-agoode@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f177.google.com (mail-pf0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id CF829266E4A
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 14:34:00 +0100 (CET)
Received: by mail-pf0-f177.google.com with SMTP id 189so77335613pfz.3
 for <alsa-devel@alsa-project.org>; Tue, 03 Jan 2017 05:34:00 -0800 (PST)
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

Document the technique for determining if the running kernel supports
the new snd_seq_client_info_get_pid and snd_seq_client_info_get_card
functions. Also add a little information about how to use these
functions and add some cross references.

Signed-off-by: Adam Goode <agoode@google.com>

diff --git a/src/seq/seq.c b/src/seq/seq.c
index 9279830..b206e2f 100644
--- a/src/seq/seq.c
+++ b/src/seq/seq.c
@@ -1530,7 +1530,25 @@ int snd_seq_client_info_get_error_bounce(const snd_seq_client_info_t *info)
  * \param info client_info container
  * \return card number or -1 if value is not available.
  *
- * Only available for SND_SEQ_KERNEL_CLIENT clients.
+ * Only available for #SND_SEQ_KERNEL_CLIENT clients.
+ *
+ * The card number can be used to query state about the hardware
+ * device providing this client, by concatenating <code>"hw:CARD="</code>
+ * with the card number and using it as the <code>name</code> parameter
+ * to #snd_ctl_open().
+ *
+ * \note
+ * The return value of -1 is returned for two different conditions: when the
+ * running kernel does not support this operation, and when the client
+ * does not have a hardware card attached. See
+ * #snd_seq_client_info_get_pid() for a way to determine if the
+ * currently running kernel has support for this operation.
+ *
+ * \sa snd_seq_client_info_get_pid(),
+ *     snd_card_get_name(),
+ *     snd_card_get_longname(),
+ *     snd_ctl_open(),
+ *     snd_ctl_card_info()
  */
 int snd_seq_client_info_get_card(const snd_seq_client_info_t *info)
 {
@@ -1543,7 +1561,29 @@ int snd_seq_client_info_get_card(const snd_seq_client_info_t *info)
  * \param info client_info container
  * \return pid or -1 if value is not available.
  *
- * Only available for SND_SEQ_USER_CLIENT clients.
+ * Only available for #SND_SEQ_USER_CLIENT clients.
+ *
+ * \note
+ * The functionality for getting a client's PID and getting a
+ * client's card was added to the kernel at the same time, so you can
+ * use this function to determine if the running kernel
+ * supports reporting these values. If your own client has a valid
+ * PID as reported by this function, then the running kernel supports
+ * both #snd_seq_client_info_get_card() and #snd_seq_client_info_get_pid().
+ *
+ * \note
+ * Example code for determining kernel support:
+ * \code
+ *   int is_get_card_or_pid_supported(snd_seq_t *seq)
+ *   {
+ *   	snd_seq_client_info_t *my_client_info;
+ *   	snd_seq_client_info_alloca(&my_client_info);
+ *   	snd_seq_get_client_info(seq, my_client_info);
+ *   	return snd_seq_client_info_get_pid(my_client_info) != -1;
+ *   }
+ * \endcode
+ *
+ * \sa snd_seq_client_info_get_card()
  */
 int snd_seq_client_info_get_pid(const snd_seq_client_info_t *info)
 {
-- 
2.8.0.rc3.226.g39d4020
