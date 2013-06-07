From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH V4] ASoC: fsl: add imx-wm8962 machine driver
Date: Fri, 7 Jun 2013 18:18:00 +0800
Message-ID: <20130607101800.GC19153@MrMyself>
References: <1370600053-14808-1-git-send-email-b42378@freescale.com>
 <20130607102521.GP31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 by alsa0.perex.cz (Postfix) with ESMTP id DBF5B2608D9
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 12:31:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130607102521.GP31367@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, lgirdwood@gmail.com, rob.herring@calxeda.com, grant.likely@linaro.org, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 07, 2013 at 11:25:21AM +0100, Mark Brown wrote:
> > +- hp-det-gpios : The gpio pin to detect plug in/out event that happens to
> > +  Headphone jack.
> > +
> > +- mic-det-gpios: The gpio pin to detect plug in/out event that happens to
> > +  Micphone jack.
> 
> So this is for physically distinct headphone and microphone jacks rather
> than a headset?

Yes, two jacks so use two gpio pins to detect.
