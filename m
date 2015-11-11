From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v2 0/2] ASoC: Add support for DA7217 and DA7218
	audio codecs
Date: Wed, 11 Nov 2015 15:40:18 +0000
Message-ID: <cover.1447254553.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.166])
 by alsa0.perex.cz (Postfix) with ESMTP id 23A7F26049B
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 16:40:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch set adds DT and ASoC codec driver support for DA7217 and DA7218.

Changes are based against v4.3 kernel version.

Changes in v2:
 - Removed Internal LDO voltage selection from DT
 - BiQuad filter coefficients removed from DT, no programmed using mixer
   controls.
 - ALC calibration no longer bypasses regmap cache and instead saves & restores
   registers around procedure, to avoid issues with concurrent regmap access.
 - Removed all unnecessary default settings for mixers in probe.
 - Reporting of mic level detection event to user-space, through input
   VOICECOMMAND key event, removed as not intended for this purpose. Alternative
   solution required as follow up. Event masked off until solution in place.
 - Additional error checking & loggin around mclk usage, in sysclk and
   bias_level functions.

Adam Thomson (2):
  ASoC: da7218: Add bindings documentation for DA7218 audio codec
  ASoC: codecs: Add da7218 codec driver

 Documentation/devicetree/bindings/sound/da7218.txt |  106 +
 include/sound/da7218.h                             |  109 +
 sound/soc/codecs/da7218.c                          | 3305 ++++++++++++++++++++
 sound/soc/codecs/da7218.h                          | 1415 +++++++++
 4 files changed, 4935 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/da7218.txt
 create mode 100644 include/sound/da7218.h
 create mode 100644 sound/soc/codecs/da7218.c
 create mode 100644 sound/soc/codecs/da7218.h

--
1.9.3
