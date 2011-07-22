From: linux@audioscience.com
Subject: [PATCH 13/15] Control name updates
Date: Fri, 22 Jul 2011 15:53:01 +1200
Message-ID: <1311306785-23116-27-git-send-email-linux@audioscience.com>
References: <1311306785-23116-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1311306785-23116-1-git-send-email-linux@audioscience.com>
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

Add names corresponding to new HPI node types.
Shorten some names so that constructed names don't overflow the
maximum name length.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/asihpi.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 60444e7..8033d85 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -1329,10 +1329,12 @@ static const char * const asihpi_src_names[] = {
 	"RF",
 	"Clock",
 	"Bitstream",
-	"Microphone",
-	"Cobranet",
+	"Mic",
+	"Net",
 	"Analog",
 	"Adapter",
+	"RTP",
+	"GPI",
 };
 
 compile_time_assert(
@@ -1347,8 +1349,10 @@ static const char * const asihpi_dst_names[] = {
 	"Digital",
 	"RF",
 	"Speaker",
-	"Cobranet Out",
-	"Analog"
+	"Net",
+	"Analog",
+	"RTP",
+	"GPO",
 };
 
 compile_time_assert(
-- 
1.7.0.4
