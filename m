From: "Zoltan Devai" <zdevai@gmail.com>
Subject: [RFC] [PATCH 0/2] ASoC sound support for SMDK2440
	boards
Date: Thu, 24 May 2007 16:28:56 +0200
Message-ID: <5b7270f40705240728p4f579269g1ddc8e8db8d59f81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by alsa0.perex.cz (Postfix) with ESMTP id AB2B5243F3
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2007 16:29:46 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so55229ana
	for <alsa-devel@alsa-project.org>; Thu, 24 May 2007 07:28:57 -0700 (PDT)
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

Hi,

The following patches are the first working version of drivers for
the UDA1341 codec and SMDK2440 boards.

Any comments for improvement are welcome.

I also would like to ask for help in the following topics:
- The codec requires an L3-bus driver.
I'm using one made by RMK, but it's not mainline, and probably
needs adoption to the driver model.
(http://lkml.org/lkml/2005/10/28/194)
It could also make more sense to integrate the driver into the
i2c or spi subsystems, or just make it a S3C24xx specific gpio hack.
Any volunteers ?

- I only have access to a SMDK2440 board.
Could someone verify if this would work on other SMDK's as well ?

Regards,
Zoltan
