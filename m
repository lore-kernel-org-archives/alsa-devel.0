From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 0/5] AD1836 updates part two
Date: Wed, 15 Jun 2011 15:29:18 -0400
Message-ID: <1308166163-22355-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id EA17B103814
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 21:29:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

This replaces the patchset I sent out yesterday.  It mostly syncs the
missing work we had locally with what Lars-Peter did.  I guess we can
omit the "ad1836" -> "ad183x" rename.

Barry Song (1):
  ASoC: AD1836: rename suspend/resume funcs

Mike Frysinger (4):
  ASoC: AD1836: drop unnecessary spi register check
  ASoC: AD1836: fix intermixed tab/space indentation
  ASoC: AD1836: fix codec name
  ASoC: AD1836: clean up comment headers

 sound/soc/codecs/ad1836.c |   78 +++++++++++++++++---------------------------
 sound/soc/codecs/ad1836.h |   21 +++---------
 2 files changed, 36 insertions(+), 63 deletions(-)

-- 
1.7.5.3
