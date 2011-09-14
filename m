From: Mike Crowe <drmikecrowe@gmail.com>
Subject: Re: OSS emulation and hardware configuration
Date: Wed, 14 Sep 2011 11:20:41 -0400
Message-ID: <CA+jNppnG5UbUOuxqDc-kmR5-pO1n7BX4922d109XV66jXyR-Jg@mail.gmail.com>
References: <CA+jNppn4QPrNb_Jg00En1WZ0Gp97fJzfrFC9DCY2Qa6u004ymg@mail.gmail.com>
	<4E70C260.3040001@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f177.google.com (mail-gx0-f177.google.com
	[209.85.161.177])
	by alsa0.perex.cz (Postfix) with ESMTP id CCC6024396
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 17:21:04 +0200 (CEST)
Received: by gxk23 with SMTP id 23so2267984gxk.22
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2011 08:21:03 -0700 (PDT)
Received: by yie16 with SMTP id 16so1212374yie.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2011 08:21:01 -0700 (PDT)
In-Reply-To: <4E70C260.3040001@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> Does the changing of the rate actually succeed?
>

Surprisingly, that's hard to answer.  Normally, most of our audio is
at 48K (we control the sound files), so the device stays at that rate.
 However, a new library we added (for voip communications) is
hard-coded to 8K sample rate via OSS, and I'm now trying to work out
dual usage by our ALSA code and this library's OSS interface.

Before I added these kernel printouts, I was convinced the system was
switching rates properly (because I added 8K rate support to the
hardware driver to get the voip library working).  However, my current
debug load shows the rate changing in the pcm_oss module, but I never
see that rate hit the hardware the way I expected.

If it isn't hitting the hardware, I suppose it could be up/down
converted by ALSA, but I don't have any plugins installed.  I thought
I needed a plugin for ALSA to convert between the two rates, right?

Thanks!
Mike
