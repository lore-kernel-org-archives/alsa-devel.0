From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 1/2] ASoC: add mclk-fs to audio graph card
	binding
Date: Thu, 9 Nov 2017 15:07:57 +0100
Message-ID: <1510236478-2351-2-git-send-email-olivier.moysan@st.com>
References: <1510236478-2351-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 3DFE22677D5
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 15:08:58 +0100 (CET)
In-Reply-To: <1510236478-2351-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Add mclk-fs support to audio graph card
as initially supported in simple card.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 Documentation/devicetree/bindings/sound/audio-graph-card.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
index 6e6720a..d04ea3b 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-card.txt
+++ b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
@@ -17,6 +17,7 @@ Below are same as Simple-Card.
 - bitclock-master
 - bitclock-inversion
 - frame-inversion
+- mclk-fs
 - dai-tdm-slot-num
 - dai-tdm-slot-width
 - clocks / system-clock-frequency
-- 
1.9.1
