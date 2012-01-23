From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: da7210: Add support for PLL and
	SRM
Date: Mon, 23 Jan 2012 12:03:14 +0000
Message-ID: <20120123120313.GC29465@opensource.wolfsonmicro.com>
References: <1327313241.31594.12.camel@matrix>
	<20120123112142.GA29465@opensource.wolfsonmicro.com>
	<1327320561.31594.23.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 08051244F5
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2012 13:03:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1327320561.31594.23.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 23, 2012 at 05:39:21PM +0530, Ashish Chavan wrote:
> On Mon, 2012-01-23 at 11:21 +0000, Mark Brown wrote:
> > On Mon, Jan 23, 2012 at 03:37:21PM +0530, Ashish Chavan wrote:

> > ...this code is shared between both branches (as well as the SRM case)
> > and should be factored out between them.

> We are picking values from three different tables in three cases. Even
> if we factor out this code, we will need a switch or if-else to identify
> correct table. As we are already checking those conditions, I put the
> code there. Can you please elaborate a bit, in case if I misunderstood
> your point?

The only difference between these relatively large chunks of code is the
table that's being referenced.  Either use a single table or factor
things out so that you're sharing all the code that doesn't pick the
table.
