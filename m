From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 0/3] Fix some minor issues in simple card driver
Date: Thu, 24 Apr 2014 19:13:57 +0800
Message-ID: <cover.1398337861.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 by alsa0.perex.cz (Postfix) with ESMTP id C22E4264F19
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 13:12:21 +0200 (CEST)
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
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, tiwai@suse.de, lgirdwood@gmail.com, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

The series fixes one name limitation and code style problems.

Nicolin Chen (3):
  ASoC: simple-card: Drop node->name checking
  ASoC: simple-card: Simplify error msg in simple_card_dai_link_of()
  ASoC: simple-card: Improve coding style

 sound/soc/generic/simple-card.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

-- 
1.8.4
