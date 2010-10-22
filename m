From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
Subject: SoC Atmel SSC stereo problem
Date: Fri, 22 Oct 2010 17:17:21 +0200
Message-ID: <4CC1AB01.3020603@fh-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from post.fh-kl.de (post.fh-kl.de [143.93.17.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B1AC103817
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 17:17:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by post.fh-kl.de (Postfix) with ESMTP id 01F782405C8D
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 17:17:24 +0200 (CEST)
Received: from post.fh-kl.de ([127.0.0.1])
	by localhost (post.fh-kl.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Rkdez42iuMD1 for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 17:17:21 +0200 (CEST)
Received: from [10.0.23.197] (aoip1.informatik.fh-kl.de [143.93.17.33])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by post.fh-kl.de (Postfix) with ESMTPSA id 993362400908
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 17:17:21 +0200 (CEST)
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

Hi,

I have some trouble with stereo audio through the atmal ssc interface 
based on at91-ssc.c.
Unfortunately left and right channels were swapped periodically.

In my environment the codec supplies the BLCK and LRC clocks and
the SSC is configured to transmit one sample on both edges of the LRC clock.
But I guess the audio frames will always start with a frame of the left 
channel
while the LRC clock is in an undefined state.

How does normally the audio driver detect when a left and when a right 
channel
frame should be send and with which it should start ?

Thanks in advance for your help.

Regards,

Patrick

-- 

Dipl.-Inf. (FH) Patrick Ziegler

University Of Applied Sciences
Kaiserslautern

Amerikastrasse 1
D-66482 Zweibruecken
Germany

Phone:	+49 631 3724 5526
Mail:	patrick.ziegler@fh-kl.de

http://www.fh-kl.de
http://www.fh-kl.de/fachbereiche/imst/iuk-knowhow.html
