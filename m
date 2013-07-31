From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v3 0/4] ASoc: kirkwood: extend the kirkwood audio subsystem
 for DT usage
Date: Wed, 31 Jul 2013 08:17:11 +0200
Message-ID: <20130731081711.417af22f@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch series adds DT support to the kirkwood audio subsystem.

It cancels the previous patch requests:
- ARM: kirkwood: enable S/PDIF
- ARM: kirkwood: extend the kirkwood i2s driver for DT usage
- ARM: kirkwood: extend the kirkwood pcm/dma driver for DT usage

It also contains the merge of kirkwood-i2c and kirkwood-dma into one
module, with the removal of the kirkwood-pcm-audio device.
This involves changes in the openrd and t5325 drivers, and also in the
common Kirkwood machine initialization. These last changes have not
been tested.

History
v3
	- change the DT name from "kirkwood-i2s" to "mvebu-pcm-audio"
	- apply to linux-next
	- let NULL as the internal i2s clock for compatibility
	- change i2s external clock name to "extclk" instead of "external"
	- cancel previous patch 1/4. Russell's patch
		http://mailman.alsa-project.org/pipermail/alsa-devel/2013-July/064508=
=2Ehtml
	  should be applied instead.
v2
	- fix compilation errors

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
