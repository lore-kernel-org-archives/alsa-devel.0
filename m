From: Nitin PAI <nitinmpai@gmail.com>
Subject: Re: ASOC - Codecs : Renaming of spdif_tranceiver.c
Date: Wed, 7 Mar 2012 22:23:59 +0530
Message-ID: <CAJDSjBgM1pFmwS3NZHtv4EdLWN3aof4JJtjmgS+4fUx+jca2uQ@mail.gmail.com>
References: <CAJDSjBikNPj_EExz_XojUOT0c4ip8MG3kEf+dzbcW1s_73SbeA@mail.gmail.com>
	<20120307134310.GK3107@opensource.wolfsonmicro.com>
	<CAJDSjBhYdsxh+=LEfatCLrydSDm_KLCVqfptBkOBStNpZJgS4A@mail.gmail.com>
	<20120307142447.GM3107@opensource.wolfsonmicro.com>
	<CAJDSjBhXpViZ=RDEvuQXjmrWGqtJK6v7ds=z4Lwd4UPUbH04DA@mail.gmail.com>
	<20120307153944.GO3107@opensource.wolfsonmicro.com>
	<CAJDSjBhUvJTM5XXxpU3W0nc2PAWGpZ0ScSCWgr=WhNTGM075fA@mail.gmail.com>
	<20120307163456.GQ3107@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C596C24524
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 17:54:01 +0100 (CET)
Received: by iakh37 with SMTP id h37so9435259iak.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 08:53:59 -0800 (PST)
In-Reply-To: <20120307163456.GQ3107@opensource.wolfsonmicro.com>
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

>>Well, just write a CODEC driver that matches what you've got down on
>>your boards.  Usually the driver does need to enforce some kind of
>>limits (on input format and sample rate normally) even for a simple
>>device with no software control otherwise the device can get driven
>>out of spec.
The CODEC is part of the system integration process. From SOC standpoint
the machine driver is what needs to be delivered.
I dont know finally what the final codec will be, its upto the integrator
to write.  May be he can pick the ones from the asoc:codecs list.


I dont like the dependency of the machine driver with the codec driver for
enumeration. Machine driver can self exist without having for the codec
driver. [USB, PCi, HDMI, S/PDIF]  However the vice-versa is not true and is
of no use.  Binding them together will make the usecases easy (power for
instance, user interaction), but should not have been a hardlimit.  Given
the thought process, ALSA should allow dummy_codec drivers which it does
(from spdif_tranceiver.c),  but why not make it completely generic? (remove
the s/pdif keywords).

Thanks for your ideas about the hdmi driver, will check how is that
handling this dependency on codec driver.

--Nitin
