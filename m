From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 5/8] regulator: arizona: add support for WM8998
	and WM1814
Date: Tue, 21 Apr 2015 13:33:53 +0100
Message-ID: <1429619636-25478-6-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1429619636-25478-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 31EA22661A4
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 14:33:33 +0200 (CEST)
In-Reply-To: <1429619636-25478-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 drivers/regulator/arizona-ldo1.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index a1d07d3..4dc9b18 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -240,6 +240,8 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 	switch (arizona->type) {
 	case WM5102:
 	case WM8997:
+	case WM8998:
+	case WM1814:
 		desc = &arizona_ldo1_hc;
 		ldo1->init_data = arizona_ldo1_dvfs;
 		break;
-- 
1.7.2.5
