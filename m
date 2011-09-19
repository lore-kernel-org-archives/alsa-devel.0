From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 07/17] ASoC: twl6040: Lower the initial
	gains
Date: Mon, 19 Sep 2011 14:26:31 +0300
Message-ID: <2033664.fWQvF2IA53@barack>
References: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
	<1316090379-30760-8-git-send-email-peter.ujfalusi@ti.com>
	<20110919110006.GH23727@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71]) by alsa0.perex.cz (Postfix) with ESMTP id BFBFF249D8
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Sep 2011 13:26:29 +0200 (CEST)
Received: by bkat2 with SMTP id t2so5875897bka.36
	for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2011 04:26:25 -0700 (PDT)
In-Reply-To: <20110919110006.GH23727@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org, Samuel Ortiz <samuel.ortiz@intel.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Monday 19 September 2011 12:00:06 Mark Brown wrote:
> On Thu, Sep 15, 2011 at 03:39:29PM +0300, Peter Ujfalusi wrote:
> > The default gains on outputs/inputs are set to 0dB.
> > To be able to handle pop noise better, we need to lower
> > the gains on controls, where it is possible.
> =

> It looks like what you really want to do here is implement support
> having PGAs able to cache the gain the user has set but hold the gain at
> zero while the PGA is disabled.

The twl6040 had support for this, but we did not lowered the initial gain =

after cold power on.
This resulted a pop noise at the first time the audio paths had been used.

> This would be generally useful, a lot
> of older parts liked to have the PGAs muted when powering them.

I have similar implementation (caching of the output gain values) in the =

twl4030 - there the reason was to decrease the power consumption.
We need to have some sort of caching for the gain values, and linking the =

volume controls to DAPM in order to restore, or turn them off at the correc=
t =

time.
In twl4030 case I have custom PGA event handlers for outputs, and I manage =
the =

individual output amplifiers through them.
Here in twl6040 we also have event handlers to do the ramp up/down on the =

gains. AFAIK some wm* codec have similar code.

I can take a look at these to find a generic way to handle them.

--
P=E9ter
