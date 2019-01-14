From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] slimbus: core: match full device id
Date: Mon, 14 Jan 2019 13:44:46 +0000
Message-ID: <20190114134449.15367-2-srinivas.kandagatla@linaro.org>
References: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 03A4C266ABC
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2019 14:45:55 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id n190so8977872wmd.0
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2019 05:45:55 -0800 (PST)
In-Reply-To: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

match full slim device id instead of just product and manufacture code,
this will allow drivers to be much more specific to that device.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 55eda5863a6b..9e4f3b21ba8c 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -21,7 +21,9 @@ static const struct slim_device_id *slim_match(const struct slim_device_id *id,
 {
 	while (id->manf_id != 0 || id->prod_code != 0) {
 		if (id->manf_id == sbdev->e_addr.manf_id &&
-		    id->prod_code == sbdev->e_addr.prod_code)
+		    id->prod_code == sbdev->e_addr.prod_code &&
+		    id->dev_index == sbdev->e_addr.dev_index &&
+		    id->instance == sbdev->e_addr.instance)
 			return id;
 		id++;
 	}
-- 
2.20.1
