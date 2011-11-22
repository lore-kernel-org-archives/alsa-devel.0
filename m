From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4720: use
	snd_soc_cache_sync()
Date: Tue, 22 Nov 2011 15:53:40 +0000
Message-ID: <20111122155340.GB30583@opensource.wolfsonmicro.com>
References: <1321969516-21174-1-git-send-email-zonque@gmail.com>
	<20111122140210.GD6624@sirena.org.uk> <4ECBBE59.2040703@gmail.com>
	<20111122153539.GF6624@sirena.org.uk> <4ECBC367.8080801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6C1F9103A94
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 16:53:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4ECBC367.8080801@gmail.com>
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

On Tue, Nov 22, 2011 at 04:44:39PM +0100, Daniel Mack wrote:

> The code is so simple that I'm starting to suspect
> i2c_smbus_write_byte_data() is doing something very wrong, but I can't
> trace it without a hardware I2C analyzer right now. The i2c-regmap
> low-level implementation uses different access functions under the hood,
> so maybe that's a regression.

Could be, though I can't see any changes in the code here.  It might be
that a change between SMBus and regmap at runtime is upsetting the
device somehow but given that it's supposed to be coming back from a
power on reset...

> We also think that the effect is actually rather new.

Does reverting to the non-regmap soc-io.c help?

> > In any case, the patch is moving to factor code out in favour of core
> > facilities so it's a good idea anyway.

> Hmm, we should really care for the root cause, but maybe we can still
> commit this thing, with a more appropriate commit log?

I think so.
