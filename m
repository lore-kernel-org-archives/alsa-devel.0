From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH v4 0/3] Add Jack support for
Date: Fri, 10 Dec 2010 20:45:11 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4E225CA@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 007362464D
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 03:45:16 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This patch series adds the support for headset jack detection

v4:
Remove unused structure
Use scheduling work to debounce the jack detection
Add verification for sdp

Jorge Eduardo Candelaria (3):
  ASoC: sdp4430: Enable FM stereo pins
  ASoC: twl6040: Add jack support for headset and handset
  ASoC: sdp4430: Add Jack support

 sound/soc/codecs/twl6040.c |   67 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/twl6040.h |    7 ++++
 sound/soc/omap/sdp4430.c   |   43 +++++++++++++++++++++++++--
 3 files changed, 113 insertions(+), 4 deletions(-)
