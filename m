From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 3/5] hda-emu: Add CX20585 to modem whitelist
Date: Tue, 21 Aug 2012 10:54:01 +0200
Message-ID: <1345539243-8147-4-git-send-email-david.henningsson@canonical.com>
References: <1345539243-8147-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6633B265EEF
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 10:54:11 +0200 (CEST)
In-Reply-To: <1345539243-8147-1-git-send-email-david.henningsson@canonical.com>
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

Otherwise parsing of cx20585-dell-vostro-1015-ccert-201010-6649
won't work correctly.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-parse.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/hda-parse.c b/hda-parse.c
index c57ba78..73658c5 100644
--- a/hda-parse.c
+++ b/hda-parse.c
@@ -396,6 +396,7 @@ static int in_modem_whitelist(struct xhda_codec *codec)
 	case 0x14f15045:
 	case 0x14f15047:
 	case 0x14f15051:
+	case 0x14f15069:
 		return 1;
 	}
 	return 0;
-- 
1.7.9.5
