From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 3/5] [RFC] ALSA ASOC Adds DSP DAI format
	support for platform driver
Date: Mon, 29 Sep 2008 15:20:12 +0530
Message-ID: <dfeb90390809290250x7c9d3aafh232fbcbe8ae77d7e__22340.3270742439$1222682974$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
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
Cc: felipe.balbi@nokia.com, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Enables DSP DAI format for mcbsp in omap platform driver

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/omap/omap-mcbsp.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 3a4cc4b..1c024aa 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -292,6 +292,12 @@ static int omap_mcbsp_dai_set_dai_fmt(struct
snd_soc_dai *cpu_dai,
 		regs->rcr2	|= RDATDLY(1);
 		regs->xcr2	|= XDATDLY(1);
 		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		/* 0-bit data delay */
+		regs->rcr2	|= RDATDLY(0);
+		regs->xcr2	|= XDATDLY(0);
+		break;
+
 	default:
 		/* Unsupported data format */
 		return -EINVAL;
-- 
1.5.3.4
