From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: cs42888: Add codec driver support
Date: Tue, 25 Feb 2014 11:46:36 +0800
Message-ID: <20140225034635.GB7343@MrMyself>
References: <1393224929-7555-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140224113011.GE25940@sirena.org.uk>
 <B745DBDD-8A64-4B98-819B-72F8AFF602DE@cirrus.com>
 <20140224160648.GC6132@MrMyself>
 <20140225000027.GI25940@sirena.org.uk>
 <20140225023840.GB7229@MrMyself>
 <20140225030947.GO25940@sirena.org.uk>
 <20140225031313.GA7343@MrMyself>
 <20140225033929.GP25940@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E8AA265488
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 04:48:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140225033929.GP25940@sirena.org.uk>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Austin,
 Brian" <Brian.Austin@cirrus.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "rob@landley.net" <rob@landley.net>, "galak@codeaurora.org" <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 25, 2014 at 12:39:29PM +0900, Mark Brown wrote:
> On Tue, Feb 25, 2014 at 11:13:14AM +0800, Nicolin Chen wrote:
> > On Tue, Feb 25, 2014 at 12:09:47PM +0900, Mark Brown wrote:
> 
> > > We should be able to arrange to have the ESAI be a clock provider
> > > shouldn't we?  If the clocks need to interface to other things (and they
> > > do) then we should be able to use the standard interface we have to
> > > clocks.
> 
> > Excuse me, I think I just don't get the approach how to use clock API to
> > standardize the MCLK derived from ESAI IP: it's surely not a fixed-clock
> > so we couldn't register in DT and it's not SoC internal clock which means
> > we couldn't register it in the SoC clock driver either.
> 
> > Could you please shed me some light on it?
> 
> So register it from the ESAI driver then.

Then I think I need to find a way to pass the clock to CODEC driver...

Anyway, I'll try it first. Thank you.
