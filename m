From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 3/6] ASoC: kirkwood: get rid of
	armada-370-db driver
Date: Tue, 28 Oct 2014 23:54:56 +0100
Message-ID: <20141028235456.7d68d53e@free-electrons.com>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414512524-24466-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20141028223521.GL18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 636A2260454
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 23:54:58 +0100 (CET)
In-Reply-To: <20141028223521.GL18557@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, Liam Girdwood <lgirdwood@gmail.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

Dear Mark Brown,

On Tue, 28 Oct 2014 22:35:21 +0000, Mark Brown wrote:
> On Tue, Oct 28, 2014 at 05:08:41PM +0100, Thomas Petazzoni wrote:
> > Now that the Armada 370 DB audio complex is fully described in the
> > Device Tree using the simple-card DT binding, the armada-370-db audio
> > machine driver can be removed.
> 
> This is just removing support for the old binding which is
> incompatible...

Hum, I'm not sure to follow you here. In a subsequent patch, I change
the Armada 370 DB audio complex DT description to use the
simple-audio-card DT binding, which makes the Armada 370 DB audio
machine driver irrelevant.

Of course, this means that if someone uses an old Armada 370 DB Device
Tree with a new kernel, it will no longer. But I believe this is kind
of expected for this specific case: when we originally introduced the
Armada 370 DB audio support, we knew a proper DT binding to describe
sound complex was arriving, and therefore the Armada 370 DB audio
machine driver was only a temporary solution until the pure DT solution
was available.

Therefore, with the agreement of the mvebu maintainers, I'd like to be
allowed to break the DT backward compatibility here, and get rid of
this audio machine driver which would otherwise have no users left.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
