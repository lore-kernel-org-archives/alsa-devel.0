From: Paul Davis <pbd@op.net>
Subject: how to detect big/little endian in a driver module?
Date: Tue, 30 Apr 2002 21:13:35 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205010113.g411DZ913510@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id DAA17191
	for <alsa-devel@alsa-project.org>; Wed, 1 May 2002 03:12:39 +0200
Received: from op.net (maxtnt01-sdf-504.fast.net [209.92.61.250])
	by post2.fast.net (8.11.2/8.9.3) with ESMTP id g411CTH12949
	for <alsa-devel@alsa-project.org>; Tue, 30 Apr 2002 21:12:33 -0400 (EDT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

whats the preferred macro/method for discovering if we are on
a big or little-endian system from within driver code?

there are some details of the Hammerfall-DSP that need to be done
differently depending on which system we're on, and using a single
architecture type (__powerpc__ etc.) isn't right.

--p
