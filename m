From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: [PATCH v20 0/3] ASoC/MFD/V4L2: WL1273 FM Radio driver
Date: Mon, 28 Feb 2011 13:02:28 +0200
Message-ID: <1298890951-23339-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 124B610381C
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 12:02:59 +0100 (CET)
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

And thanks for the comments. If we now move quickly enough we can
get this thing in before it becomes deprecated...

Samuel wrote:
> for Mauro to take this one you'd have to provide a
> diff against the already existing wl1273-core.

I've made these patches against the existing stuff.

>> + * Copyright (C) 2010 Nokia Corporation
>2011.

Changed.

>> +}
> I'm confused with this one: Isn't WL1273_VOLUME_SET a command ? Also,
> how can reading from it set the volume ?

It cannot... so I've changed it (back) to write.

>> +     i2c_set_clientdata(client, NULL)
>Not needed.

Removed.

>> +err:
>> +     i2c_set_clientdata(client, NULL);
>Ditto.

Ditto.

Cheers,
Matti

Matti J. Aaltonen (3):
  MFD: Wl1273 FM radio core: Add I2C IO functions.
  V4L2: Wl1273 FM Radio: Remove I2C IO functions.
  ASoC: WL1273 FM radio: Access I2C IO functions through pointers.

 drivers/media/radio/radio-wl1273.c |  360 +++++++++++-------------------------
 drivers/mfd/Kconfig                |    2 +-
 drivers/mfd/wl1273-core.c          |  149 +++++++++++++++-
 include/linux/mfd/wl1273-core.h    |    2 +
 sound/soc/codecs/Kconfig           |    2 +-
 sound/soc/codecs/wl1273.c          |   11 +-
 6 files changed, 264 insertions(+), 262 deletions(-)
