From: John Rigg <aldev@sound-man.co.uk>
Subject: envy24control can't set sample rate on Delta 1010
Date: Mon, 21 Apr 2008 01:42:06 +0100
Message-ID: <20080421004206.GA3431@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 58EDD2444C
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 02:32:36 +0200 (CEST)
Received: from localhost (78-32-150-178.no-dns-yet.enta.net [78.32.150.178])
	by mail3.uklinux.net (Postfix) with ESMTP id A555C1F61C8
	for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2008 01:32:35 +0100 (BST)
Received: from anon by localhost with local (Exim 4.63)
	(envelope-from <john@sound-man.co.uk>) id 1Jnk6g-0000tn-5j
	for alsa-devel@alsa-project.org; Mon, 21 Apr 2008 01:42:06 +0100
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

envy24control in alsa-tools-1.0.16 cannot set sample rate
on the M-Audio Delta 1010. The Actual Rate window appears to
be functioning correctly, as is the "S/PDIF in" button, but
none of the internal clock sample rate buttons do anything.
Setting the sample rate as a jackd parameter works as normal.

I tried it with 2.6.20 and 2.6.25 kernels. Behaviour was
the same on both. I've made a bug report (0003915).

John
