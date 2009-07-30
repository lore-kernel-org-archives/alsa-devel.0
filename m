From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 14/20] OMAP: McBSP: Disable all wakeups upon
	exit
Date: Thu, 30 Jul 2009 15:49:37 +0300
Message-ID: <1248958183-15015-15-git-send-email-eduardo.valentin__10299.502607859$1248959118$gmane$org@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-11-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-13-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-14-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1248958183-15015-14-git-send-email-eduardo.valentin@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

Quite a few wakeups were left on while the McBSP
was being closed. This patch leaves no single wakeup
enabled.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Acked-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index cb4a455..3c6b98e 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -430,7 +430,6 @@ EXPORT_SYMBOL(omap_mcbsp_request);
 void omap_mcbsp_free(unsigned int id)
 {
 	struct omap_mcbsp *mcbsp;
-	u16 wakeupen;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
@@ -452,9 +451,7 @@ void omap_mcbsp_free(unsigned int id)
 		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
 		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
 
-		wakeupen = OMAP_MCBSP_READ(mcbsp->io_base, WAKEUPEN);
-		wakeupen &= ~WAKEUPEN_ALL;
-		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, wakeupen);
+		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, 0);
 	}
 #endif
 
-- 
1.6.2.GIT

