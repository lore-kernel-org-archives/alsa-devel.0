From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Sharing PXA SSP ports
Date: Wed, 22 Jun 2011 14:05:17 +0100
Message-ID: <20110622130517.GF23666@sirena.org.uk>
References: <BANLkTikxz95HyKt0+0gjeByNah0-N+vBLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A8971039F7
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 15:05:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTikxz95HyKt0+0gjeByNah0-N+vBLg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 22, 2011 at 02:44:10PM +0200, Daniel Mack wrote:

> What would be a good approach? Would we need a multiplexer for this
> hardware bus, or can we extend the DAI driver in any clever way to
> achieve that? Or is there a solution already I just don't know about?

This seems like the DAI driver should deal with things.  It needs to
join up the input and output paths anyway as there's shared clocks and
so on.
