From: Timur Tabi <timur@freescale.com>
Subject: How can I make sure the period size is a multiple of
	16?
Date: Tue, 04 Sep 2007 17:50:31 -0500
Message-ID: <46DDE137.2070507@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 65AEF103967
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 00:50:35 +0200 (CEST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l84MoW2K028541
	for <alsa-devel@alsa-project.org>; Tue, 4 Sep 2007 15:50:32 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l84MoVaj020851
	for <alsa-devel@alsa-project.org>; Tue, 4 Sep 2007 17:50:32 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

To work around a hardware issue, my ASoC driver requires the period size to be 
a multiple of 16.  What is the best way to ensure that?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
