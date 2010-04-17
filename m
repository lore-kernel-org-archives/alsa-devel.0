From: ANISH KUMAR <anish.singh@samsung.com>
Subject: Re: No shutdown code in soc-core.c
Date: Sat, 17 Apr 2010 07:02:43 +0000 (GMT)
Message-ID: <21125077.117201271487763642.JavaMail.weblogic@epml11>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B7D424498
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Apr 2010 09:02:46 +0200 (CEST)
Received: from ep_ms13_bk (mailout3.samsung.com [203.254.224.33])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0L1000IKJE8JOB@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Sat, 17 Apr 2010 16:02:43 +0900 (KST)
Received: from ep_spt01 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0L100049NE8J5E@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Sat, 17 Apr 2010 16:02:43 +0900 (KST)
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

Why this shutdown filed is not there in the struct shown below:
static struct platform_driver soc_driver 
{
.shutdown       = soc_shutdown,                  //soc-core.c 
}
This shutdown call this codec_dev->shutdown function 
In my case i am turning off the amplifier using this call.Which
solved my problem of "TAK" sound during reset.

I agree that soc_codec_close() is calling the shutdown function
but in my case there is a call to set the path after this which is
turning on the amplifier and suddenly if we reset the phone it is
causing "TAK" sound.Probably because AMPLIFIER was on.

Anyway why this function call soc_shutdown() is there in 
soc-core.c if no one is calling it???
I know there will be a redundancy if we have shutdown field
in the struct shown above as soc_codec_close call also calls
codec shutdown code.
But in my case it is solving my problem. 
