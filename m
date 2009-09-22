From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: ALSA ASoC CQ0093 Voice Codec
 Driver
Date: Tue, 22 Sep 2009 14:48:50 -0700
Message-ID: <20090922214849.GE4736@sirena.org.uk>
References: <1253647738-32527-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20090922212244.GA4736@sirena.org.uk>
	<4AB944CD.5090702@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s-utl02-sjpop.stsn.net (s-utl02-sjpop.stsn.net [72.254.0.202])
	by alsa0.perex.cz (Postfix) with SMTP id 6E2D324502
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 23:49:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4AB944CD.5090702@ridgerun.com>
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

On Tue, Sep 22, 2009 at 03:42:37PM -0600, Miguel Aguilar wrote:
> Mark Brown wrote:
> > On Tue, Sep 22, 2009 at 01:28:58PM -0600, miguel.aguilar@ridgerun.com wrote:

> > The code is OK but the driver isn't using DAPM.

> [MA] Should it use DAPM, if so, How is the proper way to do that?

Depends if there's any meaningful power management - if there is then
most of the other drivers have examples of what to do, you basically
tell the core about all the things you have power switches for and how
they're interconnected then it will power on only the bits that are in
active use at any one moment.

It's not essential, though - my comment was more there because the
comments in the driver mentioned that power management was being done by
DAPM when it isn't currently.

> >> +static int cq93vc_probe(struct platform_device *pdev)
> >> +{

> > You should make the driver a regular platform device - that way you
> > won't need to do the trick with the global variable to get the resources
> > and you won't need to register the DAIs on module_init.  See wm8350 for
> > an example of doing this with a platform device.

> I tried that and I got many some Virtual memory errors since there is
> the VCIF and the CQ0093 codecs belong to the same register domain of
> the DM365, the first driver which is being registered is the CQ0093
> before the VCIF, but the VCIF is the one that enables the common clock
> for both, so that's why I get the virtual memory error. I'll take a
> look into wm8350 code and I'll try to make it a platform device.

Sounds like you want to make a MFD for the block as a whole and then
have the CODEC and CPU parts of it as subdevices of that.  drivers/mfd
provides a lightweight framework for doing this.
