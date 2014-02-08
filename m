From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v3 0/4] off-codec widgets
Date: Sat, 8 Feb 2014 15:59:51 +0800
Message-ID: <1391846395-10193-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DA99260307
 for <alsa-devel@alsa-project.org>; Sat,  8 Feb 2014 10:02:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch series has removed the code about tdm slot, and need to do
more study.

This adds "ASoC: binding: add widgets.txt" new patch.

This also revises some others from Mark's comment.


Xiubo Li (4):
  ASoC: add snd_soc_of_parse_audio_simple_widgets for DT
  ASoC: simple-card: add off-codec widgets supports.
  ASoC: binding: add widgets.txt
  ASoC: binding: for new properties documenting and usage

 .../devicetree/bindings/sound/simple-card.txt      | 12 ++-
 .../devicetree/bindings/sound/widgets.txt          | 20 +++++
 include/sound/soc.h                                |  2 +
 sound/soc/generic/simple-card.c                    |  8 ++
 sound/soc/soc-core.c                               | 87 ++++++++++++++++++++++
 5 files changed, 127 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/widgets.txt

-- 
1.8.4
