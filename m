From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ASoC: davinci-mcasp: Improved
	suspend/resume support
Date: Wed, 1 Oct 2014 16:02:10 +0300
Message-ID: <1412168532-31091-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 95831260485
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 15:02:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

With this series the McASP will continue to work after deep sleep during audio
activity.
Without these changes the ongoing audio will not resume and it will time out,
but streams started after resume were worked correctly.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: davinci-mcasp: Convert the context save/restore to use array
  ASoC: davinvi-mcasp: Proper suspend/resume support while audio is
    active

 sound/soc/davinci/davinci-mcasp.c | 79 ++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 21 deletions(-)

-- 
2.1.0
