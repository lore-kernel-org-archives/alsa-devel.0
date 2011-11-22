From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4720: use
	snd_soc_cache_sync()
Date: Tue, 22 Nov 2011 16:08:42 +0000
Message-ID: <20111122160842.GD30583@opensource.wolfsonmicro.com>
References: <1321969516-21174-1-git-send-email-zonque@gmail.com>
	<20111122140210.GD6624@sirena.org.uk> <4ECBBE59.2040703@gmail.com>
	<20111122153539.GF6624@sirena.org.uk> <4ECBC367.8080801@gmail.com>
	<20111122155340.GB30583@opensource.wolfsonmicro.com>
	<4ECBC81E.6030300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D8F992433F
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 17:08:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4ECBC81E.6030300@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Sven Neumann <s.neumann@raumfeld.com>, timur@freescale.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 22, 2011 at 05:04:46PM +0100, Daniel Mack wrote:
> On 11/22/2011 04:53 PM, Mark Brown wrote:

> > Could be, though I can't see any changes in the code here.  It might be
> > that a change between SMBus and regmap at runtime is upsetting the
> > device somehow but given that it's supposed to be coming back from a
> > power on reset...

> That should affect more codecs then, right?

> $ git grep -l i2c_smbus_write sound/
> sound/aoa/codecs/onyx.c
> sound/aoa/codecs/tas.c
> sound/ppc/daca.c
> sound/ppc/tumbler.c
> sound/soc/codecs/tpa6130a2.c

None of these use regmap so wouldn't be affected by an interaction
between the two.  The tpa6130a2 isn't going through the standard ASoC
structures at all.

> > Does reverting to the non-regmap soc-io.c help?

> Is there a single commit we can revert on top of 3.2-git to test this?

Should be, or a small series anyway.  git log sound/soc/soc-io.c should
show.
