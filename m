From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/11] ASoC: Consolidate enum controls and DAPM
	MUXs
Date: Sun, 23 Feb 2014 16:10:10 +0100
Message-ID: <1393168221-23018-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-249.synserver.de
 [212.40.185.249])
 by alsa0.perex.cz (Postfix) with ESMTP id E9D01265133
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 16:10:04 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

We currently have 5 nearly identical implementations of enum controls. Two for
normal controls and three for DAPM controls. The only difference between them is
how and if the selected enum item is mapped to a register value.
For normal enums there is a direct mapping of the selected item to the register
value, for value enums there is an additional look-up table that maps the
selected item to a register value. DAPM also as a virtual enum which is not
backed by any hardware register and the enum is solely used to influence DAPM
routing decisions. The different implementations can easily be consolidating by
making a few small changes. The series first introduces two helper functions to
translate between the selected item and the register value. These functions will
do the right thing depending on whether the enum has a direct mapping or is a
value enum. These functions will be used to consolidate enums and value enums as
well as MUXs and value MUXs. The next step is consolidate MUXs and virtual MUXs.
This requires enums that are only used as virtual enums to be marked as such.
This is done the same way as for virtual mixer controls by setting reg to
SND_SOC_NOPM. All users of virtual MUXs are updated accordingly and then virtual
MUXs and MUXs are updated to share the same implementation. The last patch in
the series does cleanup of dapm_set_path_status() on top of all this.

Once this has been merged I'll send a second patch-set replacing and removing
the now deprecated ENUM and MUX macros.

The series depends on topic/dapm, topic/enum, topic/sign, topic/adau1373,
topic/max98090, topic/mc13783, fix/wm8994, topic/wm8995

- Lars

Lars-Peter Clausen (11):
  ASoC: Remove unused 'reg2' field from soc_enum struct
  ASoC: Consolidate enum and value enum controls
  ASoC: dapm: Consolidate MUXs and value MUXs
  ASoC: Add macros for defining virtual enums
  ASoC: adau1373: Use SOC_ENUM_SINGLE_VIRT_DECL()
  ASoC: max98090: Use SOC_ENUM_SINGLE_VIRT_DECL()
  ASoC: mc13783: Use SOC_ENUM_SINGLE_VIRT_DECL()
  ASoC: wm8994: Use SOC_ENUM_SINGLE_VIRT_DECL()
  ASoC: wm8995: Use SOC_ENUM_SINGLE_VIRT_DECL()
  ASoC: dapm: Consolidate MUXs and virtual MUXs
  ASoC: dapm: Break dapm_set_path_status() appart

 include/sound/soc-dapm.h    |  38 +----
 include/sound/soc.h         |  41 +++--
 sound/soc/codecs/adau1373.c |   4 +-
 sound/soc/codecs/max98090.c |   2 +-
 sound/soc/codecs/mc13783.c  |   6 +-
 sound/soc/codecs/wm8994.c   |   3 +-
 sound/soc/codecs/wm8995.c   |   2 +-
 sound/soc/soc-core.c        | 101 ++----------
 sound/soc/soc-dapm.c        | 369 +++++++++-----------------------------------
 9 files changed, 136 insertions(+), 430 deletions(-)

-- 
1.8.0
