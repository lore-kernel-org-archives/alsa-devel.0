From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH v2] ASoC: ssm2518: Add explicit device tree
 support
Date: Mon, 17 Aug 2015 08:43:23 +0200
Message-ID: <alpine.DEB.2.02.1508170841190.27635@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1508131456110.27635@lnxricardw1.se.axis.com>
 <20150814155304.GP10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B65726053D
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 08:43:24 +0200 (CEST)
In-Reply-To: <20150814155304.GP10748@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


On Fri, 14 Aug 2015, Mark Brown wrote:

> On Thu, Aug 13, 2015 at 03:10:19PM +0200, Ricard Wanderlof wrote:
> > =

> > Add OF match table to SSM2518 to allow direct matching without going
> > through I2C subsystem.
> > =

> > Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
> > =

> > ---
> >  sound/soc/codecs/ssm2518.c |    9 +++++++++
> >  1 file changed, 9 insertions(+)
> =

> You should document all new DT bindings (even if they did implicitly
> happen to work before).

Do you mean in the commit message then? (The patch doesn't implement any =

bindings not already described in =

Documentation/devicetree/bindings/sound/ssm2518.txt).

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
