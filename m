From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Proposal for more reliable audio DMA.
Date: Mon, 22 Jun 2009 17:27:26 +0100
Message-ID: <ad2655cb0906220927o68628357u223119b76e3967e4@mail.gmail.com>
References: <9e4733910906201906y78f76545sc3cdfe9b45a8db5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F92624500
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Jun 2009 18:27:27 +0200 (CEST)
Received: by fxm26 with SMTP id 26so2737386fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2009 09:27:26 -0700 (PDT)
In-Reply-To: <9e4733910906201906y78f76545sc3cdfe9b45a8db5f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2009/6/21 Jon Smirl <jonsmirl@gmail.com>:
> New last buffer is set to automatically stop DMA.
How do you do this?
DMA transfers on sound cards are a ring buffer. There is no automatic
stop feature.
You set the dma pointers, start dma going in a loop and that is it.
You can then stop the DMA on command but not as a result of a buffer end.
