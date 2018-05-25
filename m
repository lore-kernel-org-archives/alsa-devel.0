From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 6/8] slimbus: qcom: remove redundant depends
	in Kconfig
Date: Fri, 25 May 2018 15:36:16 +0100
Message-ID: <20180525143618.820-7-srinivas.kandagatla@linaro.org>
References: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
 [209.85.128.196])
 by alsa0.perex.cz (Postfix) with ESMTP id E739E267687
 for <alsa-devel@alsa-project.org>; Fri, 25 May 2018 16:38:28 +0200 (CEST)
Received: by mail-wr0-f196.google.com with SMTP id x9-v6so9646315wrl.13
 for <alsa-devel@alsa-project.org>; Fri, 25 May 2018 07:38:28 -0700 (PDT)
In-Reply-To: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

QCOM SLIMBus controller is already under a 'if SLIMBUS' in Kconfig,
having depends on SLIMBUS is totally redundant. Just remove it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
index 1a632fad597e..bfb78d9a6583 100644
--- a/drivers/slimbus/Kconfig
+++ b/drivers/slimbus/Kconfig
@@ -15,7 +15,6 @@ if SLIMBUS
 # SLIMbus controllers
 config SLIM_QCOM_CTRL
 	tristate "Qualcomm SLIMbus Manager Component"
-	depends on SLIMBUS
 	depends on HAS_IOMEM
 	help
 	  Select driver if Qualcomm's SLIMbus Manager Component is
-- 
2.16.2
