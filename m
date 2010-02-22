From: Jerone Young <jerone.young@canonical.com>
Subject: Conexant CX20561 alsa driver not muting headphone jack
 on Thinkpads when mute button pressed .. any ideas?
Date: Mon, 22 Feb 2010 17:55:34 -0600
Message-ID: <1266882934.2831.40.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 747DD244B8
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 00:55:49 +0100 (CET)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1Nji7n-0007o2-DU
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 23:55:42 +0000
Received: from [32.176.102.220] by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <jerone.young@canonical.com>) id 1Nji7m-0005Z6-Fy
	for alsa-devel@alsa-project.org; Mon, 22 Feb 2010 23:55:39 +0000
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

There is an interesting problem with Lenovo Thinkpads X200, X200s, X301,
& .. looks like W500  using the Conexant CX20561 codec under Linux with
alsa.

But if you have your headphone plugged in. You get audio .. but if you
press the hardware mute button .. it will not mute the headphones. By
pulling out the headphones you will notice though that the internal
speakers are muted.

At first I blamed the bios. But then I did a test under FreeDOS where I
used the beep command for sound. Sure enough I press the mute button and
the headphone jack is muted.

I've been looking for any documentation I can find on the CX20561 but
there is non out there I can find. I could be wrong, but it seems some
bit isn't being flipped for this codec to work correctly with this
functionality with the alsa driver.


Any ideas?

I've created a bug here:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4928

			Thanks,
				Jerone
