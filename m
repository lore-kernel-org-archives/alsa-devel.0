From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH v2 0/3] Add Jack support for
Date: Mon, 6 Dec 2010 18:02:15 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCB3@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 887DB103962
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 01:02:19 +0100 (CET)
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

v2:
Include codec patch in the series

Jorge Eduardo Candelaria (3):
  ASoC: sdp4430: Enable FM stereo pins
  ASoC: sdp4430: Add Jack support
  ASoC: twl6040: Add jack support for headset and handset

 sound/soc/codecs/twl6040.c |   26 ++++++++++++++++++++++++++
 sound/soc/codecs/twl6040.h |   12 ++++++++++++
 sound/soc/omap/sdp4430.c   |   39 +++++++++++++++++++++++++++++++++++----
 3 files changed, 73 insertions(+), 4 deletions(-)

Regards,
Margarita
