From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH v2 0/7] ASoC: sti: unip tdm mode
Date: Thu, 7 Apr 2016 11:25:29 +0200
Message-ID: <1460021136-27822-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 92CC9264F34
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 11:25:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arnaud.pouliquen@st.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

This patchset is V2 of "ASoC: sti: tdm: uni tdm mode"
V2 consists of splitting the V1 patch into 7 patches.

Moise Gergaud (7):
  ASoC: sti: macro for uniperif tdm regs access
  ASoC: sti: rename unip player type into common player & reader type
  ASoC: sti: define tdm type & default tdm hw config
  ASoC: sti: helper functions for unip tdm slots configuration
  ASoC: sti: helper functions to fix tdm runtime params
  ASoC: sti: unip player tdm mode
  ASoC: sti: unip reader tdm mode

 sound/soc/sti/sti_uniperif.c    | 144 ++++++++++++++++++++++++-
 sound/soc/sti/uniperif.h        | 197 +++++++++++++++++++++++++++++++++-
 sound/soc/sti/uniperif_player.c | 140 +++++++++++++++++-------
 sound/soc/sti/uniperif_reader.c | 229 +++++++++++++++++++++++++++++-----------
 4 files changed, 606 insertions(+), 104 deletions(-)

-- 
1.9.1
