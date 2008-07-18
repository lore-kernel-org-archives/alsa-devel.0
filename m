From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ALSA SoC: Add Texas
	Instruments	TLV320AIC26 codec driver
Date: Fri, 18 Jul 2008 10:58:25 +0100
Message-ID: <20080718095823.GA14416@sirena.org.uk>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235340.16923.48024.stgit@trillian.secretlab.ca>
	<1214995713.4882.54.camel@localhost.localdomain>
	<20080712060018.GB23213@secretlab.ca>
	<20080712173609.GA6523@sirena.org.uk>
	<20080717233153.GA8187@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AA49024465
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 11:58:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080717233153.GA8187@secretlab.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@alsa-project.org, timur@freescale.com, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 17, 2008 at 05:31:53PM -0600, Grant Likely wrote:
> On Sat, Jul 12, 2008 at 06:36:10PM +0100, Mark Brown wrote:

> > /sys/bus/platform/devices/soc-audio/codec_reg

> Yikes.  The AIC26 has registers all over the place and most of them are
> empty.  The codec_reg attribute handling means I need to maintain a
> cache of the entire register file; not just the part that is actually
> used.  Oh well; I can work around it.

Sparse (or sparsely used) register maps are pretty common - in practice
it's not been a problem to just have a cache that covers everything and
only gets read, the amount of data involved is rarely that large in the
context of what you need to store the audio you're working with.
