From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v3 0/2] ASoC: simple-card: Add multi-CODEC
	support
Date: Tue, 4 Nov 2014 11:25:05 +0100
Message-ID: <cover.1415096705.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A8272605D7
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 11:29:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, Xiubo Li <Li.Xiubo@freescale.com>, Benoit Cousson <bcousson@baylibre.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch set adds multi-CODEC support to the simple card.

v3: rebase on broonie git 2014/11/03
v2: accept list of CODECs in 'sound-dais' (Benoit Cousson)

Jean-Francois Moine (2):
  ASoC: core: add multi-codec support in DT
  ASoC: simple-card: add multi-CODECs in DT

 .../devicetree/bindings/sound/simple-card.txt      |  28 ++---
 include/sound/soc.h                                |   3 +
 sound/soc/generic/simple-card.c                    | 135 +++++++++++++--------
 sound/soc/soc-core.c                               |  75 +++++++++---
 4 files changed, 157 insertions(+), 84 deletions(-)

-- 
2.1.1
