From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 0/7] ASoC: sti audio fixes and legacy cleaning
Date: Mon, 24 Oct 2016 16:42:50 +0200
Message-ID: <1477320177-30130-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 417B0266CA1
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 16:43:13 +0200 (CEST)
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
Cc: kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, arnaud.pouliquen@st.com, lgirdwood@gmail.com, broonie@kernel.org, Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

Audio fixes and cleaning of code associated to stih416 platform.

Arnaud Pouliquen (7):
  ASoC: sti: fix errors management
  ASoC: sti: fix channel status update after playback start
  ASoC: sti: reset refactoring
  ASoC: sti: clean unused include
  ASoC: codec: clean legacy in sti-sas
  ASoC: sti: sti-sas: add missing return in messages strings
  ASoc: codec: sti enable fast io for regmap

 sound/soc/codecs/sti-sas.c      | 181 +++++-----------------------------------
 sound/soc/sti/sti_uniperif.c    |  43 ++++++++--
 sound/soc/sti/uniperif.h        |   2 +
 sound/soc/sti/uniperif_player.c |  97 +++++++++------------
 sound/soc/sti/uniperif_reader.c |  41 +++------
 5 files changed, 111 insertions(+), 253 deletions(-)

-- 
1.9.1
