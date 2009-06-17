From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: pxa-ssp.c handle the I2S and
	LEFT_J cases.
Date: Wed, 17 Jun 2009 10:35:33 +0100
Message-ID: <20090617093532.GA10550@sirena.org.uk>
References: <1245113136.24109.562.camel@brutus>
	<20090616213635.GA26502@sirena.org.uk> <4A385D00.4060601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BA0F224537
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Jun 2009 11:35:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A385D00.4060601@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 17, 2009 at 11:03:28AM +0800, Eric Miao wrote:
> Mark Brown wrote:

> > I'm happy with these changes from a code review point of view, though
> > as well as Eric's ack I'll do some more testing before I apply them.
> > Thanks a lot for doing this work.

> OK, I'll take some time to verify that on PXA3xx.

If you could cover PXA32x that'd be really helpful - I have PXA300 here.
They should be identical but more coverage is always better.
