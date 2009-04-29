From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC PATCH 3/5] pxa: clean up the legacy SSP API
Date: Wed, 29 Apr 2009 09:21:53 +0100
Message-ID: <20090429082152.GA2628@sirena.org.uk>
References: <f17812d70904222206n73b3f7d1se18a2615c7aad2bc@mail.gmail.com>
	<20090428222035.GG29277@n2100.arm.linux.org.uk>
	<1240959968.30410.1.camel@brutus>
	<20090429072706.GA31566@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E8C3B24133
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Apr 2009 10:21:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090429072706.GA31566@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 29, 2009 at 08:27:06AM +0100, Russell King - ARM Linux wrote:
> On Tue, Apr 28, 2009 at 08:06:08PM -0300, Daniel Ribeiro wrote:

> > The SPI subsystem?

> Can the SPI system cope with the other chip being the master of the
> interface.  In other words, can SPI sit around primed for a transfer,
> and notify the user of SPI that new data has arrived?

> If not, the SPI subsystem is totally unsuitable for this.

It's slave only at the minute - there's holes in the API someone could
fill in but that's not happened yet.
