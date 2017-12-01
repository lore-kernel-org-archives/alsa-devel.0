From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/2] dt-bindings: trivial: add tfa9879 device
Date: Fri,  1 Dec 2017 23:44:24 +0100
Message-ID: <20171201224425.5477-2-peda@axentia.se>
References: <20171201224425.5477-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0116.outbound.protection.outlook.com [104.47.2.116])
 by alsa0.perex.cz (Postfix) with ESMTP id 27545267D4B
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 23:44:42 +0100 (CET)
In-Reply-To: <20171201224425.5477-1-peda@axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Add record for NXP TFA9879 Mono BTL Class D audio amplifier.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/trivial-devices.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index af284fbd4d23..4cf30ce4e71f 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -157,6 +157,7 @@ nxp,pcf2127		Real-time clock
 nxp,pcf2129		Real-time clock
 nxp,pcf8563		Real-time clock/calendar
 nxp,pcf85063		Tiny Real-Time Clock
+nxp,tfa9879		Mono BTL Class D audio amplifier
 oki,ml86v7667		OKI ML86V7667 video decoder
 ovti,ov5642		OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI and Embedded TrueFocus
 pericom,pt7c4338	Real-time Clock Module
-- 
2.11.0
