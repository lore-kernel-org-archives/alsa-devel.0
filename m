From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Latency of mixer reconfiguration
Date: Sat, 20 Feb 2010 11:59:29 +0800
Message-ID: <4f3252891002191959v418f6cb4u6cf4b4deb0a7a15b@mail.gmail.com>
References: <20100217181530.GA23152@tango.0pointer.de>
	<20100218100127.GJ2032@sirena.org.uk>
	<20100218180422.GA5606@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E26A41037E3
	for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2010 04:59:30 +0100 (CET)
Received: by pwi9 with SMTP id 9so719780pwi.38
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 19:59:29 -0800 (PST)
In-Reply-To: <20100218180422.GA5606@tango.0pointer.de>
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

2010/2/19 Lennart Poettering <mznyfn@0pointer.de>

>
> On Thu, 18.02.10 10:01, Mark Brown (broonie@opensource.wolfsonmicro.com)
> wrote:
>
>
> The current logic is to not do any software adjustment if the hardware
> adjustment is "close enough" to the total adjustment we want to do,
> tested against a threshold. Which I think is quite a reasonable
> approach because it enables/disables this feature not globally, but
> looks at each case and enables this logic only if it really has a
> benefit.
>
> Lennart
>
>
PA 's watermark is already 20 ms if you want to do any software adjustment
by PA server
