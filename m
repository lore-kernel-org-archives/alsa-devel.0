From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: tlv320aic23b soft mute weirdness
Date: Fri, 31 Oct 2008 17:28:56 -0700
Message-ID: <490BA2C8.9090405@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth02.csee.onr.siteprotect.com
	(smtpauth02.csee.onr.siteprotect.com [64.26.60.136])
	by alsa0.perex.cz (Postfix) with ESMTP id 66F6624789
	for <alsa-devel@alsa-project.org>; Sat,  1 Nov 2008 01:29:24 +0100 (CET)
Received: from [192.168.0.251] (unknown [67.42.45.38])
	(Authenticated sender: troy.kisky@boundarydevices.com)
	by smtpauth02.csee.onr.siteprotect.com (Postfix) with ESMTP id
	26B8FE3800A
	for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2008 19:29:22 -0500 (CDT)
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

I'm having trouble making the soft mute bit work correctly.
I was wondering if anyone else was experiencing this issue.


The soft mute (reg 5, bit 3) does mute the left or the
right speaker, depending on whether or not channel swap is set
reg 7, bit 5). But it makes the other channel louder.

Does this sound familiar to anyone?
Can anyone verify the problem?

I don't see how our board design can cause this, but I can't rule it out.
I've duplicated the result on 3 of our boards.


Thanks
Troy
