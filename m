From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 3/3] ALSA SoC: Add Texas
	Instruments	TLV320AIC26 codec driver
Date: Fri, 18 Jul 2008 11:39:45 +0100
Message-ID: <20080718103934.GC14416@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
	<20080714114554.GA25448@sirena.org.uk>
	<20080718062937.GA10988@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 32340243C2
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 12:39:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080718062937.GA10988@secretlab.ca>
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
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 18, 2008 at 12:29:37AM -0600, Grant Likely wrote:
> On Mon, Jul 14, 2008 at 12:45:55PM +0100, Mark Brown wrote:
> > On Sat, Jul 12, 2008 at 02:39:39AM -0600, Grant Likely wrote:

> > This configuration is also exposed via a sysfs file, including some of
> > the configurability.  Exposing the information via sysfs isn't a
> > particular problem but allowing it to be written to without going
> > through ALSA seems wrong.

> All the written bit does is trigger the keyclick event.  It doesn't
> adjust the parameters in any way.

That should be OK for now but we ought to work out a way of doing this
via an ALSA control so it can be standardised over the devices that
support it.  I can't see anything suitable currently, though.

> > > +#if defined(CONFIG_SND_SOC_OF)
> > > +	/* Tell the of_soc helper about this codec */
> > > +	of_snd_soc_register_codec(&aic26_soc_codec_dev, aic26, &aic26_dai,
> > > +				  spi->dev.archdata.of_node);
> > > +#endif

> > CONFIG_SND_SOC_OF could be a module - this needs to also check for it
> > being a module.

> Doesn't #if defined() match on both static and module selection?

Sadly not.
