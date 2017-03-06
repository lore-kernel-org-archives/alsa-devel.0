From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 1/3] dt-bindings: add vendor prefix for Dioo
Date: Mon,  6 Mar 2017 18:44:49 +0100
Message-ID: <20170306174451.24406-2-jbrunet@baylibre.com>
References: <20170306174451.24406-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 21B4D2669AD
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 18:45:01 +0100 (CET)
Received: by mail-wm0-f51.google.com with SMTP id v186so70307782wmd.0
 for <alsa-devel@alsa-project.org>; Mon, 06 Mar 2017 09:45:01 -0800 (PST)
In-Reply-To: <20170306174451.24406-1-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Dioo (http://http://www.dioo.com) design and produce power analog and
mixed signal IC.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ec0bfb9bbebd..bb0edca6ec05 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -79,6 +79,7 @@ denx	Denx Software Engineering
 devantech	Devantech, Ltd.
 digi	Digi International Inc.
 digilent	Diglent, Inc.
+dioo	Dioo Microcircuit Co., Ltd
 dlg	Dialog Semiconductor
 dlink	D-Link Corporation
 dmo	Data Modul AG
-- 
2.9.3
