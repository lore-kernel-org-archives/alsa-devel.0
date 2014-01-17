From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v3 04/16] ALSA: Oxygen: Add CS4245_SPI_READ
	constant
Date: Fri, 17 Jan 2014 19:08:23 +0400
Message-ID: <1389971315-3215-4-git-send-email-v1ron@mail.ru>
References: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Roman Volkov <v1ron@mail.ru>
List-Id: alsa-devel@alsa-project.org

The driver needs this constant to perform SPI read operations.
The shift from CS4245_SPI_ADDRESS and CS4245_SPI_WRITE constants
removed, since when we need to send two bytes instead of three
in the SPI packet, we need to shift left by 8 instead of 16.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/cs4245.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/oxygen/cs4245.h b/sound/pci/oxygen/cs4245.h
index 5e0197e..3dd487a 100644
--- a/sound/pci/oxygen/cs4245.h
+++ b/sound/pci/oxygen/cs4245.h
@@ -103,5 +103,6 @@
 #define CS4245_ADC_UNDRFL	0x01
 
 
-#define CS4245_SPI_ADDRESS	(0x9e << 16)
-#define CS4245_SPI_WRITE	(0 << 16)
+#define CS4245_SPI_ADDRESS	0x9e
+#define CS4245_SPI_WRITE	0
+#define CS4245_SPI_READ		1
-- 
1.7.10.4
