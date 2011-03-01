From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: [PATCH v21 0/3] ASoC/MFD/V4L2: WL1273 FM Radio Driver
Date: Tue,  1 Mar 2011 10:00:47 +0200
Message-ID: <1298966450-31814-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CB232472C
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 09:01:14 +0100 (CET)
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

Hi.

And thanks for the comment.

Samuel wrote:
>> Remove two unnecessary calls to i2c_set_clientdata.
>Provided that you add a changelog relevant to the patch itself, and not to the
>v1->v2 diff:

Replaced the incremental changelog stuff with the original descriptions.

>Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Matti

Matti J. Aaltonen (3):
  MFD: WL1273 FM Radio: MFD driver for the FM radio.
  V4L2: WL1273 FM Radio: TI WL1273 FM radio driver
  ASoC: WL1273 FM radio: Access I2C IO functions through pointers.

 drivers/media/radio/radio-wl1273.c |  360 +++++++++++-------------------------
 drivers/mfd/Kconfig                |    2 +-
 drivers/mfd/wl1273-core.c          |  149 +++++++++++++++-
 include/linux/mfd/wl1273-core.h    |    2 +
 sound/soc/codecs/Kconfig           |    2 +-
 sound/soc/codecs/wl1273.c          |   11 +-
 6 files changed, 264 insertions(+), 262 deletions(-)
