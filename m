From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ASoC: OMAP4+ABE (ubuntu): Might fix
	OpenMax on PandaBoard
Date: Wed, 6 Feb 2013 16:10:07 +0100
Message-ID: <1360163409-25607-1-git-send-email-peter.ujfalusi@ti.com>
References: <CAAo96ZCNBTGBToLbKnvQ1k_eewJcg94KZBRKt7TKkE3T8xqsQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 576DE265243
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2013 16:10:17 +0100 (CET)
In-Reply-To: <CAAo96ZCNBTGBToLbKnvQ1k_eewJcg94KZBRKt7TKkE3T8xqsQw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: brentweatherall@gmail.com
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, michael@amarulasolutions.com, clemens@ladisch.de, s-guiriec@ti.com
List-Id: alsa-devel@alsa-project.org

Hi Brent,

Could you try the following two patch on top of your ubuntu kernel:
git://dev.omapzoom.org/pub/scm/integration/kernel-ubuntu.git ubuntu/ti-ubuntu-3.4-1487

It fixes similar issue on my board when using mplayer with ABE.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: omap-abe-mmap: Make the hwrule function to be more generic
  ASoC: omap-abe-mmap: Place constraint to buffer size as well

 sound/soc/omap/omap-abe-mmap.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
1.8.1.1
