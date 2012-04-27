From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Distorted jackd output on Macbooks
Date: Fri, 27 Apr 2012 21:13:48 +0200
Message-ID: <4F9AEFEC.4070509@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A48610454A
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 21:13:49 +0200 (CEST)
Received: from localhost (ltw.loris.tv [127.0.0.1])
	by ltw.loris.tv (Postfix) with ESMTP id 0DF59648D9
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 21:13:49 +0200 (CEST)
Received: from ltw.loris.tv ([127.0.0.1])
	by localhost (ltw.loris.tv [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KkIdPniS-dz7 for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 21:13:48 +0200 (CEST)
Received: from [IPv6:2001:638:906:2:e269:95ff:fe88:796b]
	(foh.inf-ra.uni-jena.de [IPv6:2001:638:906:2:e269:95ff:fe88:796b])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ltw.loris.tv (Postfix) with ESMTPSA id 5BEE1648D8
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 21:13:48 +0200 (CEST)
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

Hi!

JFTR, we've seen users that report distorted sound on their macbooks
when using jackd.

The workaround is to force 16-bit output:

    http://jackaudio.org/macbook_distortion

Chip in question was the Cirrus Logic CS4206. We don't know yet which of
the formats (32/24) is broken, maybe only one, maybe both.

I happen to have a spare MacBookPro around, but I won't have time to
look into that myself anytime soon.

If somebody else has such a device and wants to give it a whirl, feel
free to go ahead. ;)


Cheers
