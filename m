From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH 2/3] ASoC: CS4271 codec support
Date: Wed, 8 Dec 2010 14:47:57 +0000
Message-ID: <20101208144757.GD2716@pulham.picochip.com>
References: <1291809772.31916.4.camel@r60e>
	<20101208130720.GB2716@pulham.picochip.com>
	<20101208133935.GI16418@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20101208133935.GI16418@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, ryan@bluewatersys.com, Alexander <subaparts@yandex.ru>, Jamie Iles <jamie@jamieiles.com>, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 08, 2010 at 01:39:35PM +0000, Mark Brown wrote:
> On Wed, Dec 08, 2010 at 01:07:20PM +0000, Jamie Iles wrote:
> 
> > Doesn't the dependency on SND_SOC_I2C_AND_SPI mean that you will always have 
> > I2C and SPI_MASTER?
> 
> It's not a dependency for the CODEC driver at all.  It means that when
> SND_SOC_ALL_CODECS is selecting the module it will ensure that a
> consistent combination of options is chosen but it is unrelated to use
> in machine drivers and doesn't force both to be enabled even when it is
> selected.
Ahh, thanks for the explanation, I completely misunderstood the way that the 
codecs were selected by the arch's in sound/soc/* and assumed that they were 
user selectable options.

Jamie
