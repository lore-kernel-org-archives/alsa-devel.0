From: Timur Tabi <timur@freescale.com>
Subject: underrun!!! (at least 1786051083.613 ms long)
Date: Mon, 28 Jul 2008 11:26:35 -0500
Message-ID: <488DF33B.4050606@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id EF95324758
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jul 2008 18:26:50 +0200 (CEST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m6SGQaWK011827
	for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2008 09:26:48 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m6SGQabZ028853
	for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2008 11:26:36 -0500 (CDT)
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

I have a driver that supports simultaneous playback and capture, but only if the
same size and sample rate are the same.

I use these commands to play and capture audio:

aplay -D hw:0,0 -t raw -f S24_BE -r 48000 -c 2 test2.raw
arecord -D hw:0,0 -t raw -f S24_BE -r 48000 -c 2 test.raw

If I start capture first and playback second, then everything works.  If I start
playback first and capture second, I get this:

underrun!!! (at least 1786051083.587 ms long)
underrun!!! (at least 1786051083.586 ms long)
underrun!!! (at least 1786051083.585 ms long)
underrun!!! (at least 1786051083.585 ms long)
...

This repeats indefinitely.

Can someone explain how this is even possible?  1786051083.585ms is longer than
20 days!  How could ALSA be so wrong about the extend of the underrun?

-- 
Timur Tabi
Linux kernel developer at Freescale
