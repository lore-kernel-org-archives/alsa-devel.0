From: Mike Dunn <mikedunn@newsguy.com>
Subject: [PATCH 0/2] ASoC: palm27x: machine driver fixes and
	updates
Date: Fri, 28 Dec 2012 13:15:58 -0800
Message-ID: <1356729360-14522-1-git-send-email-mikedunn@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.newsguy.com (smtp.newsguy.com [74.209.136.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 791EC2615AE
 for <alsa-devel@alsa-project.org>; Fri, 28 Dec 2012 22:16:00 +0100 (CET)
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
Cc: Marek Vasut <marex@denx.de>, Mike Dunn <mikedunn@newsguy.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi,

A fix and an update to the palm27x machine driver.

Happy New Year!

Mike Dunn (2):
  ASoC: palm27x: fix widgets and routes in dai_link init
  ASoC: palm27x: register card in platform_driver probe

 sound/soc/pxa/palm27x.c |   36 +++++++++---------------------------
 1 files changed, 9 insertions(+), 27 deletions(-)

-- 
1.7.8.6
