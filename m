From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH,
	RFC 0/3] magician fix and UDA1380 i2c device registration change
Date: Sun, 14 Jun 2009 12:51:28 +0200
Message-ID: <1244976692-5189-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f218.google.com (mail-fx0-f218.google.com
	[209.85.220.218])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C5F7246C2
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Jun 2009 12:51:41 +0200 (CEST)
Received: by fxm18 with SMTP id 18so2976723fxm.32
	for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2009 03:51:41 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Patch 1/3 is a follow-up fix to commit a820532002e70e3a06f1ea7133e9b02443d07382
"ASoC: pxa-ssp.c fix clock/frame invert".

Patch 2/3 removes the I2C board info registration from the UDA1380 driver.
Instead, device instantiation will be done via global i2c_board_info from
board files (patch 3/3). At the same time, platform specific configuration
is moved to platform data. Common power/reset GPIO handling moves into the
codec driver, which will allow to completely power down the codec depending
on ASoC power state in the future.
