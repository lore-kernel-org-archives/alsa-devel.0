From: <jiada_wang@mentor.com>
Subject: [PATCH v2 0/2] fix race condition in
	rsnd_ssi_pointer_update
Date: Thu, 7 Dec 2017 22:15:37 -0800
Message-ID: <1512713739-15838-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B685267B87
 for <alsa-devel@alsa-project.org>; Fri,  8 Dec 2017 07:15:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com
Cc: Jiada Wang <jiada_wang@mentor.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Jiada Wang <jiada_wang@mentor.com>

This patch set aims to fix the race condition in rsnd_ssi_pointer_update,
between set of byte_pos and wrap it around when new buffer starts.
 
Jiada Wang (2):
  ASoC: rsnd: ssi: fix race condition in rsnd_ssi_pointer_update
  ASoC: rsnd: ssi: remove unnesessary period_pos

Changes for v2:
 * Updated commit message

 sound/soc/sh/rcar/ssi.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

-- 
1.7.9.5
