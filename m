From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH 0/2] correction of iec958 channel status
	sampling freq setting
Date: Tue, 24 Nov 2015 14:16:34 +0100
Message-ID: <1448370996-30224-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EEC3265DAA
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 14:16:50 +0100 (CET)
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
Cc: Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

patch "ASoC: sti: set iec958 channel status sampling freq" corresponds to the
V2 of "[PATCH 4/4] ASoC: sti: reset iec60958 settings on close"

Moise Gergaud (2):
  ASoC: sti: set iec958 channel status sampling freq
  ASoC: sti: correction for HBRA support

 sound/soc/sti/uniperif_player.c | 73 +++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 29 deletions(-)

-- 
1.9.1
