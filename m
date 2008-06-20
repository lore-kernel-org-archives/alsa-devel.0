From: Timur Tabi <timur@freescale.com>
Subject: Requiring the same sample rate for playback and record?
Date: Fri, 20 Jun 2008 14:08:50 -0500
Message-ID: <485C0042.4050008@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id F27D024645
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jun 2008 21:08:53 +0200 (CEST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m5KJ8pF2022609
	for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2008 12:08:51 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m5KJ8oLO011394
	for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2008 14:08:50 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

In my driver, how do I tell ALSA that the sample rate for playback must be the
same as for capture?

I know I can have my driver remember the sample rate for the first stream open,
and then if the second stream doesn't specify the same sample rate, it can
reject it, but this is inelegant.  I'm hoping there's a more straightforward way.

-- 
Timur Tabi
Linux kernel developer at Freescale
