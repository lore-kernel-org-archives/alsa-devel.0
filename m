From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 3/5] ASoC: es7134: update DT binding with new compatible
 and supplies
Date: Mon, 02 Jul 2018 12:11:21 +0200
Message-ID: <1530526281.2900.140.camel@baylibre.com>
References: <20180629150924.18197-1-jbrunet@baylibre.com>
         <20180629150924.18197-4-jbrunet@baylibre.com>
         <20180702100412.GC18211@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702100412.GC18211@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2018-07-02 at 11:04 +0100, Mark Brown wrote:
> On Fri, Jun 29, 2018 at 05:09:22PM +0200, Jerome Brunet wrote:
> > Update the documentation to add support for the es7154 and
> > optional power supplies phandles.
> > +Optional properties:
> > +- VDD-supply: regulator phandle for the VDD supply
> > +- AVDD-supply: regulator phandle for the AVDD supply
> 
> Unless the device is able to work with a power supply missing (which
> doesn't seem entirely credible) supply properties should never be
> optional.

Sure the device cannot work without its physical supplies.
I'll resubmit
