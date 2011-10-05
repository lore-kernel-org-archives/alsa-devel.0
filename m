From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH 16/16] sound: aaci: Enable module alias autogeneration for
	AMBA drivers
Date: Wed,  5 Oct 2011 17:05:07 +0100
Message-ID: <1317830707-17517-17-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, =?UTF-8?q?Pawe=C5=82=20Moll?= <Pawel.Moll@arm.com>, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 sound/arm/aaci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index e518d38..b37b702a 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -1097,6 +1097,8 @@ static struct amba_id aaci_ids[] = {
 	{ 0, 0 },
 };
 
+MODULE_DEVICE_TABLE(amba, aaci_ids);
+
 static struct amba_driver aaci_driver = {
 	.drv		= {
 		.name	= DRIVER_NAME,
-- 
1.7.4.1
