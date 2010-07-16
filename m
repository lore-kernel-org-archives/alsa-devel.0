From: linux@audioscience.com
Subject: [PATCH 8/9] Avoid using c99 uintX types.
Date: Fri, 16 Jul 2010 17:51:00 +1200
Message-ID: <1279259461-21543-3-git-send-email-linux@audioscience.com>
References: <1279259461-21543-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1279259461-21543-1-git-send-email-linux@audioscience.com>
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
 pci/asihpi/hpi_internal.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/pci/asihpi/hpi_internal.h b/pci/asihpi/hpi_internal.h
index 7ae7a1d..16f502d 100644
--- a/pci/asihpi/hpi_internal.h
+++ b/pci/asihpi/hpi_internal.h
@@ -104,9 +104,9 @@ typedef void hpi_handler_func(struct hpi_message *, struct hpi_response *);
 #define STR_ROLE_FIELD_MAX 255U
 
 struct hpi_entity_str {
-	uint16_t size;
-	uint8_t type;
-	uint8_t role;
+	u16 size;
+	u8 type;
+	u8 role;
 };
 
 #if defined(_MSC_VER)
@@ -119,11 +119,11 @@ struct hpi_entity {
 #if ! defined(HPI_OS_DSP_C6000) || (defined(HPI_OS_DSP_C6000) && (__TI_COMPILER_VERSION__ > 6000008))
 	/* DSP C6000 compiler v6.0.8 and lower
 	   do not support  flexible array member */
-	uint8_t value[];
+	u8 value[];
 #else
 	/* NOTE! Using sizeof(struct hpi_entity) will give erroneous results */
 #define HPI_INTERNAL_WARN_ABOUT_ENTITY_VALUE
-	uint8_t value[1];
+	u8 value[1];
 #endif
 };
 
-- 
1.7.0.4
