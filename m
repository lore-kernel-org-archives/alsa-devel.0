From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v2 0/4] ASoC: simple-card: DT fix and multi DAI
	links extension
Date: Tue, 11 Mar 2014 11:27:20 +0100
Message-ID: <cover.1394533640.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
 by alsa0.perex.cz (Postfix) with ESMTP id D96BA261696
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 11:40:56 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

This patch series fixes a small problem about node device locks and also
extends the simple card driver to handle many DAI links as this exists
in the Cubox audio subsystem.

- v2
	- change subject/comment about device node reference count
		(Mark Brown)
	- use a null size array instead of an implicit area for the DAI links
		(Li Xiubo)
	- update the reference count of the device node at end of probe

Jean-Francois Moine (4):
  ASoC: simple-card: Fix the reference count of device nodes
  ASoC: simple-card: dynamically allocate the DAI link array
  ASoC: simple-card: accept many DAI links
  ASoC: simple-card: Add DT documentation for multi-DAI links

 .../devicetree/bindings/sound/simple-card.txt      |  34 +++-
 sound/soc/generic/simple-card.c                    | 174 ++++++++++++++-------
 2 files changed, 152 insertions(+), 56 deletions(-)

-- 
1.9.0
