From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: DaVinci: Voice Codec Interface
Date: Wed, 23 Sep 2009 08:49:18 -0700
Message-ID: <20090923154916.GA4257@sirena.org.uk>
References: <1253647760-32558-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20090922213604.GB4736@sirena.org.uk>
	<4ABA3C52.6010509@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s-utl01-sjpop.stsn.net (s-utl01-sjpop.stsn.net [72.254.0.201])
	by alsa0.perex.cz (Postfix) with SMTP id 39DD1243FA
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 17:50:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4ABA3C52.6010509@ridgerun.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 23, 2009 at 09:18:42AM -0600, Miguel Aguilar wrote:
> Mark Brown wrote:
> > On Tue, Sep 22, 2009 at 01:29:20PM -0600, miguel.aguilar@ridgerun.com wrote:

> >> 2) Add an option to select internal or external codec in the DM365.

> > Can you not do both simultaneously?  This should probably be a separate

> [MA] No external and internal codecs can not coexists since they share the same 
> DMA channels for TX and RX, so the TI recommendation was choose one codec or the 
> other one by the configuration menu.

That'd stop you using both simultaneously but it shouldn't stop you
having both compiled into the kernel simultaneously.  Would it be
difficult to make the DMA driver do something like return -EBUSY if it
was started opened twice?

> Actually, This patch series have a separate patch for the driver, vcif, SoC 
> specific code, and EVM specific code.

You should move the Kconfig stuff for those into the relevant patches.

> >> +	/* Restart the codec before setup */
> >> +	davinci_vcif_stop(substream);
> >> +	davinci_vcif_start(substream);

> > This seems a bit odd - I'd expect to see the start at the end of the
> > function if you need to do this, otherwise the interface will be running
> > before you've configured it?

> [MA] The voice codec interface should be restarted before set the hw params. If 
> you don't do this you will get underrun and overrun errors due to lack of the 
> restarting process. Thats why I do a stop and then a start. I tried to include 
> the prepare function however it is called after the hw params function, and that 
> doesn't make sense.

What exactly is the start bit doing?  The need to restart doesn't seem
so surprising, what seemed surprising was that you start the device
running again before it's been reconfigured - I'd have expected to see a
stop at the head of the function and then the start at the end after all
the new parameters had been done.

> > These look like the interface needs to be configured the same way in
> > both directions?  If that is the case then set symmetric_rates in the
> > DAI.

> [MA]I think it should be symmetric, so the TX and RX should be configured in the 
> same way.

In that case you should set symmetric_rates in the DAI - this will mean
that the core will tell applications about the need to keep symmetric
rates, meaning that you don't get attempts to configure the one
direction when the other is active.

> > 
> >> +	.driver		= {
> >> +		.name	= "voice_codec",
> >> +		.owner	= THIS_MODULE,
> >> +	},
> >> +};

> > Might "vcif" or "davinci-vcif" be a better name?
> [MA]To use that name I should change the name of the clock, however that clock 
> is actually for the whole voice codec module, both voice codec and voice codec 
> interface. The voice codec interface is just a logical separation of the voice 
> codec module.

The name of the device should have no influence on the name of the clock
- the clock API should be able to 

I suspect that you do need a little MFD here, it sounds like all the
resources need to be allocated to a single device which can then dole
them out to the CODEC and DAI drivers.
