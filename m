From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ASoC: davinci-evm: Remove not needed
	header files
Date: Mon, 2 Feb 2015 14:49:40 +0200
Message-ID: <1422881382-26405-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 286AD2605AA
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 13:49:47 +0100 (CET)
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
Cc: olof@lixom.net, alsa-devel@alsa-project.org, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org

Hi,

Trivial changes to remove headers should not be included in the machine driver.
The first patch was sent as part of the edma header cleanup series in November:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-November/084734.html
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-November/084735.html

The series missed 3.19 and it seams to not going to make it to 3.20 either..
With these header files gone from the davinci-evm I will be able to send my
davinci audio conversion from davinci-pcm to edma-pcm for 3.21.

Mark: is it possible to take these for 3.20 still?

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: davinci-evm: Do not include edma headers
  ASoC: davinci-evm: Do not include davinci-pcm.h and davinci-i2s.h

 sound/soc/davinci/davinci-evm.c | 6 ------
 1 file changed, 6 deletions(-)

-- 
2.2.2
