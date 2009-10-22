From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Developing and cross-compiling an ASoC driver
Date: Thu, 22 Oct 2009 15:21:48 +0100
Message-ID: <20091022142148.GE3776@sirena.org.uk>
References: <1608652916.20091022160818@szabolcserki.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 552101037FB
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 16:21:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1608652916.20091022160818@szabolcserki.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Szabolcs Erki <szabolcs@szabolcserki.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 22, 2009 at 04:08:18PM +0200, Szabolcs Erki wrote:

> I didn't find any suitable description how to do a cross-platform driver development process.
> Could you please give me some introduction how to:

> - cross compile alsa-driver (AFAIK ASoC is part of it, and ALSA is
> part of the linux kernel), and alsa-utils (for getting arecord)
> - cross compile the newly developed alsa driver
> - integrate ASoC and the custom driver to the patched kernel
> (Linux4SAM) and cross compile them to one image.

There is nothing particularly special about building when you're
developing a new driver - the kernel is built in exactly the same way.
There's certainly nothing ASoC specific here.  You'll probably get more
useful advice by asking people who normally use the same distribution
that you do how they develop.

Many people build a system as they normally would with the distribution
they usually use (eg, OpenEmbedded) and then use the toolchain that has 
to compile a kernel by hand from a regular git checkout, copying the
resulting kernel into whatever images they normally use.
