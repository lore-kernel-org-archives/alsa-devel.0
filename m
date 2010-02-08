From: ANISH KUMAR <anish.singh@samsung.com>
Subject: Re: DMA interrupt not getting triggered(nailed
	the	problem need solution)
Date: Mon, 08 Feb 2010 11:17:01 +0000 (GMT)
Message-ID: <4218975.894361265627821377.JavaMail.weblogic@epml09>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 02E9A24472
	for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2010 12:17:05 +0100 (CET)
Received: from ep_ms13_bk (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KXI00LMASODEO@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 08 Feb 2010 20:17:01 +0900 (KST)
Received: from ep_spt04 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0KXI00CACSODKN@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 08 Feb 2010 20:17:01 +0900 (KST)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, jassi brar <jassisinghbrar@gmail.com>, "JaroslavKyselaperex@perex.cz" <JaroslavKyselaperex@perex.cz>, "ben-linux@fluff.org" <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

>If the initial hardware state happens to result in LRCLK being where the
>lrsync() function is trying to get it then the driver will start up, but
>the misclocking of the configuration will result in ALSA detecting an
>error which will eventually result in a restart of the audio stream.
Mark in my case it is not restarting the audio stream(though it is trying to call trigger again for restarting) 
because in s3c_snd_lrsync function again i am getting time out(ETIMEDOUT).

iiscon = readl(s3c_i2s.regs + S3C_IISCON);
if (iiscon & S3C_IISCON_LRI)
break;

This LRI register bit is not getting set properly causing timeout.How this situation is not coming always(4/10)??
And who should suppose to set it?

If my machine driver had a problem then this should have come always??

Thanks for your reply.
