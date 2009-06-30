From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97
	driver
Date: Tue, 30 Jun 2009 09:59:18 +0100
Message-ID: <20090630085917.GA13961@sirena.org.uk>
References: <20090629234214.12670.9082.stgit@localhost.localdomain>
	<9e4733910906291726h5cd5bdf8ve7e946aef855ac07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D920F249BD
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Jun 2009 10:59:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910906291726h5cd5bdf8ve7e946aef855ac07@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 29, 2009 at 08:26:12PM -0400, Jon Smirl wrote:

> Does your touchscreen driver use this mutex? Or was this mutex needed
> just for the AC97 driver?

It's in the register accesses so everything accessing the chip registers
will use it.
