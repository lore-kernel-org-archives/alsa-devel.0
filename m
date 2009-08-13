From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv3 17/20] ASoC: Add runtime check for RFIG and
	XFIG
Date: Thu, 13 Aug 2009 17:35:30 +0300
Message-ID: <1250174133-451-18-git-send-email-eduardo.valentin__18288.5859547698$1250175055$gmane$org@nokia.com>
References: <1250174133-451-1-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-2-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-3-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-4-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-5-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-6-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-7-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-8-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-9-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-10-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-11-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-12-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-13-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-14-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-15-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-16-git-send-email-eduardo.valentin@nokia.com>
	<1250174133-451-17-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1250174133-451-17-git-send-email-eduardo.valentin@nokia.com>
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
Cc: "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

This is, no RFIG or XFIG (Not defined in 34xx), correct
initiliazation of rccr and xccr.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index a5d46a7..8f361b1 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -321,8 +321,11 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	/* Generic McBSP register settings */
 	regs->spcr2	|= XINTM(3) | FREE;
 	regs->spcr1	|= RINTM(3);
-	regs->rcr2	|= RFIG;
-	regs->xcr2	|= XFIG;
+	/* RFIG and XFIG are not defined in 34xx */
+	if (!cpu_is_omap34xx()) {
+		regs->rcr2	|= RFIG;
+		regs->xcr2	|= XFIG;
+	}
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 		regs->xccr = DXENDLY(1) | XDMAEN;
 		regs->rccr = RFULL_CYCLE | RDMAEN;
-- 
1.6.2.GIT

