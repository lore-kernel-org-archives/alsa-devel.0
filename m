From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: pxa-ssp.c,
	Automatically set	TDM when needed
Date: Sat, 15 Aug 2009 10:51:20 +0100
Message-ID: <20090815095120.GA29987@sirena.org.uk>
References: <1249570519-32622-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249570519-32622-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20090812181724.GZ19257@buzzloop.caiaq.de>
	<1250266661.18028.249.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7359A2452C
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Aug 2009 11:51:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250266661.18028.249.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 14, 2009 at 01:17:41PM -0300, Daniel Ribeiro wrote:

> This should be able to deal with I2S when pxa is slave, on both pxa2xx
> and pxa3xx, with set_tdm_slot(5, 5, 4, 16).

> Or when pxa is master, on pxa3xx only, with set_tdm_slot(3, 3, 2, 16).
> This still violates the "DMYSTOP must be clear on network mode" rule,
> but as all slots are active its not really network mode. And it seems to
> work for you, so... ;)

This seems really confusing from a usability point of view - the master
and slave configurations should look the same.  I'd expec the slave mode
configuration you quote above to be looking for twice as many clocks as
the master mode one.  The driver should ideally encapsulate this.
