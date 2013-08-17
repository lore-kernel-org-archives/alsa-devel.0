From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Sat, 17 Aug 2013 17:13:20 +0200
Message-ID: <2782793.dUculLxO6S@flatron>
References: <cover.1376565456.git.b42378@freescale.com>
 <137675716.iLf1T1CVZo@flatron> <20130817150002.GU26614@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f46.google.com (mail-bk0-f46.google.com
 [209.85.214.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 47F822607BB
 for <alsa-devel@alsa-project.org>; Sat, 17 Aug 2013 17:13:25 +0200 (CEST)
Received: by mail-bk0-f46.google.com with SMTP id 6so938596bkj.19
 for <alsa-devel@alsa-project.org>; Sat, 17 Aug 2013 08:13:24 -0700 (PDT)
In-Reply-To: <20130817150002.GU26614@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org, festevam@gmail.com, Nicolin Chen <b42378@freescale.com>, timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org, p.zabel@pengutronix.de, galak@codeaurora.org, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Saturday 17 of August 2013 17:00:02 Sascha Hauer wrote:
> On Sat, Aug 17, 2013 at 02:26:40PM +0200, Tomasz Figa wrote:
> > > You mean tx<0-7>.
> > > 
> > > Also I would make this option required. Use a dummy clock for mux
> > > inputs that are grounded for a specific SoC.
> > 
> > Why do you need a dummy clock?
> > 
> > The driver can simply try to grab all the possible clocks and discard
> > those that failed, so you can just keep those grounded clocks
> > unspecified.
> We don't need dummy clocks. My motivation saying this that I was afraid
> people try to configure the driver by skipping the clocks they don't
> want from the devicetree.

I'm not really sure if the same abuse couldn't be easily achieved by 
putting dummy clocks in place of those skipped clocks.

Adding a note in binding documentation that says that all clocks that are 
fed to the IP shall be specified should be fine IMHO.

Best regards,
Tomasz
