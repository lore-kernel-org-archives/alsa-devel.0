From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: How the dma interrupt handlers have been registered in
	ALSA?
Date: Mon, 28 May 2007 21:41:59 +0530
Message-ID: <61445c750705280911r325521efoaa925aa74ce85c38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D0F82463D
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2007 18:12:00 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 58so522042wri
	for <alsa-devel@alsa-project.org>; Mon, 28 May 2007 09:12:00 -0700 (PDT)
Content-Disposition: inline
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

Hi

I am referring omap-alsa-dma.c and the related codec files. We usually
register the IRQ handler by calling
request_irq() function but in this mentioned files the IRQ handler etc is
defined but it is not registered anywhere i.e. request_irq is not used
anywhere. Is there any other way of registering irq handlers? The irq
handlers address is passed to
omap_request_dma, but there also it is not registered. I am missing the
entire thing?
