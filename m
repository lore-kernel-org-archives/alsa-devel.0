From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA SoC device tree bindings
Date: Sun, 27 Jun 2010 10:42:47 +0100
Message-ID: <20100627094246.GA2845@sirena.org.uk>
References: <201006232030.14138.jeremy.kerr@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D4347103830
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 11:42:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201006232030.14138.jeremy.kerr@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jeremy Kerr <jeremy.kerr@canonical.com>
Cc: devicetree-discuss@lists.ozlabs.org, kernel-team@lists.ubuntu.com, linaro-dev@lists.linaro.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 23, 2010 at 08:30:13PM +0800, Jeremy Kerr wrote:

> At this stage, we're just looking at how to structure device in the device 
> tree. The bindings for specific devices will come as required (ie, as we add 
> device tree support for them).

Actually, re-reading the page I'm not sure it really captures my
understanding of the discussion (and all the previous discussions we've
had on the lists and so on) at all.  Reading the page the idea that a
machine specific driver is normal and expected doesn't come over at all
well, especially in the design section which doesn't make any mention at
all of machine specific drivers.

As I keep saying the main thing I'm looking for from any device tree
binding is something that I can point people at so we don't need to go
through the rehashings of this subject which come up every time someone
decides they want to use device trees.
