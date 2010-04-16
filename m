From: ANISH KUMAR <anish.singh@samsung.com>
Subject: Re: No shutdown code in soc-core.c
Date: Fri, 16 Apr 2010 16:44:44 +0000 (GMT)
Message-ID: <17476636.107751271436284230.JavaMail.weblogic@epml11>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id B2DC1244B9
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Apr 2010 18:44:48 +0200 (CEST)
Received: from ep_ms13_bk (mailout3.samsung.com [203.254.224.33])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0L0Z005D0AIK3K@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Sat, 17 Apr 2010 01:44:44 +0900 (KST)
Received: from ep_spt03 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0L0Z00BMEAIKPN@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Sat, 17 Apr 2010 01:44:44 +0900 (KST)
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
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "liam.girdwood@wolfsonmicro.com" <liam.girdwood@wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


>What are you trying to do ?
 
There was a "TAK" noise because of non-presence of this code.
This soc_shutdown calls the respective shutdown code in codec
for prevention of this kind of strange noise.In my code it is turning
off the Amplifier because of which i no longer get the "TAK" sound.

So i am just wondering why this code is not present in the struct 
i mentioned in my previous mail.
