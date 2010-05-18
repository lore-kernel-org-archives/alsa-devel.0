From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Subject: [PATCH v2 0/2] Add earphone speaker in OMAP4
Date: Tue, 18 May 2010 12:44:16 -0500
Message-ID: <1274204658-31614-1-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 8277110388B
	for <alsa-devel@alsa-project.org>;
	Tue, 18 May 2010 19:56:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Add support for earphone speaker in SDP4430 board.

Changes from v1:
- Separated changes for codec and machine drivers in two patches.
- Added Acked-by tag to patches.

Jorge Eduardo Candelaria (2):
      ASoC: SDP4430: Add support for Earphone speaker
      ASoC: TWL6040: Enable earphone path in codec

 sound/soc/codecs/twl6040.c |   21 ++++++++++++++++++++-
 sound/soc/omap/sdp4430.c   |    4 ++++
 2 files changed, 24 insertions(+), 1 deletions(-)
