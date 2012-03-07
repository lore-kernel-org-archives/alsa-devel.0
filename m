From: Nitin PAI <nitinmpai@gmail.com>
Subject: Re: ASOC - Codecs : Renaming of spdif_tranceiver.c
Date: Wed, 7 Mar 2012 20:48:09 +0530
Message-ID: <CAJDSjBhXpViZ=RDEvuQXjmrWGqtJK6v7ds=z4Lwd4UPUbH04DA@mail.gmail.com>
References: <CAJDSjBikNPj_EExz_XojUOT0c4ip8MG3kEf+dzbcW1s_73SbeA@mail.gmail.com>
	<20120307134310.GK3107@opensource.wolfsonmicro.com>
	<CAJDSjBhYdsxh+=LEfatCLrydSDm_KLCVqfptBkOBStNpZJgS4A@mail.gmail.com>
	<20120307142447.GM3107@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C8B31040E1
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 16:18:11 +0100 (CET)
Received: by yenl1 with SMTP id l1so3049545yen.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 07:18:09 -0800 (PST)
In-Reply-To: <20120307142447.GM3107@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, swarren@nvidia.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

>>Even with automotive there's *some* power limits and obviously the power
>>control also includes things like syncing startup of the algorithms with
>>the data path
I dont think that needs to be absolutely done as a part of kernel layer.

>>Well, yes.  Unless someone writes a card driver the CPU driver won't do
>>anything useful but then without the card driver you've no idea how the
>>system is actually wired up and the chances of it doing anything useful
>>are close to zero.  There's no getting out of the machine driver.
This is the point. Why write a card driver? For example audio over MOST or
for HDMI audio?
Or when I have some utility in userspace to test the functionality.
Wont it be better to atleast enumerate the driver and show the capabilities
it supports?
This can help in many phases of design like emulation, bringup (doing
loopback between 2 interfaces at SOC level)?

So far I have been using ALSA for the userspace utilites it supports
(alsalib), for codec support I dont feel need that
its absolutely needed (spdif/hdmi for instance) and this can be applied to
even other machine drivers.

Cant we have support for all this, if not codec, somewhere else?

Thanks,
Nitin
