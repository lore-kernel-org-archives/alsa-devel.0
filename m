From: Jerome Forissier <jerome@taodyne.com>
Subject: [PATCH 2/2] snd_pcm_direct_parse_open_conf(): use
	thread-safe getgrnam_r()
Date: Wed, 30 Jan 2013 16:22:17 +0100
Message-ID: <1359559337-15533-3-git-send-email-jerome@taodyne.com>
References: <1359559337-15533-1-git-send-email-jerome@taodyne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ubuntu (102.30.7.109.rev.sfr.net [109.7.30.102])
 by alsa0.perex.cz (Postfix) with ESMTP id D11A126507F
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2013 16:23:09 +0100 (CET)
In-Reply-To: <1359559337-15533-1-git-send-email-jerome@taodyne.com>
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
Cc: Jerome Forissier <jerome@taodyne.com>
List-Id: alsa-devel@alsa-project.org

Fixes a thread safety issue with snd_pcm_open().

Signed-off-by: Jerome Forissier <jerome@taodyne.com>
---
 src/pcm/pcm_direct.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 6802ecc..38c6c66 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -1629,13 +1629,20 @@ int snd_pcm_direct_parse_open_conf(snd_config_t *root, snd_config_t *conf,
 				continue;
 			}
 			if (isdigit(*group) == 0) {
-				struct group *grp = getgrnam(group);
-				if (grp == NULL) {
+				long clen = sysconf(_SC_GETGR_R_SIZE_MAX);
+				size_t len = (clen == -1) ? 1024 : (size_t)clen;
+				struct group grp, *pgrp;
+				char *buffer = (char *)malloc(len);
+				if (buffer == NULL)
+					return -ENOMEM;
+				int st = getgrnam_r(group, &grp, buffer, len, &pgrp);
+				if (st != 0) {
 					SNDERR("The field ipc_gid must be a valid group (create group %s)", group);
-					free(group);
+					free(buffer);
 					return -EINVAL;
 				}
-				rec->ipc_gid = grp->gr_gid;
+				rec->ipc_gid = pgrp->gr_gid;
+				free(buffer);
 			} else {
 				rec->ipc_gid = strtol(group, &endp, 10);
 			}
-- 
1.8.1.2
