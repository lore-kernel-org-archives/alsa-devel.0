From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: twl6040: Workaround for headset DC
 offset caused pop noise
Date: Wed, 12 Oct 2011 10:46:25 +0100
Message-ID: <20111012094625.GA3647@opensource.wolfsonmicro.com>
References: <1318330813-31184-1-git-send-email-peter.ujfalusi@ti.com>
	<20111011132921.GD1098@sirena.org.uk> <1362600.vrF78ASdYQ@barack>
	<2135466.UdidpbexSR@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4C82524485
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 11:46:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2135466.UdidpbexSR@barack>
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

On Wed, Oct 12, 2011 at 11:55:15AM +0300, P=E9ter Ujfalusi wrote:

> I can not move the HS DAC power on/off to be handled by a supply widget...
> Refcounting in a supply widget will not work for the power down, since th=
e =

> supply widget will be turned off after the DAC widget. At time when the D=
AC =

> receives the PMD event the attached supply is still on.
> I can update the commit message to explicitly say that we need to turn on=
 both =

> HS DAC at the same time, and we need to turn tem off at the same time.

I still don't understand what the problem is.  If nothing else you can
do random register writes from an event on a supply widget...
