From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 0/4] ASoC: stm32: sai: add mclk clock provider
Date: Mon, 15 Oct 2018 16:03:32 +0200
Message-ID: <1539612216-12602-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 9DD122677F0
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2018 16:03:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

This patch set allows to use STM32 SAI interface as a master clock provider.
The Cirrus cs42l51 codec patch gives the example of the source code required on codec side,
to use SAI mclk provider.

These patches allow to cover the following use cases:
	- SAI is master or slave and is master clock provider
	- SAI is master or slave and is not master clock provider (another sai provides the mclk clock)

Implementation overview:
- mclk configuration
	SAI is registered in clock framework:
		- either as a mclk provider (optional in DT). SAI generates mclk when requested by DAPM
		- or as a mclk consumer (optional in DT).
	cs42l51 codec is configured as a mclk consumer (optional in DT)

- mclk power
	A DAPM is registered in codec to handle mclk enable/disable (DAPM route is set in soundcard node)

- mclk rate:
	mclk rate is computed at runtime from stream rate and mclk-fs ratio provided in DT
	mclk rate is propagated through sysclk callback to the SAI which is mclk consumer.
	The mclk rate is set exclusively to avoid concurrent rate requests on SAI master.

Regards
Olivier

Olivier Moysan (4):
  ASoC: dt-bindings: add mclk provider support to stm32 sai
  ASoC: dt-bindings: add mclk support to cs42l51
  ASoC: stm32: sai: set sai as mclk clock provider
  ASoC: cs42l51: add mclk support

 .../devicetree/bindings/sound/cs42l51.txt          |  17 ++
 .../devicetree/bindings/sound/st,stm32-sai.txt     |   7 +
 .../devicetree/bindings/trivial-devices.txt        |   1 -
 sound/soc/codecs/cs42l51.c                         |   8 +
 sound/soc/stm/stm32_sai.h                          |   3 +
 sound/soc/stm/stm32_sai_sub.c                      | 275 ++++++++++++++++++---
 6 files changed, 274 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cs42l51.txt

-- 
2.7.4
