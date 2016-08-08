From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/27] ALSA: seq: obsolete address mode in
	compatibility layer
Date: Mon,  8 Aug 2016 23:54:31 +0900
Message-ID: <1470668093-31027-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id C98B4267135
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 16:55:01 +0200 (CEST)
In-Reply-To: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In a 32/64 bit compatibility layer of ALSA sequencer core, data for some
ioctls is copied to kernel stack and passed to core operations. Then,
address limit of running task is changed because core implementation
expected arguments in userspace.

In this case, snd_seq_kernel_client_ctl() is available. This commit
replaces with it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/seq/seq_compat.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/sound/core/seq/seq_compat.c b/sound/core/seq/seq_compat.c
index 6517590..d9cf163 100644
--- a/sound/core/seq/seq_compat.c
+++ b/sound/core/seq/seq_compat.c
@@ -42,12 +42,11 @@ struct snd_seq_port_info32 {
 	char reserved[59];		/* for future use */
 };
 
-static int snd_seq_call_port_info_ioctl(struct snd_seq_client *client, unsigned int cmd,
-					struct snd_seq_port_info32 __user *data32)
+static int snd_seq_call_port_info_ioctl(int clientid, unsigned int cmd,
+				struct snd_seq_port_info32 __user *data32)
 {
 	int err = -EFAULT;
 	struct snd_seq_port_info *data;
-	mm_segment_t fs;
 
 	data = kmalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -59,9 +58,7 @@ static int snd_seq_call_port_info_ioctl(struct snd_seq_client *client, unsigned
 		goto error;
 	data->kernel = NULL;
 
-	fs = snd_enter_user();
-	err = snd_seq_do_ioctl(client, cmd, data);
-	snd_leave_user(fs);
+	err = snd_seq_kernel_client_ctl(clientid, cmd, data);
 	if (err < 0)
 		goto error;
 
@@ -123,17 +120,22 @@ static long snd_seq_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
 	case SNDRV_SEQ_IOCTL_GET_SUBSCRIPTION:
 	case SNDRV_SEQ_IOCTL_QUERY_NEXT_CLIENT:
 	case SNDRV_SEQ_IOCTL_RUNNING_MODE:
-		return snd_seq_do_ioctl(client, cmd, argp);
+		return snd_seq_ioctl(file, cmd, (unsigned long)argp);
 	case SNDRV_SEQ_IOCTL_CREATE_PORT32:
-		return snd_seq_call_port_info_ioctl(client, SNDRV_SEQ_IOCTL_CREATE_PORT, argp);
+		return snd_seq_call_port_info_ioctl(client->number,
+					SNDRV_SEQ_IOCTL_CREATE_PORT, argp);
 	case SNDRV_SEQ_IOCTL_DELETE_PORT32:
-		return snd_seq_call_port_info_ioctl(client, SNDRV_SEQ_IOCTL_DELETE_PORT, argp);
+		return snd_seq_call_port_info_ioctl(client->number,
+					SNDRV_SEQ_IOCTL_DELETE_PORT, argp);
 	case SNDRV_SEQ_IOCTL_GET_PORT_INFO32:
-		return snd_seq_call_port_info_ioctl(client, SNDRV_SEQ_IOCTL_GET_PORT_INFO, argp);
+		return snd_seq_call_port_info_ioctl(client->number,
+					SNDRV_SEQ_IOCTL_GET_PORT_INFO, argp);
 	case SNDRV_SEQ_IOCTL_SET_PORT_INFO32:
-		return snd_seq_call_port_info_ioctl(client, SNDRV_SEQ_IOCTL_SET_PORT_INFO, argp);
+		return snd_seq_call_port_info_ioctl(client->number,
+					SNDRV_SEQ_IOCTL_SET_PORT_INFO, argp);
 	case SNDRV_SEQ_IOCTL_QUERY_NEXT_PORT32:
-		return snd_seq_call_port_info_ioctl(client, SNDRV_SEQ_IOCTL_QUERY_NEXT_PORT, argp);
+		return snd_seq_call_port_info_ioctl(client->number,
+					SNDRV_SEQ_IOCTL_QUERY_NEXT_PORT, argp);
 	}
 	return -ENOIOCTLCMD;
 }
-- 
2.7.4
