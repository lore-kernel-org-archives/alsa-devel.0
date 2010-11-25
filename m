From: JASWINDERSINGH BRAR <jassi.brar@samsung.com>
Subject: Re: [PATCH 5/8] ASoC: smdk_wm9713: fix resource leak
	in smdk_init	error path
Date: Thu, 25 Nov 2010 08:16:27 +0000 (GMT)
Message-ID: <19154684.124691290672986907.JavaMail.weblogic@epml21>
Reply-To: jassi.brar@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 67B2F103BA5
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 09:16:32 +0100 (CET)
Received: from epms1.samsung.com (mailout4.samsung.com [203.254.224.34])
	by mailout4.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0LCF0097XLNFENA0@mailout4.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 25 Nov 2010 17:16:27 +0900 (KST)
Received: from ep_spt01 ("port 62720"@[203.254.225.172])
	by ms1.samsung.com (Oracle Communications Messaging Exchange Server
	7u4-19.01 64bit (built Sep 7 2010)) with ESMTP id
	<0LCF00DL5LNFRY50@ms1.samsung.com>
	for alsa-devel@alsa-project.org; Thu, 25 Nov 2010 17:16:27 +0900 (KST)
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
To: Axel Lin <axel.lin@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

------- Original Message -------
Sender : Axel Lin<axel.lin@gmail.com> 
Date   : Nov 25, 2010 16:11 (GMT+09:00)
Title  : [PATCH 5/8] ASoC: smdk_wm9713: fix resource leak in smdk_init error path

> Fix the error path to properly free allocated resources.

Acked-by: Jassi Brar <jassi.brar@samsung.com>
