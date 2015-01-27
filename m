From: Andrew Jackson <andrew.jackson@arm.com>
Subject: [PATCH PING] ASoC: dwc: Remove unnecessary conditional
	compilation
Date: Tue, 27 Jan 2015 20:38:28 +0000
Message-ID: <1422391108-9011-1-git-send-email-andrew.jackson@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.140])
 by alsa0.perex.cz (Postfix) with ESMTP id 848C7261504
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 21:38:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Andrew Jackson <Andrew.Jackson@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, linux-kernel@vger.kernel.org, Rajeev Kumar <rajeevkumar.linux@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Andrew Jackson <Andrew.Jackson@arm.com>

of_match_ptr is already conditionally compiled based on
CONFIG_OF so further conditional compilation is not
required.  Remove conditional compilation surrounding
of_match_ptr.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 sound/soc/dwc/designware_i2s.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 99cf64b..a3e97b4 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -624,9 +624,7 @@ static struct platform_driver dw_i2s_driver = {
 	.remove		= dw_i2s_remove,
 	.driver		= {
 		.name	= "designware-i2s",
-#ifdef CONFIG_OF
 		.of_match_table = of_match_ptr(dw_i2s_of_match),
-#endif
 	},
 };
 
-- 
1.7.1
