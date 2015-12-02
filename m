From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH 0/3] ASoC: sti: correction for HBRA support
Date: Wed, 2 Dec 2015 15:22:03 +0100
Message-ID: <1449066126-19431-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D6B3C261A06
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 15:22:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arnaud.pouliquen@st.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.de, rmk+kernel@arm.linux.org.uk
Cc: Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

This patchset is V2 of "[PATCH 2/2] ASoC: sti: correction for HBRA support"

Moise Gergaud (3):
  ALSA: pcm: add IEC958 channel status update
  ASoC: sti: use pcm iec958 channel status helper
  ASoC: sti: correction for HBRA (High Bit Rate Audio) support

 include/sound/pcm_iec958.h      | 19 ++++++++-
 sound/core/pcm_iec958.c         | 78 +++++++++++++++++++++++++------------
 sound/soc/sti/Kconfig           |  1 +
 sound/soc/sti/uniperif_player.c | 86 +++++++++++++++++------------------------
 4 files changed, 107 insertions(+), 77 deletions(-)

-- 
1.9.1
