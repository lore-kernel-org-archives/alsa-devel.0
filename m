From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH]ASoc:ZOOM2:Add support for DSP rendering.
Date: Wed, 11 Nov 2009 10:38:30 +0200
Message-ID: <200911111038.30131.peter.ujfalusi@nokia.com>
References: <1257459691-12411-1-git-send-email-jwang@ti.com>
	<13B9B4C6EF24D648824FF11BE8967162039B8D1913@dlee02.ent.ti.com>
	<20091110130334.GC16200@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E6B024368
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 09:38:39 +0100 (CET)
In-Reply-To: <20091110130334.GC16200@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, "Wang,
	Jane" <jwang@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 10 November 2009 15:03:34 ext Mark Brown wrote:
> On Mon, Nov 09, 2009 at 11:22:47AM -0600, Wang, Jane wrote:
> =

> Representing the DSP DAI to ASoC is what's needed here, check out the
> OpenMoko code for an example of solving a similar problem.

I agree, the DSP should have it's own platform driver (cpu_dai).
I'm not really following the DSP development, so I'm not sure how it can be =

done, but if it is done like this, than you could be able to hook up any co=
dec =

to the DSP, which would be really nice.

-- =

P=E9ter
