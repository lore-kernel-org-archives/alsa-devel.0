From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/5] hda-spec: Add access to secret node 0x8
	for Haswell/Broadwell HDMI
Date: Mon, 22 Sep 2014 13:09:03 +0200
Message-ID: <1411384146-23286-3-git-send-email-david.henningsson@canonical.com>
References: <1411384146-23286-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F51C265268
 for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2014 13:09:11 +0200 (CEST)
In-Reply-To: <1411384146-23286-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-spec.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hda-spec.c b/hda-spec.c
index 0ff0388..fa21cf5 100644
--- a/hda-spec.c
+++ b/hda-spec.c
@@ -575,6 +575,18 @@ static void fixup_alc268_beep(struct xhda_codec *codec)
 	node->amp_in_caps.override = 1;
 }
 
+static int haswell_ext_cmd(struct xhda_codec *codec, unsigned int cmd)
+{
+	unsigned int nid = (cmd >> 20) & 0x7f;
+
+	codec->rc = 0;
+
+	/* Secret Haswell node on 0x8, used to turn on DP1.2 features */
+	if (nid == 0x8)
+		return 0;
+	return -ENXIO;
+}
+
 static void fixup_haswellhdmi(struct xhda_codec *codec)
 {
 	struct xhda_node *node;
@@ -602,6 +614,8 @@ static void fixup_haswellhdmi(struct xhda_codec *codec)
 			node->node[0] = 0x2;
 		}
 	}
+
+	codec->extended_cmd = haswell_ext_cmd;
 }
 
 struct fixup_list {
-- 
1.9.1
