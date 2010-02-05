From: ANISH KUMAR <anish.singh@samsung.com>
Subject: Re: DMA interrupt not getting triggered
Date: Fri, 05 Feb 2010 08:44:05 +0000 (GMT)
Message-ID: <24512548.721341265359445661.JavaMail.weblogic@epml09>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 4119A1038BC
	for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2010 09:44:08 +0100 (CET)
Received: from ep_ms13_bk (mailout2.samsung.com [203.254.224.25])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KXD00FXB1LHVE@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 05 Feb 2010 17:44:05 +0900 (KST)
Received: from ep_spt02 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0KXD006471LHF2@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 05 Feb 2010 17:44:05 +0900 (KST)
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
To: Ben Dooks <ben-linux@fluff.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>Which board are you trying this on?
S3C6410
 
>There may be some improvements with the DMA code in newer kernels, it would
>be worth trying 2.6.33 and seeing if that has the same problem. There was
>a problem with the circular DMA code failing to be fully merged which caused
>problems including a resource exhaustion.
 
Ben it would be very difficult to take the entire change.There are lot of efforts already gone into to make it stable.
Can you please tell me which all changes exactly is required to get rid of this problem?As to what all the files 
that needs merging as i am not a kernel expert.
or
Can you give me some patch that would solve this problem?
