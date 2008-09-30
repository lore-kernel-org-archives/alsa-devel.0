From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 5/5 v1] ASoC Adds DSP DAI format support for
	platform driver
Date: Tue, 30 Sep 2008 15:36:54 +0530
Message-ID: <dfeb90390809300306x60dd476ag5f5adf73b4cc25f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.242])
	by alsa0.perex.cz (Postfix) with ESMTP id C761F2444F
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 12:06:57 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so2441435rvb.32
	for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2008 03:06:56 -0700 (PDT)
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
Cc: felipe.balbi@nokia.com, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Enables DSP DAI format for mcbsp in omap platform driver

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/omap/omap-mcbsp.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 35310e1..fb920e1 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -245,6 +245,11 @@ static int omap_mcbsp_dai_set_dai_fmt(struct
snd_soc_dai *cpu_dai,
 		regs->rcr2	|= RDATDLY(1);
 		regs->xcr2	|= XDATDLY(1);
 		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		/* 0-bit data delay */
+		regs->rcr2      |= RDATDLY(0);
+		regs->xcr2      |= XDATDLY(0);
+		break;
 	default:
 		/* Unsupported data format */
 		return -EINVAL;
-- 
1.5.3.4
