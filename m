From: Yoran Brondsema <yoran.brondsema@gmail.com>
Subject: Driver for AK4555 codec
Date: Thu, 29 Jul 2010 09:18:43 +0200
Message-ID: <AANLkTimnYLEe-sK2_DcYQAGqVYd+JnsJaSpRfdKBbeEi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E2499103931
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 09:18:45 +0200 (CEST)
Received: by yxm8 with SMTP id 8so15893yxm.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2010 00:18:45 -0700 (PDT)
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

For a system here at work, we have a simple audio system consisting of an
I2S-bus audio controller embedded in the CPU (an NXP LPC3250) and a AK4555
codec which communicates with the CPU through the I2S-bus and produces (or
captures) analog signals. The codec is extremely simple; it is basically an
A/D & D/A converter and it doesn't support a control interface such as I2C.

There is a driver available for the LPC3250 but none for the AK4555 codec,
so I have to write it myself. I checked the document "Writing an ALSA
Driver" by Takashi Iwai but it seems to focus on full-featured sound cards;
I'm just dealing with a "simple" codec. I checked at the code of the uda1380
in linux/sound/soc/lpc3xxx/lpc3xxx-uda1380.c and it seems to be calling some
functions like platform_device_alloc, platform_set_drvdata,... but I can't
find the documentation of what these functions do.

Can someone give me some pointers to some documentation or some rough idea
of how it needs to be done?

Thank you,
Yoran
