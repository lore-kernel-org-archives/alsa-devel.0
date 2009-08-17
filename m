From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv4 17/20] ASoC: Add runtime check for RFIG and
	XFIG
Date: Mon, 17 Aug 2009 14:51:16 +0300
Message-ID: <1250509879-6703-18-git-send-email-eduardo.valentin__16658.6112849929$1250510916$gmane$org@nokia.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

This is, no RFIG or XFIG (Not defined in 34xx), correct
initiliazation of rccr and xccr.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 6a837ff..a7b0961 100644
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

