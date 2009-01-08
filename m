From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 0/2] ASoC: MioA701 board
Date: Thu,  8 Jan 2009 19:42:24 +0100
Message-ID: <1231440146-6669-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by alsa0.perex.cz (Postfix) with ESMTP id AB9AB24156
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 19:42:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

Hi,

These 2 patches have been already reviewed in April 2008 and have been siting in
Mark's asoc-v2 tree since then. They have been ported back to asoc-v1 for
mainline submission.

Please consider them for review if need be and scheduling for the next queue.

The serie was build upon Takashi's topic/asoc branch, commit "ASoC: Clean up
kerneldoc warnings" of id ac11a2b35cc25c77d28218aaf60e7f7c6c7ee5d3.

Cheers.

--
Robert

Robert Jarzmik (2):
  Add initial support of Mitac mioa701 device SoC.
  Add initial support of Mitac mioa701 master volume.

 sound/soc/pxa/Kconfig              |    9 +
 sound/soc/pxa/Makefile             |    2 +
 sound/soc/pxa/mioa701_masterctrl.c |  243 +++++++++++++++
 sound/soc/pxa/mioa701_wm9713.c     |  578 ++++++++++++++++++++++++++++++++++++
 4 files changed, 832 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/pxa/mioa701_masterctrl.c
 create mode 100644 sound/soc/pxa/mioa701_wm9713.c
