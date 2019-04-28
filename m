From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] sound: USB: line6: use dynamic buffers
Date: Sun, 28 Apr 2019 20:39:17 +0000
Message-ID: <20190428203918.2B415206C1@mail.kernel.org>
References: <20190428160411.GA12815@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 202D1F806E7
 for <alsa-devel@alsa-project.org>; Sun, 28 Apr 2019 22:39:20 +0200 (CEST)
In-Reply-To: <20190428160411.GA12815@kroah.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

Hi,

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v5.0.10, v4.19.37, v4.14.114, v4.9.171, v4.4.179, v3.18.139.

v5.0.10: Build OK!
v4.19.37: Build OK!
v4.14.114: Failed to apply! Possible dependencies:
    a8eaad7b04ea ("ALSA: line6: stop using get_seconds()")

v4.9.171: Failed to apply! Possible dependencies:
    a8eaad7b04ea ("ALSA: line6: stop using get_seconds()")

v4.4.179: Failed to apply! Possible dependencies:
    790869dacc3d ("ALSA: line6: Add support for POD X3")
    97d78acfb870 ("ALSA: line6: Allow different channel numbers for in/out")
    a8eaad7b04ea ("ALSA: line6: stop using get_seconds()")

v3.18.139: Failed to apply! Possible dependencies:
    16d603d32d34 ("staging: line6: Move audio endpoints to properties")
    25a0707cf6bc ("ALSA: line6: Improve line6_read/write_data() interfaces")
    410dca8d99ae ("staging: line6: Define a device type enum")
    4cb1a4ae4afb ("staging: line6: Rename capability macros")
    4d947546c3fb ("staging: line6: Use explicit indexes when defining properties")
    5c3396f909aa ("staging: line6: Remove `device_bit' from properties")
    61864d844c29 ("ALSA: move line6 usb driver into sound/usb")
    790869dacc3d ("ALSA: line6: Add support for POD X3")
    7b3e4d47ca37 ("staging: line6: List out capabilities individually")
    7b9584fa1c0b ("staging: line6: Move altsetting to properties")
    951dd316119c ("staging: line6: Split out POD HD500 interfaces")
    9e165be72f49 ("staging: line6: Move control endpoints to properties")
    ccddbe4a9953 ("ALSA: line6: Split to each driver")
    daf54a59f37c ("staging: line6: Cleanup device table")
    e474e7fd404b ("ALSA: line6: Return EIO if read/write not successful")
    e64e94df9916 ("ALSA: line6: Add delay before reading status")
    f3dfd1be08cc ("ALSA: line6: Return error if device not responding")
    f45be7dcc9e5 ("staging: line6: Remove idVendor and idProduct macros")


How should we proceed with this patch?

--
Thanks,
Sasha
