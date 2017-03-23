From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v2 0/2] ASoC: STI: Fix null ptr deference in
	IRQ handler
Date: Thu, 23 Mar 2017 19:39:53 +0100
Message-ID: <1490294395-13416-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id C894D266AF7
 for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2017 19:40:01 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org

V2:
	- Fix missing sets of reader->substream
	- Add spinlock to protect player/reader->substream access 

Arnaud Pouliquen (2):
  ASoC: STI: Fix reader substream pointer set
  ASoC: STI: Fix null ptr deference in IRQ handler

 sound/soc/sti/uniperif.h        |  1 +
 sound/soc/sti/uniperif_player.c | 34 +++++++++++++++++++++++-----------
 sound/soc/sti/uniperif_reader.c | 27 +++++++++++++++++++++++----
 3 files changed, 47 insertions(+), 15 deletions(-)

-- 
1.9.1
