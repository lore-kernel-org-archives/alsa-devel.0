From: andi@lisas.de
Subject: [patch 0/6] sound azt3328: fix bugs,
	improve codec layering, speedup
Date: Mon, 27 Dec 2010 21:16:27 +0100
Message-ID: <20101227201627.GA28432@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 47E14246EC
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2010 21:16:28 +0100 (CET)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This azt3328 PCI sound driver patch series contains
some remaining cleanup, several fixes and some nice improvements.
Tested and checkpatch.pl'ed on 2.6.37-rc6.

Despite improved functionality the compiled binary is now some 300 bytes
smaller (dito for source).

Will be one of the last updates to azt3328, I promise ;)
(I've got some other interesting work for more widespread cards)

Thanks!

Andreas Mohr
