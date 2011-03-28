From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: getting dynamic state from ac97 bus ops
Date: Mon, 28 Mar 2011 11:06:10 +0100
Message-ID: <20110328100610.GA23381@sirena.org.uk>
References: <AANLkTinwMBTRkNyPWx+0=9ZY3+iWvadAevPe9J6BvNv2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0486010389A
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Mar 2011 12:06:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinwMBTRkNyPWx+0=9ZY3+iWvadAevPe9J6BvNv2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 27, 2011 at 10:48:52PM -0400, Mike Frysinger wrote:

> is there an obvious way that i'm missing to get at the bus state from
> the funcs in the global soc_ac97_ops structure ?  the ac97 bus drivers
> that i see in the tree simply have a global variable for state and
> that sort of defeats the purpose of having multi-instance support in
> the first place ...

Please remember to CC maintainers on mails if you want to see them.

I'm not sure what you mean by "bus state" but the AC'97 support in ASoC
is really intended for the sort of single CODEC systems you typically
see on embedded boards.  It's mostly there because some of the later
AC'97 CODECs started to grow a lot of non-standard power management and
routing.
