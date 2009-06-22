From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Proposal for more reliable audio DMA.
Date: Mon, 22 Jun 2009 12:43:52 -0400
Message-ID: <9e4733910906220943pd00fbaao2e2c92690e96d46a@mail.gmail.com>
References: <9e4733910906201906y78f76545sc3cdfe9b45a8db5f@mail.gmail.com>
	<ad2655cb0906220927o68628357u223119b76e3967e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 37D792452D
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Jun 2009 18:43:53 +0200 (CEST)
Received: by qyk1 with SMTP id 1so3902144qyk.16
	for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2009 09:43:52 -0700 (PDT)
In-Reply-To: <ad2655cb0906220927o68628357u223119b76e3967e4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 22, 2009 at 12:27 PM, James
Courtier-Dutton<james.dutton@gmail.com> wrote:
> 2009/6/21 Jon Smirl <jonsmirl@gmail.com>:
>> New last buffer is set to automatically stop DMA.
> How do you do this?
> DMA transfers on sound cards are a ring buffer. There is no automatic
> stop feature.

I don't about all hardware, but all of the hardware I've worked with
works both ways, ring or stop at the end.

DMA transfers for network packets wouldn't work in the ring buffer
model, you need the stop at the end capability.

> You set the dma pointers, start dma going in a loop and that is it.
> You can then stop the DMA on command but not as a result of a buffer end.
>



-- 
Jon Smirl
jonsmirl@gmail.com
