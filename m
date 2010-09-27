From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V1 09/11] ASoC: DaVinci: i2s,
	add	davinci_i2s_prepare and shutdown
Date: Mon, 27 Sep 2010 01:27:52 +0100
Message-ID: <20100927002752.GB21247@sirena.org.uk>
References: <1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-10-git-send-email-troy.kisky@boundarydevices.com>
	<A24693684029E5489D1D202277BE89447289CD0A@dlee02.ent.ti.com>
	<4C9CF898.7070906@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B7C1924610
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 02:27:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C9CF898.7070906@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Ambrose,
	Martin" <martin@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 24, 2010 at 12:14:32PM -0700, Troy Kisky wrote:
> On 9/24/2010 9:48 AM, Ambrose, Martin wrote:

Guys, please fix the configurations of your mail clients to word wrap
within paragraphs at less than 80 columns - makes things much easier to
read.

> My thought was that the device (master) which starts the external
> wires to wiggling should be last.

> If the codec is master, and starts the clocks before the mcbsp is
> ready that could also cause a pop or noise.

That seems unlikely, especially since we keep the output muted until
very late on in the game.  Any noise should be consumed within the time
the mute is running.

There's more often a problem the other way around with things in the CPU
(or the software looking after them) getting upset when they're left
sitting without a clock for too long.
