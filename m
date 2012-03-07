From: Nitin PAI <nitinmpai@gmail.com>
Subject: Re: ASOC - Codecs : Renaming of spdif_tranceiver.c
Date: Wed, 7 Mar 2012 23:28:49 +0530
Message-ID: <CAJDSjBiH7=btSWPX-zh8FLokKGDVVD52ngdiv1fvd7QpkV3ZyA@mail.gmail.com>
References: <CAJDSjBikNPj_EExz_XojUOT0c4ip8MG3kEf+dzbcW1s_73SbeA@mail.gmail.com>
	<20120307134310.GK3107@opensource.wolfsonmicro.com>
	<CAJDSjBhYdsxh+=LEfatCLrydSDm_KLCVqfptBkOBStNpZJgS4A@mail.gmail.com>
	<20120307142447.GM3107@opensource.wolfsonmicro.com>
	<CAJDSjBhXpViZ=RDEvuQXjmrWGqtJK6v7ds=z4Lwd4UPUbH04DA@mail.gmail.com>
	<20120307153944.GO3107@opensource.wolfsonmicro.com>
	<CAJDSjBhUvJTM5XXxpU3W0nc2PAWGpZ0ScSCWgr=WhNTGM075fA@mail.gmail.com>
	<20120307163456.GQ3107@opensource.wolfsonmicro.com>
	<CAJDSjBgM1pFmwS3NZHtv4EdLWN3aof4JJtjmgS+4fUx+jca2uQ@mail.gmail.com>
	<CAJDSjBjMJMBvJrjhwEqU3S+hKMD_E1MU3taJOPoxS+3QSo-r7g@mail.gmail.com>
	<20120307171149.GS3107@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 73A48104101
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 18:58:50 +0100 (CET)
Received: by iakh37 with SMTP id h37so9507431iak.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 09:58:49 -0800 (PST)
In-Reply-To: <20120307171149.GS3107@opensource.wolfsonmicro.com>
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

>>Perhaps your BSP is doing things differently to mainline here; it's
>>vanishingly rare in mainline for machine drivers to enforce any limits
>>themselves.  Usually the CODEC and SoC drivers do this.
I meant the SoC drivers can still enforce these limits, and need not rely
on CODEC driver.

--Nitin
