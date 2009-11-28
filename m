From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ALSA: ASoc: Add regulator support to
	CS4270 codec driver
Date: Sat, 28 Nov 2009 16:18:05 -0600
Message-ID: <4B11A19D.4070301@freescale.com>
References: <1259159787-21876-1-git-send-email-daniel@caiaq.de>
	<20091125150139.GC636@rakim.wolfsonmicro.main>
	<20091125152052.GM29442@buzzloop.caiaq.de>
	<20091125153804.GA12750@rakim.wolfsonmicro.main>
	<20091126154807.GI14091@buzzloop.caiaq.de>
	<20091126160351.GB10674@rakim.wolfsonmicro.main>
	<20091126174245.GJ14091@buzzloop.caiaq.de>
	<20091127112550.GA29821@rakim.wolfsonmicro.main>
	<20091127124139.GR14091@buzzloop.caiaq.de>
	<20091127133225.GB17711@rakim.wolfsonmicro.main>
	<4B1186B8.6070606@freescale.com>
	(sfid-20091128_202336_242342_24B1ED43)
	<C78B2A7F-3D02-406C-A87B-8C3231456726@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 46E511037F2
	for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2009 23:18:09 +0100 (CET)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nASMI7qS012678
	for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2009 15:18:07 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nASMMTL5021042
	for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2009 16:22:29 -0600 (CST)
In-Reply-To: <C78B2A7F-3D02-406C-A87B-8C3231456726@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> The regulator header file handles that -it provides stub versions of the
> core consumer API calls to save all the drivers having to have
> conditional code in them.

Ok, that works for me.

However, when I tried to apply the patch to the for-2.6.33 branch of 
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git, it fails:

$ patch -p 1 < "/home/b04825/.mozilla/seamonkey/fl00b35q.default/Mail/Local 
Folders/patches"
patching file sound/soc/codecs/cs4270.c
Hunk #5 FAILED at 651.
Hunk #6 succeeded at 673 (offset -7 lines).
Hunk #8 succeeded at 779 (offset -7 lines).
Hunk #9 succeeded at 895 (offset -16 lines).
1 out of 9 hunks FAILED -- saving rejects to file sound/soc/codecs/cs4270.c.rej

I'm on vacation until the end of the year, so I can't test this driver 
thoroughly, but I'd like to make sure it at least compiles and boots before I 
ack it.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
