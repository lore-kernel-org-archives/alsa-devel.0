From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ALSA: seq: Protect in-kernel ioctl calls
	with mutex
Date: Tue,  9 Apr 2019 19:00:19 +0200
Message-ID: <20190409170020.20685-5-tiwai@suse.de>
References: <20190409170020.20685-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22F2EF89610
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 19:00:24 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 8EC78B07D
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 17:00:23 +0000 (UTC)
In-Reply-To: <20190409170020.20685-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ALSA OSS sequencer calls the ioctl function indirectly via
snd_seq_kernel_client_ctl().  While we already applied the protection
against races between the normal ioctls and writes via the client's
ioctl_mutex, this code path was left untouched.  And this seems to be
the cause of still remaining some rare UAF as spontaneously triggered
by syzkaller.

For the sake of robustness, wrap the ioctl_mutex also for the call via
snd_seq_kernel_client_ctl(), too.

Reported-by: syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 933bde3843d9..976404691261 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2340,14 +2340,19 @@ int snd_seq_kernel_client_ctl(int clientid, unsigned int cmd, void *arg)
 {
 	const struct ioctl_handler *handler;
 	struct snd_seq_client *client;
+	int err;
 
 	client = clientptr(clientid);
 	if (client == NULL)
 		return -ENXIO;
 
 	for (handler = ioctl_handlers; handler->cmd > 0; ++handler) {
-		if (handler->cmd == cmd)
-			return handler->func(client, arg);
+		if (handler->cmd == cmd) {
+			mutex_lock(&client->ioctl_mutex);
+			err = handler->func(client, arg);
+			mutex_unlock(&client->ioctl_mutex);
+			return err;
+		}
 	}
 
 	pr_debug("ALSA: seq unknown ioctl() 0x%x (type='%c', number=0x%02x)\n",
-- 
2.16.4
