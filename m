From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Davinci: DM365: Enable DaVinci Voice
 Codec support for DM365 EVM
Date: Fri, 8 Jan 2010 19:37:21 +0000
Message-ID: <20100108193720.GA3088@sirena.org.uk>
References: <1262902641-14821-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20100108113121.GB10128@sirena.org.uk>
	<4B476D3B.3050200@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A39A10384F
	for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2010 20:37:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B476D3B.3050200@ridgerun.com>
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

On Fri, Jan 08, 2010 at 11:36:59AM -0600, Miguel Aguilar wrote:
> Mark Brown wrote:
> > On Thu, Jan 07, 2010 at 04:17:21PM -0600, miguel.aguilar@ridgerun.com wrote:

> >> +		if (device == 0)
> >> +			davinci_cfg_reg(DM365_EVT2_ASP_TX);
> >> +		else
> >> +			davinci_cfg_reg(DM365_EVT2_VC_TX);

> > I'd be a bit more comfortable with this if it were using something more
> > symbolic like a #define or enum rather than checking a bare number to
> > work out which device it's talking to.

> The idea of these function is check at runtime if the user space application is 
> requesting the AIC3x or the voice codec, then it will set the proper source for 
> the dma channels, since the ASP and the Voice Codec share the same dma channels, 
> so that's why use a #define doesn't make sense.

I see what your code is doing but at the minute it's making this
decision based on the device number that's being passed in by comparing
it as a pure number.  This seems fragile - something symbolic that
joined things up a bit more wouldn't raise eyebrows in the same way.

> Can you check the part of this patch related to registering both codecs AIC3x 
> and the voice codec?

Like I say that all looks fine to me but I can't really check if the
DaVinci code is idiomatic.
