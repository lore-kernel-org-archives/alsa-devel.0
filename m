From: Nitin PAI <nitinmpai@gmail.com>
Subject: Re: ASOC - Codecs : Renaming of spdif_tranceiver.c
Date: Wed, 7 Mar 2012 21:58:56 +0530
Message-ID: <CAJDSjBhUvJTM5XXxpU3W0nc2PAWGpZ0ScSCWgr=WhNTGM075fA@mail.gmail.com>
References: <CAJDSjBikNPj_EExz_XojUOT0c4ip8MG3kEf+dzbcW1s_73SbeA@mail.gmail.com>
	<20120307134310.GK3107@opensource.wolfsonmicro.com>
	<CAJDSjBhYdsxh+=LEfatCLrydSDm_KLCVqfptBkOBStNpZJgS4A@mail.gmail.com>
	<20120307142447.GM3107@opensource.wolfsonmicro.com>
	<CAJDSjBhXpViZ=RDEvuQXjmrWGqtJK6v7ds=z4Lwd4UPUbH04DA@mail.gmail.com>
	<20120307153944.GO3107@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 61CF0244FB
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 17:29:04 +0100 (CET)
Received: by iakh37 with SMTP id h37so9405969iak.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 08:28:57 -0800 (PST)
In-Reply-To: <20120307153944.GO3107@opensource.wolfsonmicro.com>
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

>You can add debugfs information to dump the capabilities and whatnot if
>>that's useful to you...
If the cards are not enumerated all these dont make any sense.

>>You'd still need to do things like set up the clocking even
>>for the SoC loopback case, everything is going to need to agree on where
>>the clocks come from and how they flow.
Clocks need not come from the codec, it can come from on of the other
masters in the system.

>>Honestly it just sounds like you want to write some machine drivers for
>>your systems.
Yes, thats the purpose, but I want to ship them to for the reasons I
mentioned above.
Since the enumeration of the machine driver depends on the linkage with the
codec driver its not possible for me to write.
I wish that the spdif_tranceiver was written for more generalized cases and
not just spdif.

Thanks,
--Nitin
