From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ASoC: omap: mcbsp: small cleanups for the
	sidetone code
Date: Tue, 28 Feb 2012 10:07:30 +0200
Message-ID: <1330416452-7195-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog124.obsmtp.com (na3sys009aog124.obsmtp.com
	[74.125.149.151])
	by alsa0.perex.cz (Postfix) with ESMTP id E1EF724526
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 09:07:59 +0100 (CET)
Received: by mail-lpp01m010-f45.google.com with SMTP id e6so1407324lah.4
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 00:07:45 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Hello,

to make the code a bit nicer to look at.

This series is on top of the McBSP move changeset:
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-February/049628.html

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: omap: mcbsp: Use uniform st_data pointer initialization
  ASoC: omap: mcbsp: Remove redundant checks for the st_data pointer

 sound/soc/omap/mcbsp.c |   25 +++++++------------------
 1 files changed, 7 insertions(+), 18 deletions(-)

-- 
1.7.8.4
