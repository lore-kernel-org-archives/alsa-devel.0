From: "Vegard Nossum" <vegard@peltkore.net>
Subject: intel8x0 / ALC655 no-capture solved
Date: Wed, 9 May 2007 23:07:11 +0200 (CEST)
Message-ID: <61585.84.210.74.57.1178744831.squirrel@peltkore.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from S3.cableone.net (s3.cableone.net [24.116.0.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B0E2244B9
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2007 23:07:57 +0200 (CEST)
Received: from peltkore.net (unverified [69.92.239.228])
	by S3.cableone.net (CableOne SMTP Service S3) with ESMTP id 107241603
	for <alsa-devel@alsa-project.org>; Wed, 09 May 2007 14:07:55 -0700
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

Hello,

I've successfully debugged a problem I've had with being unable to record
anything from microphones or line-in. Detailed information about the bug
along with a temporary work-around can be found here:
http://bugtrack.alsa-project.org/alsa-bug/view.php?id=3066

Now I'd just like to inform about the presence of the bug (at least I'm
pretty sure it's a bug), and that it's solved by the means of a
work-around. I'd be very happy to see a fix in the *code* for this,
however. I'd even like to try it myself (heck, it's just a register
write), but I'm not certain WHERE/WHEN to make the write, under which
conditions, and for which range of cards (ie. is it specific to the ALC655
or ALC*, or perhaps Realtek chips, or should the fix be made for the Intel
driver, or all AC'97 cards?). Guidance would be appreciated :) Maybe it's
even as easy as a card config option, but I wouldn't know.

Thanks.


Kinds regards,
Vegard Nossum

PS: I'm not on the list, so please CC any replies.
