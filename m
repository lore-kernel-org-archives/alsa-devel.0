From: "John Kacur" <jkacur@gmail.com>
Subject: davinci_request_dma()
Date: Thu, 16 Oct 2008 10:58:58 +0200
Message-ID: <520f0cf10810160158y67c8330fg959f198d9026d680@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f24.google.com (mail-gx0-f24.google.com
	[209.85.217.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 4888B103820
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Oct 2008 10:59:17 +0200 (CEST)
Received: by gxk5 with SMTP id 5so1642803gxk.8
	for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2008 01:58:58 -0700 (PDT)
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

I'm looking for a little bit more help reading the SOC code. In
particular, I'm reading davinci-pcm.c, and function
davinci_pcm_dma_request, which makes two calls to davinci_request_dma.
However, when I grep for davinci_request_dma, the only places I can
find it are in davinci_pcm_dma_request itself!

[jkacur@mydcore linux-2.6.26]$ grep -rn davinci_request_dma *
sound/soc/davinci/davinci-pcm.c:143:	ret =
davinci_request_dma(prtd->params->channel, prtd->params->name,
sound/soc/davinci/davinci-pcm.c:150:	ret =
davinci_request_dma(PARAM_ANY, "Link",

Either I'm missing something, or this code wouldn't even compile. I
would appreciate any help in understanding this.

Thank you.
