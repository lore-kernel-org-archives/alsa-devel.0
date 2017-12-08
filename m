From: Markus Seeber <markus.seeber@spectralbird.de>
Subject: [PATCH] alsa-lib: pcm: segmentation fault snd_pcm_open
Date: Fri, 8 Dec 2017 15:19:55 +0100
Message-ID: <6e8842e0-119a-0baa-1d47-8198c1cc2adf@spectralbird.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mailbox.org (mx1.mailbox.org [80.241.60.212])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F144267BC5
 for <alsa-devel@alsa-project.org>; Fri,  8 Dec 2017 15:19:57 +0100 (CET)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Previously, calling snd_pcm_open with a null pointer argument for
"name" caused a segmentation fault in snd_config_search_definition.
The segmentation fault resulted from invoking undefined behavior by
calling strchr with a null pointer argument.

The issue can be reproduced by passing a null pointer for "name" to
snd_pcm_open.

To prevent this instance of strchr to be invoked with a null pointer
argument, snd_config_search_definition now returns EINVAL if argument
"name" is a null pointer.

Signed-off-by: Markus Seeber <markus.seeber@spectralbird.de>
---
 src/conf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/conf.c b/src/conf.c
index e71bb972..e04b575b 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -5078,6 +5078,8 @@ int snd_config_search_definition(snd_config_t *config,
 {
 	snd_config_t *conf;
 	char *key;
+	if(name == NULL)
+		return -EINVAL;
 	const char *args = strchr(name, ':');
 	int err;
 	if (args) {
-- 
2.15.1
