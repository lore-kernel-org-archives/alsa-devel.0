From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: [PATCH v2 0/2] ASoC: dpcm: fix BE dai not hw_free and
	shutdown
Date: Mon, 28 May 2018 10:18:17 +0800
Message-ID: <1527473899-23079-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A2E52673F0
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 04:18:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

These two patch is to solve problem found
in the case of one BE is used by multiple FE.

The error log "ASoC: Unable to apply rate constraint"
will happen when be_substream->runtime is use after free.
Which is due to BE not being hw_free/shutdown correctly.

Also to resolve fe_substream->runtime is not
constrained by BE dai symmetry property.

v2:
    remove flag condition

KaiChieh Chuang (2):
  ASoC: dpcm: fix BE dai not hw_free and shutdown
  ASoC: dpcm: symmetry constraint on FE substream

 sound/soc/soc-pcm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
1.9.1
