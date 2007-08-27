From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Very elementary question regarding period size
Date: Mon, 27 Aug 2007 21:53:44 +0530
Message-ID: <61445c750708270923k478d35c5h144740e386a801cb@mail.gmail.com>
References: <61445c750708270319p3ca234dfx965fd5c8d98ca03f@mail.gmail.com>
	<1188231188.14382.1207492269@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D0861038C9
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Aug 2007 18:23:48 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so56317ugf
	for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2007 09:23:46 -0700 (PDT)
In-Reply-To: <1188231188.14382.1207492269@webmail.messagingengine.com>
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

On 8/27/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
>
> Pharaoh . wrote:
> > I am testing out my alsa driver for various period and buffer sizes, at
> some
> > configurations it doesn't work so arises this very basic question.
> >
> > Is every sound card/hardware supposed to work at all the period sizes?
>
> No.  The driver is supposed to add constraints that describe the
> capabilities of the hardware/driver.
>
> What are the valid period/buffer sizes supported by your driver?
>
>
> Regards,
> Clemens
>

I have tried with 1024,2048 and 4096 period sizes, with 16384 and 32768
buffer sizes. My driver doesn't seem to work well with 4k-16k or 4k-32k
combinations, i.e. I hear lot of hisses and glitches.

Yes, I am going to add the constraints to my driver.
