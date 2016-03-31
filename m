From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH 0/4] ASoC: sti: tdm mode
Date: Thu, 31 Mar 2016 18:00:54 +0200
Message-ID: <1459440058-12234-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id D5866261ACD
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 18:01:14 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

This patchset enables tdm mode for ASoC sti.

Moise Gergaud (4):
  ASoC: sti: correct typo errors
  ASoC: sti: tdm: uni tdm mode
  ASoC: sti: select player for I2S/TDM TX bus
  Documentation: sti-asoc-card: update tdm mode

 .../devicetree/bindings/sound/st,sti-asoc-card.txt |  48 ++++-
 sound/soc/sti/sti_uniperif.c                       | 144 ++++++++++++-
 sound/soc/sti/uniperif.h                           | 220 ++++++++++++++++++--
 sound/soc/sti/uniperif_player.c                    | 182 +++++++++++-----
 sound/soc/sti/uniperif_reader.c                    | 229 +++++++++++++++------
 5 files changed, 687 insertions(+), 136 deletions(-)

-- 
1.9.1
