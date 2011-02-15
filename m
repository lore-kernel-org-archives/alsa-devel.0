From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: [PATCH v19 0/3] TI Wl1273 FM radio driver.
Date: Tue, 15 Feb 2011 10:13:43 +0200
Message-ID: <1297757626-3281-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id C1BB9103844
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 09:15:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, mchehab@redhat.com, hverkuil@xs4all.nl, sameo@linux.intel.com, linux-media@vger.kernel.org
Cc: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
List-Id: alsa-devel@alsa-project.org

Hello.

Now I've refactored the code so that the I2C I/O functions are in the 
MFD core. Also now the codec can be compiled without compiling the V4L2
driver.

I haven't implemented the audio routing (yet), but I've added a TODO
comment about it in the codec file.

Cheers,
Matti

Matti J. Aaltonen (3):
  MFD: WL1273 FM Radio: MFD driver for the FM radio.
  V4L2: WL1273 FM Radio: TI WL1273 FM radio driver
  ASoC: WL1273 FM radio: Access I2C IO functions through pointers.

 drivers/media/radio/Kconfig        |   16 +
 drivers/media/radio/Makefile       |    1 +
 drivers/media/radio/radio-wl1273.c | 2183 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig                |   10 +
 drivers/mfd/Makefile               |    1 +
 drivers/mfd/wl1273-core.c          |  295 +++++
 include/linux/mfd/wl1273-core.h    |  291 +++++
 sound/soc/codecs/Kconfig           |    2 +-
 sound/soc/codecs/wl1273.c          |   38 +-
 sound/soc/codecs/wl1273.h          |   71 --
 10 files changed, 2817 insertions(+), 91 deletions(-)
 create mode 100644 drivers/media/radio/radio-wl1273.c
 create mode 100644 drivers/mfd/wl1273-core.c
 create mode 100644 include/linux/mfd/wl1273-core.h
