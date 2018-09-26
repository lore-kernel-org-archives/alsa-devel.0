From: Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH 2/5] ASoC: max98088: add OF support
Date: Wed, 26 Sep 2018 12:42:25 +0200
Message-ID: <20180926104225.hjebruuhkwfu3me5@pengutronix.de>
References: <20180925142352.24106-1-m.felsch@pengutronix.de>
 <20180925142352.24106-3-m.felsch@pengutronix.de>
 <20180925171136.GQ20825@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E720267730
 for <alsa-devel@alsa-project.org>; Wed, 26 Sep 2018 12:42:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180925171136.GQ20825@sirena.org.uk>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, robh+dt@kernel.org, kernel@pengutronix.de, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
List-Id: alsa-devel@alsa-project.org

On 18-09-25 10:11, Mark Brown wrote:
> On Tue, Sep 25, 2018 at 04:23:49PM +0200, Marco Felsch wrote:
> > From: Andreas F=E4rber <afaerber@suse.de>
> > =

> > MAX98088 is an older version of the MAX98089 device.
> =

> With no software visible diffferences?

I reviewd both RMs a 2nd time and see only a realy minor difference for
register 0x02 and 0x4e. Both covers a different jack plugin/off
handling.

0x02:
MAX98088 - Bit6 indicate JACKSNS State
MAX98089 - Bit6/7 indicates JACKSNS State

But this register is never read by the driver.

0x4e:
MAX98088 - Bit0 is reserved
MAX98089 - Bit0 is JDWK

The register has the default value for both chips and this value is set
during probe().

So I see no other software differences, but maybe a Maxim FAE can help
us?

Regards,
Marco
