From: Mike Dunn <mikedunn@newsguy.com>
Subject: [PATCH v2 0/2] ASoC: palm27x: machine driver fixes and
	updates
Date: Sat, 29 Dec 2012 10:53:16 -0800
Message-ID: <1356807198-14037-1-git-send-email-mikedunn@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.newsguy.com (smtp.newsguy.com [74.209.136.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 17746261637
 for <alsa-devel@alsa-project.org>; Sat, 29 Dec 2012 19:54:29 +0100 (CET)
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

Change log:
  v2:
    Patch #2: in palm27x_asoc_remove(), the call to platform_device_unregister()
    is replaced with snd_soc_unregister_card().

    This version v2 is unsolicited; I noticed the omission today.  Patch
    preparation error; tripping over my own patches.  No new ones for a while!
    Thanks for your patience.

Mike Dunn (2):
  ASoC: palm27x: fix widgets and routes in dai_link init
  ASoC: palm27x: register card in platform_driver probe

 sound/soc/pxa/palm27x.c |   38 ++++++++++----------------------------
 1 files changed, 10 insertions(+), 28 deletions(-)

-- 
1.7.8.6
