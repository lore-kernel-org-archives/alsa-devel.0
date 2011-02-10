From: linux@audioscience.com
Subject: [PATCH 08/28] Add include guard.
Date: Thu, 10 Feb 2011 17:26:01 +1300
Message-ID: <1297311981-30448-9-git-send-email-linux@audioscience.com>
References: <1297311981-30448-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1297311981-30448-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpimsginit.h |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/pci/asihpi/hpimsginit.h b/pci/asihpi/hpimsginit.h
index 864ad02..bfd330d 100644
--- a/pci/asihpi/hpimsginit.h
+++ b/pci/asihpi/hpimsginit.h
@@ -21,11 +21,15 @@
  (C) Copyright AudioScience Inc. 2007
 *******************************************************************************/
 /* Initialise response headers, or msg/response pairs.
-Note that it is valid to just init a response e.g. when a lower level is preparing
-a response to a message.
-However, when sending a message, a matching response buffer always must be prepared
+Note that it is valid to just init a response e.g. when a lower level is
+preparing a response to a message.
+However, when sending a message, a matching response buffer must always be
+prepared.
 */
 
+#ifndef _HPIMSGINIT_H_
+#define _HPIMSGINIT_H_
+
 void hpi_init_response(struct hpi_response *phr, u16 object, u16 function,
 	u16 error);
 
@@ -38,3 +42,5 @@ void hpi_init_responseV1(struct hpi_response_header *phr, u16 size,
 void hpi_init_message_responseV1(struct hpi_message_header *phm, u16 msg_size,
 	struct hpi_response_header *phr, u16 res_size, u16 object,
 	u16 function);
+
+#endif				/* _HPIMSGINIT_H_ */
-- 
1.7.0.4
