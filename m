From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH 0/1] ASoC: sti: select player for I2S/TDM TX bus
Date: Thu, 14 Apr 2016 15:29:34 +0200
Message-ID: <1460640575-27011-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 71722260870
 for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2016 15:29:45 +0200 (CEST)
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

I forgot to include this patch into "[PATCH v2] ASoC: sti: unip tdm mode" serie
that has been applied.

This patch is the same than the one previously sent in
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/106391.html

Moise Gergaud (1):
  ASoC: sti: select player for I2S/TDM TX bus

 sound/soc/sti/uniperif.h        |  1 +
 sound/soc/sti/uniperif_player.c | 42 +++++++++++++++++++++++++++--------------
 2 files changed, 29 insertions(+), 14 deletions(-)

-- 
1.9.1
