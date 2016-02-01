From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH] ASoC: fsl_ssi: remove explicit register defaults
Date: Mon, 01 Feb 2016 22:30:53 +0100
Message-ID: <56AFCE8D.70804@maciej.szmigiero.name>
References: <569D3800.2040801@maciej.szmigiero.name> <CAOMZO5DwQza+jDdkA80v4wkrB56y53tOjkP2-36YNq2WBLodaA@mail.gmail.com> <56AF4A9F.4060401@maciej.szmigiero.name> <CAOMZO5DK86JCs_KivZ5MMFKsiP6aVpopG-zgXPE-+_GWjQNuMw@mail.gmail.com> <56AF4ED0.7030801@maciej.szmigiero.name> <56AF8E9E.5000100@maciej.szmigiero.name> <20160201211017.GG4455@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160201211017.GG4455@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 01.02.2016 22:10, Mark Brown wrote:
> On Mon, Feb 01, 2016 at 05:58:06PM +0100, Maciej S. Szmigiero wrote:
> 
>> Looks like a possible solution would be to change
>> regmap_raw_read() to do read using _regmap_read in
>> case the cache is bypassed and there is no ->read
>> callback defined for regmap implementation.
> 
> No, that's completely broken.  We can't do a raw read from a regmap that
> doesn't offer raw access and we shouldn't pretend to do so.  If the
> caller is capable of substituting a register by register read the caller
> should take responsibility for that.

So can regcache initialization be changed to use register by register read
in case raw read fails?

Since other option for drivers like SSI which are memory mapped and
don't offer ability to reset their register values to default would be to
explicitly write driver hardcoded defaults also by doing
register by register write on probe time.

But this would force driver to keep the defaults which I think is bad
(especially for driver that supports multiple generations of hardware
like fsl_ssi which may have different default values).

Maciej
