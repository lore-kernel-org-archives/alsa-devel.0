From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v2 0/5] max9867 driver update
Date: Tue, 4 Dec 2018 19:17:25 +0100
Message-ID: <20181204181725.GA1136@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 831F6267B4E
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2018 19:17:32 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23993048AbeLDSRbusT0p (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Tue, 4 Dec 2018 19:17:31 +0100
Content-Disposition: inline
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
Cc: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

this is yet another round of driver update. Tested on AT91SAM9G20
based board with codec in master mode. All implemeted controls do
work now. Comments from previous serie taken into account.

Ladislav Michl (5):
  ASoC: max9867: Remove useless assignment
  ASoC: max9867: Fix power management
  ASoC: max9867: Calculate LRCLK divider
  ASoC: max9867: Fix signal paths
  ASoC: max9867: Add copyright and module author
