From: ANISH KUMAR <anish.singh@samsung.com>
Subject: Re: DMA interrupt not getting triggered(nailed
	the	problem need solution)
Date: Mon, 08 Feb 2010 12:15:57 +0000 (GMT)
Message-ID: <5781224.897561265631357494.JavaMail.weblogic@epml09>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout5.samsung.com (mailout5.samsung.com [203.254.224.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AAE02439E
	for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2010 13:16:00 +0100 (CET)
Received: from ep_ms13_bk (mailout5.samsung.com [203.254.224.35])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KXI004V8VELOI@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 08 Feb 2010 21:15:57 +0900 (KST)
Received: from ep_spt02 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0KXI005H7VELQ4@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 08 Feb 2010 21:15:57 +0900 (KST)
Content-return: prohibited
MIME-version: 1.0
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, jassi brar <jassisinghbrar@gmail.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "JaroslavKyselaperex@perex.cz" <JaroslavKyselaperex@perex.cz>
List-Id: alsa-devel@alsa-project.org

> If the initial hardware state happens to result in LRCLK being where the
 >lrsync() function is trying to get it then the driver will start up, but
 >the misclocking of the configuration will result in ALSA detecting an
 >error which will eventually result in a restart of the audio stream.

>From the lrsync function i know that it is just trying to check whether a particular
bit is set or not.So according to my understanding this lrsync function will timeout if the 
clock itself is not coming.

Please forgive for not understanding your reply.
But i am not able to understand "where the lrsync() function is trying to get-FROM YOUR REPLY"??
And misclocking of the configuration??Please explain this term(googling didn't help much).
