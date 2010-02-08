From: ANISH KUMAR <anish.singh@samsung.com>
Subject: DMA interrupt not getting triggered(nailed the problem
	need solution)
Date: Mon, 08 Feb 2010 02:34:29 +0000 (GMT)
Message-ID: <15824817.821301265596468706.JavaMail.weblogic@epml09>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout5.samsung.com (mailout5.samsung.com [203.254.224.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DC632435F
	for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2010 03:34:47 +0100 (CET)
Received: from ep_ms13_bk (mailout5.samsung.com [203.254.224.35])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KXI00IGL4HH6E@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 08 Feb 2010 11:34:29 +0900 (KST)
Received: from ep_spt01 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0KXI009DI4HHJR@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 08 Feb 2010 11:34:29 +0900 (KST)
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
To: jassi brar <jassisinghbrar@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ben-linux@fluff.org, "JaroslavKyselaperex@perex.cz" <JaroslavKyselaperex@perex.cz>
List-Id: alsa-devel@alsa-project.org


Hi All,
 
This problem is due to ETIMEDOUT(timeout) happening in s3c_snd_lrsync function(called by trigger).
As i understand this could be due I2S being broken. This basically happens because 
of improper initialization of CPU or CODEC.

But if that is the case then it would not have produced sound initially also but that
is not the case(initially it is ringing i.e. interrupt coming for a short time then after i am getting time out problem)??
After this sound is not coming this happens when it does the initialisation again using open,
prepare,enqueue and so on.

Please provide any pointers which can help me out.

Thanks & High Regards,
anish
