From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v1 2/6] usb: audio: Fix variable length field
	to be variable.
Date: Tue, 19 Dec 2017 09:14:07 +0000
Message-ID: <20171219091411.16267-3-jorge.sanjuan@codethink.co.uk>
References: <20171219091411.16267-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 18AD72675FB
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 10:14:17 +0100 (CET)
In-Reply-To: <20171219091411.16267-1-jorge.sanjuan@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: linux-kernel@lists.codethink.co.uk, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>, ci005-internal@lists.codethink.co.uk
List-Id: alsa-devel@alsa-project.org

Make bmaControls be a flex array insted of a fixed size array so it
can have a variable length.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 include/linux/usb/audio-v3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/usb/audio-v3.h b/include/linux/usb/audio-v3.h
index cbbe51e309dd..68f651e8d11a 100644
--- a/include/linux/usb/audio-v3.h
+++ b/include/linux/usb/audio-v3.h
@@ -176,7 +176,7 @@ struct uac3_feature_unit_descriptor {
 	__u8 bSourceID;
 	/* bmaControls is actually u32,
 	 * but u8 is needed for the hybrid parser */
-	__u8 bmaControls[0]; /* variable length */
+	__u8 bmaControls[]; /* variable length */
 	/* wFeatureDescrStr omitted */
 } __attribute__((packed));
 
-- 
2.11.0
