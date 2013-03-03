From: Mark Hills <mark@xwax.org>
Subject: [PATCH RFC 2/4] usb: Allow us to distinguish between
	different returns of EMSGSIZE
Date: Sun,  3 Mar 2013 17:57:35 +0000
Message-ID: <1362333457-23895-2-git-send-email-mark@xwax.org>
References: <alpine.LNX.2.01.1303021621060.8986@localhost>
 <1362333457-23895-1-git-send-email-mark@xwax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EA8EC26257D
 for <alsa-devel@alsa-project.org>; Sun,  3 Mar 2013 18:57:38 +0100 (CET)
In-Reply-To: <1362333457-23895-1-git-send-email-mark@xwax.org>
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
List-Id: alsa-devel@alsa-project.org

---
 drivers/usb/core/urb.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index e0d9d94..7f00213 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -408,16 +408,24 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
 			return -EINVAL;
 		for (n = 0; n < urb->number_of_packets; n++) {
 			len = urb->iso_frame_desc[n].length;
-			if (len < 0 || len > max)
+			if (len < 0 || len > max) {
+				dev_dbg(&dev->dev,
+					"bad packet length %d (max %d)",
+					len,  max);
 				return -EMSGSIZE;
+			}
 			urb->iso_frame_desc[n].status = -EXDEV;
 			urb->iso_frame_desc[n].actual_length = 0;
 		}
 	}
 
 	/* the I/O buffer must be mapped/unmapped, except when length=0 */
-	if (urb->transfer_buffer_length > INT_MAX)
+	if (urb->transfer_buffer_length > INT_MAX) {
+		dev_dbg(&dev->dev,
+			"transfer buffer length (%d) too large",
+			urb->transfer_buffer_length);
 		return -EMSGSIZE;
+	}
 
 #ifdef DEBUG
 	/* stuff that drivers shouldn't do, but which shouldn't
-- 
1.7.12.1
