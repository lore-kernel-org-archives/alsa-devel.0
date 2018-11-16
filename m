From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/4] bindings: sound: davinci-mcasp: Document dismod optional property
Date: Fri, 16 Nov 2018 15:41:40 +0200
Message-ID: <20181116134141.17396-4-peter.ujfalusi@ti.com>
References: <20181116134141.17396-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181116134141.17396-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, jsarha@ti.com, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The dismod property can be used to specify the drive on level of inactive
TX slots.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/sound/davinci-mcasp-audio.txt        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index 46bc9829c71a..b279b6072bd5 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -30,6 +30,11 @@ Optional properties:
 - ti,hwmods : Must be "mcasp<n>", n is controller instance starting 0
 - tx-num-evt : FIFO levels.
 - rx-num-evt : FIFO levels.
+- dismod : Specify the drive on TX pin during inactive slots
+	0 : 3-state
+	2 : logic low
+	3 : logic high
+	Defaults to 'logic low' when the property is not present
 - sram-size-playback : size of sram to be allocated during playback
 - sram-size-capture  : size of sram to be allocated during capture
 - interrupts : Interrupt numbers for McASP
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
