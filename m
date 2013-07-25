From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH 0/4] ASoc: kirkwood: extend the kirkwood audio subsystem for
 DT usage
Date: Thu, 25 Jul 2013 11:12:32 +0200
Message-ID: <20130725111232.08736072@armhf>
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
module, and, the removal of the kirkwood-pcm-audio device.
This involves changes in the openrd and t5325 drivers, as in the common
Kirkwood machine initialization. These last changes have not been teste=
d.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
