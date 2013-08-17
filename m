From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Sat, 17 Aug 2013 17:14:43 +0200
Message-ID: <20130817151443.GX26614@pengutronix.de>
References: <cover.1376565456.git.b42378@freescale.com>
 <137675716.iLf1T1CVZo@flatron>
 <20130817150002.GU26614@pengutronix.de>
 <2782793.dUculLxO6S@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <2782793.dUculLxO6S@flatron>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org, festevam@gmail.com, Nicolin Chen <b42378@freescale.com>, timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org, p.zabel@pengutronix.de, galak@codeaurora.org, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 17, 2013 at 05:13:20PM +0200, Tomasz Figa wrote:
> On Saturday 17 of August 2013 17:00:02 Sascha Hauer wrote:
> > On Sat, Aug 17, 2013 at 02:26:40PM +0200, Tomasz Figa wrote:
> > > > You mean tx<0-7>.
> > > > 
> > > > Also I would make this option required. Use a dummy clock for mux
> > > > inputs that are grounded for a specific SoC.
> > > 
> > > Why do you need a dummy clock?
> > > 
> > > The driver can simply try to grab all the possible clocks and discard
> > > those that failed, so you can just keep those grounded clocks
> > > unspecified.
> > We don't need dummy clocks. My motivation saying this that I was afraid
> > people try to configure the driver by skipping the clocks they don't
> > want from the devicetree.
> 
> I'm not really sure if the same abuse couldn't be easily achieved by 
> putting dummy clocks in place of those skipped clocks.

That's right, yes.

> 
> Adding a note in binding documentation that says that all clocks that are 
> fed to the IP shall be specified should be fine IMHO.

ok.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
