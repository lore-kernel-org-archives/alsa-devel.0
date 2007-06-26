From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Input/output error while playing a file using aplay
Date: Tue, 26 Jun 2007 22:47:18 +0530
Message-ID: <61445c750706261017i4947eac2l4556d849613555e0@mail.gmail.com>
References: <61445c750706221312t4449c847p72523339f228a101@mail.gmail.com>
	<61445c750706250156p42de468vecbf7ca4f373f2b0@mail.gmail.com>
	<1182769239.15228.1196888507@webmail.messagingengine.com>
	<61445c750706250504k23d02f75y52619c6cd081a5a8@mail.gmail.com>
	<61445c750706250635i61be8752lbf7a7b1930a8ca79@mail.gmail.com>
	<61445c750706251138r290c2a7br6b911be6da7e53ce@mail.gmail.com>
	<1182842511.3512.1197069785@webmail.messagingengine.com>
	<61445c750706260351v2ef766bbrb8685275a0451cec@mail.gmail.com>
	<1182863878.22603.1197116759@webmail.messagingengine.com>
	<61445c750706260643s3f3bfb0end3731eea97c9bb68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.224])
	by alsa0.perex.cz (Postfix) with ESMTP id E928A2445D
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2007 19:17:19 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so1615321nzf
	for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2007 10:17:18 -0700 (PDT)
In-Reply-To: <61445c750706260643s3f3bfb0end3731eea97c9bb68@mail.gmail.com>
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
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>In pointer when I check the dma addr I get
>runtime->dma_addr is 00000000 !!

I think runtime->dma_addr is set to 0 when the dma buffer is
physically non-contiguous.
