From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv3 03/20] OMAP: McBSP: Use appropriate value for
	startup delay
Date: Thu, 13 Aug 2009 17:35:16 +0300
Message-ID: <1250174133-451-4-git-send-email-eduardo.valentin__8216.42519808865$1250174946$gmane$org@nokia.com>
References: <1250174133-451-1-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-2-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-3-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1250174133-451-3-git-send-email-eduardo.valentin@nokia.com>
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
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 84cc323..2383b08 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -359,7 +359,13 @@ void omap_mcbsp_start(unsigned int id)
 	w = OMAP_MCBSP_READ(io_base, SPCR1);
 	OMAP_MCBSP_WRITE(io_base, SPCR1, w | 1);
 
-	udelay(100);
+	/*
+	 * Worst case: CLKSRG*2 = 8000khz: (1/8000) * 2 * 2 usec
+	 * REVISIT: 100us may give enough time for two CLKSRG, however
+	 * due to some unknown PM related, clock gating etc. reason it
+	 * is now at 500us.
+	 */
+	udelay(500);
 
 	/* Start frame sync */
 	w = OMAP_MCBSP_READ(io_base, SPCR2);
-- 
1.6.2.GIT

