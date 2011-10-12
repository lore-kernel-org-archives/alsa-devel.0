From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: twl6040: Workaround for headset DC
 offset caused pop noise
Date: Wed, 12 Oct 2011 11:48:04 +0100
Message-ID: <20111012104803.GH3647@opensource.wolfsonmicro.com>
References: <1318330813-31184-1-git-send-email-peter.ujfalusi@ti.com>
	<2135466.UdidpbexSR@barack>
	<20111012094625.GA3647@opensource.wolfsonmicro.com>
	<5817000.NdMGYPik3n@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 30183244CF
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 12:48:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5817000.NdMGYPik3n@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 12, 2011 at 01:45:33PM +0300, P=E9ter Ujfalusi wrote:
> On Wednesday 12 October 2011 10:46:25 Mark Brown wrote:

> > I still don't understand what the problem is.  If nothing else you can
> > do random register writes from an event on a supply widget...

> I still have the code for the out of order McPDM shutdown which is using =
a =

> supply widget attached to the codec's DAC/ADC.
> The ordering of the two supply is not written in stone when both are atta=
ched =

> to the same DAC.

SUPPLY_S.
