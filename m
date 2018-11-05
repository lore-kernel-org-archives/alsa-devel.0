From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RFC PATCH] cplay: Always write frag * fragment_size
Date: Mon, 5 Nov 2018 14:23:27 +0000
Message-ID: <1541427790-27876-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60044.outbound.protection.outlook.com [40.107.6.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D0F42678DA
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 15:23:28 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>
List-Id: alsa-devel@alsa-project.org

cplay first writes frag * fragment_size and then
it only writes one fragment at a time.

This means for example than if the user supplied a buffer_size
it will only be used for the first write.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
I noticed this while investigating why cplay prints buffer_size as
0 when not specified as command line argument to cplay.

I also noticed that cred always reads frag * frament_size, so I think
this patch should be OK, but marking it as RFC to get your thoughts.

 src/utils/cplay.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/utils/cplay.c b/src/utils/cplay.c
index 2a52b52..b016f52 100644
--- a/src/utils/cplay.c
+++ b/src/utils/cplay.c
@@ -435,15 +435,15 @@ void play_samples(char *name, unsigned int card, unsigned int device,
 	};
 	if (verbose)
 		printf("%s: Opened compress device\n", __func__);
-	size = config.fragment_size;
-	buffer = malloc(size * config.fragments);
+	size = config.fragments * config.fragment_size;
+	buffer = malloc(size);
 	if (!buffer) {
 		fprintf(stderr, "Unable to allocate %d bytes\n", size);
 		goto COMP_EXIT;
 	}
 
 	/* we will write frag fragment_size and then start */
-	num_read = fread(buffer, 1, size * config.fragments, file);
+	num_read = fread(buffer, 1, size, file);
 	if (num_read > 0) {
 		if (verbose)
 			printf("%s: Doing first buffer write of %d\n", __func__, num_read);
@@ -459,7 +459,7 @@ void play_samples(char *name, unsigned int card, unsigned int device,
 		}
 	}
 	printf("Playing file %s On Card %u device %u, with buffer of %lu bytes\n",
-			name, card, device, buffer_size);
+			name, card, device, size);
 	printf("Format %u Channels %u, %u Hz, Bit Rate %d\n",
 			codec.id, codec.ch_in, codec.sample_rate, codec.bit_rate);
 
-- 
2.7.4
