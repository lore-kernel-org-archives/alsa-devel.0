From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: codecs: Add DA9055 codec driver
Date: Thu, 20 Sep 2012 07:59:10 -0400
Message-ID: <20120920115908.GL17666@opensource.wolfsonmicro.com>
References: <1347622057.16763.27.camel@matrix>
 <20120919025035.GI8832@opensource.wolfsonmicro.com>
 <1348142335.18996.17.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 88D6A2652E6
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 13:59:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1348142335.18996.17.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 20, 2012 at 05:28:55PM +0530, Ashish Chavan wrote:

> > > +	/* To select if MIC Bias powers MIC 1 or MIC 2 */
> > > +	SOC_ENUM("Mic Bias Select", da9055_mic_bias_select),

> > This would normally be something controlled by the board...  what
> > exactly is this doing?  How does the MICBIAS relate to the microphone
> > inputs?

> Yes, it should be controlled by the board.
> This control selects which of the two MIC Bias pins acts as the BIAS
> source. Earlier we misinterpreted it because of a hardware modification
> which was present on the board without our knowledge.

OK, that sounds like it should either be hooked up in the DAPM graph
or supplied as platform data then.

> > Given that there's no regulator support here
> > it's also a bit surprising that you need to do a sync outside of system
> > suspend...

> I am not sure if I understood this fully. Do you mean a sync is not
> required here?

You only need to resync if the device might have lost power and
forgotten it's register settings (or might've forgotten them for some
other reason).  If the device is left powered up then this isn't needed.
