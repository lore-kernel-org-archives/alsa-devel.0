From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ASoC: Fix Panda board support
Date: Mon, 21 Nov 2011 15:14:04 +0200
Message-ID: <1321881246-24163-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog109.obsmtp.com (na3sys009aog109.obsmtp.com
	[74.125.149.201])
	by alsa0.perex.cz (Postfix) with ESMTP id B140C2413A
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 14:14:39 +0100 (CET)
Received: by mail-fx0-f51.google.com with SMTP id a20so6083271faa.10
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 05:14:37 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello,

The following two patch fixes the audio support for Panda board. The sdp4430
machine driver suppose to handle sdp4430/panda board, but for some reason
the machine_is check was excluding the Panda board.

It would be nice if this can be integrated to 3.2.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: sdp4430: No need to announce the loading of the driver
  ASoC: sdp4430: Fix Panda support

 sound/soc/omap/sdp4430.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

-- 
1.7.8.rc3
