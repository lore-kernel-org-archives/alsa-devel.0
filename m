From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH] ASoC: sgtl5000: only check VDDD-supply,
	not revision
Date: Fri, 3 Jun 2016 17:52:02 +0200
Message-ID: <20160603155202.GA854@archie.localdomain>
References: <20160602124724.7725-1-clemens.gruber@pqgruber.com>
 <CAOMZO5B20n7Tu3r+BsU2R5BbYj41tf7qBsMLRWxChdWMkHxLNQ@mail.gmail.com>
 <20160602165651.GP2282@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.pqgruber.com (mail.pqgruber.com [178.189.19.235])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B82926523B
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 17:52:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160602165651.GP2282@sirena.org.uk>
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
Cc: Eric Nelson <eric@nelint.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Fabio Estevam <festevam@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 02, 2016 at 05:56:51PM +0100, Mark Brown wrote:
> On Thu, Jun 02, 2016 at 12:48:15PM -0300, Fabio Estevam wrote:
> 
> > Sometime ago you were looking at this. What do you think about this patch?
> 
> I'm rather concerned that the patches came from people working closely
> with Freescale already - are we *sure* that Freescale/NXP's public
> errata are accurate?

This was confirmed by Freescale/NXP employees, the errata and the
datasheet. First in the errata from 2012 and also in the second revision
of the errata in 2013 and the latest datasheet from 2013.
http://cache.freescale.com/files/analog/doc/errata/SGTL5000ER.pdf
https://community.nxp.com/thread/352718#comment-506518
The latest datasheet from 2013 states: "An external VDDD is required for
new designs"

So, the SGTL5000 rev 0x11 obviously can be used with external VDDD, this
is what Freescale is recommending since 2012 and what people are doing.

The revision check was introduced in the first commit in 2011, so this
was probably a mistake and was never corrected because it still works,
but it shows a misleading message at boot and enables the internal LDO,
which is not used. It's also confusing for everyone who reads the code.

Checking if there is a VDDD-supply regulator should be sufficient.

Thanks,
Clemens
