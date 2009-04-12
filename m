From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] General fix for Palm27x aSoC driver
Date: Sun, 12 Apr 2009 19:30:38 +0200
Message-ID: <87ljq5u6dd.fsf@free.fr>
References: <200904121858.42931.marek.vasut@gmail.com>
	<20090412170626.GD4295@sirena.org.uk>
	<200904121920.15488.marek.vasut@gmail.com>
	<200904121924.24781.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D0AA103811
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Apr 2009 19:30:46 +0200 (CEST)
In-Reply-To: <200904121924.24781.marek.vasut@gmail.com> (Marek Vasut's message
	of "Sun\, 12 Apr 2009 19\:24\:24 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@sirena.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Marek Vasut <marek.vasut@gmail.com> writes:

> btw mio_a701 uses it the same way ... why can I ? Why was the mio code merged 
> then?
The pxa_set_ac97_info() was introduced in 2008, June the 10th.
The original mio code was submitted in early 2008, in March I think. Do you see
now why ?

And that code was recently amended by Eric Miao, because it has not evolved with
the introduction of pxa_set_ac97_info() as it should had (blame me). The part of
code you're talking about is now gone.

Cheers.

--
Robert
