From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Add DA7210 codec device support
 for ALSA
Date: Thu, 10 Dec 2009 12:45:16 +0000
Message-ID: <20091210124516.GB9762@rakim.wolfsonmicro.main>
References: <u4oo0x3gy.wl%morimoto.kuninori@renesas.com>
	<20091209121017.GJ19851@opensource.wolfsonmicro.com>
	<uk4wv6uiv.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 238D724439
	for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2009 13:45:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <uk4wv6uiv.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Magnus <magnus.damm@gmail.com>, Jason Coughlan <jason.coughlan@diasemi.com>, Dajun Chen <Dajun.Chen2@diasemi.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 10, 2009 at 06:35:52PM +0900, Kuninori Morimoto wrote:

> Because this original driver came from Dialog guy.
> My work is cleanup only.
> # Of course we already got acceptance from him.

> Could you approve it with /* FIXME */ comment ?
> If you can not approve it, this time I will remove all
> of DAPM / widget settings,
> and use fixed value with "This is very simple settings" comments.

It's a bit tricky, if the code looked incomplete (as the twl4030 driver
did originally) it'd not be such an issue but because it's got this odd
mix of dynamic and static power management I'm reluctant to accept it
as is.  The code looks wrong as opposed to incomplete and so I worry
that it will be fragile in the face of core development.

What's normally done in situations like this is to hook into either the
bias level configuration in set_bias_level() or events on widgets to do
any power control that DAPM can't do automatically.  More documentation
might help as well if it's not actually maintaining the power with these
settings.

If it's too difficult to support then removing the DAPM support would
certainly be OK for merging - it's obviously far from ideal but it
doesn't have the fragility issues.
