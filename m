From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] cs4270: add support for slave mode
	configurations
Date: Sat, 28 Feb 2009 19:09:10 -0600
Message-ID: <ed82fe3e0902281709i60266708q9293873f3e0faa58@mail.gmail.com>
References: <1235569041-856-1-git-send-email-daniel@caiaq.de>
	<ed82fe3e0902271351nc170b16v71b81754f8aeadd3@mail.gmail.com>
	<20090228121343.GA18336@buzzloop.caiaq.de>
	<ed82fe3e0902280832u2a6e907l8195b5d9b00eafa2@mail.gmail.com>
	<20090228174713.GA20813@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f34.google.com (mail-qy0-f34.google.com
	[209.85.221.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 777681037E3
	for <alsa-devel@alsa-project.org>; Sun,  1 Mar 2009 02:09:11 +0100 (CET)
Received: by qyk42 with SMTP id 42so397374qyk.16
	for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2009 17:09:10 -0800 (PST)
In-Reply-To: <20090228174713.GA20813@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 28, 2009 at 11:47 AM, Daniel Mack <daniel@caiaq.de> wrote:

> Setting the MCLKs for slave mode is probably not necessary (the
> datesheet says so, too), but it doesn't harm either. We're doing that
> for our other applications, so I copied the behaviour.

My only concern with that is that the code now implies that the mclk
bits need to be set even in slave mode.

> In general, I
> can says that this codec is a very smoothly working piece of hardware,
> we never had any hazzle with it and use it for years now - what are the
> effects that you see?

The codec itself seems to work fine.  I don't know what the problem
with our board was that required us to use the cs4270 in master mode.
It was probably not worth the effort trying to make it work in slave
mode.

-- 
Timur Tabi
Linux kernel developer at Freescale
