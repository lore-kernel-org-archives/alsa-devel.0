From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH] ASoC: ts3a227e: fix a typo in documentation
Date: Thu,  4 Oct 2018 18:43:01 +0800
Message-ID: <20181004104301.48121-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk1-f201.google.com (mail-vk1-f201.google.com
 [209.85.221.201])
 by alsa0.perex.cz (Postfix) with ESMTP id C747A2676A7
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 12:43:31 +0200 (CEST)
Received: by mail-vk1-f201.google.com with SMTP id y83-v6so1799350vky.6
 for <alsa-devel@alsa-project.org>; Thu, 04 Oct 2018 03:43:31 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tzungbi@google.com, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

There is no "MACBIAS".  It should be "MICBIAS".

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 Documentation/devicetree/bindings/sound/ts3a227e.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/ts3a227e.txt b/Documentation/devicetree/bindings/sound/ts3a227e.txt
index 3ed8359144d3..21ab45bc7e8f 100644
--- a/Documentation/devicetree/bindings/sound/ts3a227e.txt
+++ b/Documentation/devicetree/bindings/sound/ts3a227e.txt
@@ -14,7 +14,7 @@ Required properties:
 
 Optional properies:
  - ti,micbias:   Intended MICBIAS voltage (datasheet section 9.6.7).
-      Select 0/1/2/3/4/5/6/7 to specify MACBIAS voltage
+      Select 0/1/2/3/4/5/6/7 to specify MICBIAS voltage
       2.1V/2.2V/2.3V/2.4V/2.5V/2.6V/2.7V/2.8V
       Default value is "1" (2.2V).
 
-- 
2.19.0.605.g01d371f741-goog
