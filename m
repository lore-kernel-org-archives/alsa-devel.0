From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 0/2] ASoC: two trivial fixes
Date: Sun, 19 Oct 2014 09:07:34 +0200
Message-ID: <1413702456-8624-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id D203D2604F4
 for <alsa-devel@alsa-project.org>; Sun, 19 Oct 2014 09:07:43 +0200 (CEST)
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
Cc: broonie@kernel.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Just two random fixes spotted by Coverity.

Daniel Mack (2):
  ASoC: soc-compress: consolidate two identical branches
  ASoC: fsl: use strncpy() to prevent copying of over-long names

 sound/soc/fsl/fsl_asrc.c |  2 +-
 sound/soc/fsl/fsl_esai.c |  2 +-
 sound/soc/soc-compress.c | 11 ++---------
 3 files changed, 4 insertions(+), 11 deletions(-)

-- 
2.1.0
