From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add
	DAPM	links between codec and cpu DAI
Date: Tue, 20 Aug 2013 12:49:49 +0100
Message-ID: <20130820114949.GB23006@n2100.arm.linux.org.uk>
References: <20130805220639.GB26637@sirena.org.uk>
 <20130805233015.GY23006@n2100.arm.linux.org.uk>
 <20130806133206.GA6427@sirena.org.uk>
 <20130810161123.GW23006@n2100.arm.linux.org.uk>
 <20130810211342.GX23006@n2100.arm.linux.org.uk>
 <1376293215.2385.32.camel@loki>
 <20130812082837.GB23006@n2100.arm.linux.org.uk>
 <1376405952.2617.101.camel@loki>
 <20130820102555.GZ23006@n2100.arm.linux.org.uk>
 <20130820114421.GN30073@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 8A1E22651AB
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2013 13:50:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130820114421.GN30073@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 20, 2013 at 12:44:21PM +0100, Mark Brown wrote:
> On Tue, Aug 20, 2013 at 11:25:55AM +0100, Russell King - ARM Linux wrote:
> 
> > Mark is adamant that the Kirkwood-i2s with SPDIF support _will_ use DPCM
> > and refuses to take patches which don't.
> 
> No, that's for simultaneous use of I2S and S/PDIF.  Using one or the
> other shouldn't be a problem, that's just a single DAI and a single PCM
> which has always been supported.
> 
> > So, until DPCM gets fixed, I can't proceed with getting SPDIF for kirkwood
> > into mainline.
> 
> I would suggest getting the either/or support merged first.

Sorry, I don't know how to do that.
