From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] ASoC: cs35l32: avoid uninitialized
	variable access
Date: Sun, 6 Mar 2016 21:43:25 +0100
Message-ID: <201603062143.25158.arnd@arndb.de>
References: <1453741678-1988125-1-git-send-email-arnd@arndb.de>
 <20160305145400.GF19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F29C260592
 for <alsa-devel@alsa-project.org>; Sun,  6 Mar 2016 21:43:47 +0100 (CET)
In-Reply-To: <20160305145400.GF19428@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Brian Austin <brian.austin@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Saturday 05 March 2016, Russell King - ARM Linux wrote:
> On Mon, Jan 25, 2016 at 06:07:32PM +0100, Arnd Bergmann wrote:
> > gcc warns about the possibilty of accessing a property read from
> > devicetree in cs35l32_i2c_probe() when it has not been initialized
> > because CONFIG_OF is disabled:
> > 
> > sound/soc/codecs/cs35l32.c: In function 'cs35l32_i2c_probe':
> > sound/soc/codecs/cs35l32.c:278:2: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > 
> > The code is actually correct because it checks the dev->of_node
> > variable first and we know this is NULL here, but by adding a
> > check for IS_ENABLED(CONFIG_OF), we can let the compiler know
> > as well, and also generate smaller object code.
> 
> No, the code is buggy, and the compiler is very correct in warning about
> it.

...
> 
> Note that 'out_values' is not written to if of_find_property_value_of_size()
> returns an error.  Therefore, if cirrus,boost-manager is missing, the
> resulting value of 'val' is left uninitialised.

You are right, this is an actual bug in the driver, and my patch just
hides it. Interestingly, this is not the case that the warning was about,
as we get the warning only when CONFIG_OF is disabled and the code
is correct (because dev->of_node is guaranteed to be NULL), but we
don't get the warning when CONFIG_OF is enabled and we can actually
run into the problem.

Fixing the driver to have correct error handling on the property
functions will make the warning go away and fix the bug you pointed
out, so we should definitely do that and drop my patch.

	Arnd
