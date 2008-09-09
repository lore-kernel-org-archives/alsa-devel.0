From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 0/7] HDA patch_via.c update
Date: Tue, 9 Sep 2008 15:37:17 +0800
Message-ID: <20080909073717.GC9638@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F2F3103817
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 10:02:43 +0200 (CEST)
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.63)
	(envelope-from <HaraldWelte@viatech.com>) id 1KcyBO-0007uV-CR
	for alsa-devel@alsa-project.org; Tue, 09 Sep 2008 10:02:42 +0200
Received: from laforge by prithivi.gnumonks.org with local (Exim 4.69)
	(envelope-from <HaraldWelte@viatech.com>) id 1Kcxmn-0004xJ-8v
	for alsa-devel@alsa-project.org; Tue, 09 Sep 2008 15:37:17 +0800
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

Hi!

As part of my work for VIA I have stumbled upon their current internal HDA
codec driver and it's various differences against the current mainline driver.

I have spent the better part of two days separating the individual changesets
out of the big diff between VIA's driver and current mainline linux-2.6 (which
is identical to alsa-kernel.git).

After this merge, I will work with product management and R&D inside VIA that
all individual changesets (bugfixes / enhancements) will be sent ASAP for
mainline inclusion to prevent any large differencees betwee the two trees.

If you have any questions regarding VIA's hardware or need access to data
sheets or the like, I am happy to assist.

-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
============================================================================
VIA Open Source Liaison
