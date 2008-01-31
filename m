From: "Aldrin Martoq" <amartoq@dcc.uchile.cl>
Subject: [PATCH] SND_SEQ_BLOCK and SND_SEQ_PORT_CAP_NONE defines
Date: Thu, 31 Jan 2008 14:42:42 -0300
Message-ID: <17eedd8a0801310942g48245675k4a96162e810fd21a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.178])
	by alsa0.perex.cz (Postfix) with ESMTP id DFB5E243FF
	for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2008 18:42:51 +0100 (CET)
Received: by el-out-1112.google.com with SMTP id z25so271143ele.8
	for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2008 09:42:50 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hey hackers,

While developing pyalsa sequencer API, I found that sometimes 0 is
used instead of a #defined value or constant.

In my opinion, given that the alsa API is opaque (hides internal
structure and provides methods for accessing them), we should define
those missing "constants" for being consistent. So far I found:
SND_SEQ_BLOCK 0 (blocking mode)
SND_SEQ_PORT_CAP_NONE (the port defines no access capabilites)



BTW, Thanks Jaroslav for putting my code; I will send 3rd patch for
covering the missing items of the python API sequencer when I'll
finish it.

Signed-off-by: Aldrin Martoq <amartoq@dcc.uchile.cl>
---
diff --git a/include/seq.h b/include/seq.h
--- a/include/seq.h
+++ b/include/seq.h
@@ -56,7 +56,8 @@ typedef struct _snd_seq snd_seq_t;
 /**
  * sequencer opening mode
  */
-#define SND_SEQ_NONBLOCK       0x0001  /**< non-blocking mode (flag
to open mode) */
+#define SND_SEQ_BLOCK          0x0000  /**< blocking opening mode
(flag for #snd_seq_open, #snd_seq_nonblock) */
+#define SND_SEQ_NONBLOCK       0x0001  /**< non-blocking opening mode
(flag for #snd_seq_open, #snd_seq_nonblock) */

 /** sequencer handle type */
 typedef enum _snd_seq_type {
@@ -204,6 +205,7 @@ typedef struct _snd_seq_port_info snd_se
 #define SND_SEQ_PORT_SYSTEM_ANNOUNCE   1       /**< system announce port */

 /** port capabilities (32 bits) */
+#define SND_SEQ_PORT_CAP_NONE          (0<<0)  /**< port has no
access capabilities */
 #define SND_SEQ_PORT_CAP_READ          (1<<0)  /**< readable from this port */
 #define SND_SEQ_PORT_CAP_WRITE         (1<<1)  /**< writable to this port */

diff --git a/src/seq/seq.c b/src/seq/seq.c
--- a/src/seq/seq.c
+++ b/src/seq/seq.c
@@ -958,7 +958,7 @@ static int snd_seq_open_noupdate(snd_seq
  * \note Internally, these are translated to \c O_WRONLY, \c O_RDONLY and
  * \c O_RDWR respectively and used as the second argument to the C library
  * open() call.
- * \param mode Optional modifier.  Can be either 0, or
+ * \param mode Optional modifier.  Can be either #SND_SEQ_BLOCK, or
  * #SND_SEQ_NONBLOCK, which will make read/write operations
  * non-blocking.  This can also be set later using #snd_seq_nonblock().
  * \return 0 on success otherwise a negative error code
@@ -2161,8 +2161,9 @@ void snd_seq_port_info_set_timestamp_que
  * Each port has the capability bit-masks to specify the access capability
  * of the port from other clients.
  * The capability bit flags are defined as follows:
+ * - #SND_SEQ_PORT_CAP_NONE No access capabilities
  * - #SND_SEQ_PORT_CAP_READ Readable from this port
- * - #SND_SEQ_PORT_CAP_WRITE Writable to this port.
+ * - #SND_SEQ_PORT_CAP_WRITE Writable to this port
  * - #SND_SEQ_PORT_CAP_SYNC_READ For synchronization (not implemented)
  * - #SND_SEQ_PORT_CAP_SYNC_WRITE For synchronization (not implemented)
  * - #SND_SEQ_PORT_CAP_DUPLEX Read/write duplex access is supported



-- 
Aldrin Martoq
