From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/3] ASoC: TWL4030: Enable voice filters
	for voice sidetone
Date: Wed, 24 Jun 2009 07:42:00 +0300
Message-ID: <200906240742.00148.peter.ujfalusi@nokia.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E3543F31C@dlee04.ent.ti.com>
	<67059DBF19D7214F9C66BB0EA91BA90E3555FEAD@dlee04.ent.ti.com>
	<20090623215120.GA16188@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 81001246E6
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 06:43:02 +0200 (CEST)
In-Reply-To: <20090623215120.GA16188@opensource.wolfsonmicro.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz,
	Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 24 June 2009 00:51:20 ext Mark Brown wrote:
> On Tue, Jun 23, 2009 at 02:45:02PM -0500, Lopez Cruz, Misael wrote:
> > If we register widgets based on an option passed through platform
> > data, then we won't be able to switch between options, right?
> > I think switching between option1/2 during runtime is needed,
> > otherwise 4-channels and voice support will be mutually exclusive.
>
> Is it realistic that a platform will want to switch between those two
> cases at runtime?

Realistic or not, I don't know. I don't know if it is feasible at the momen=
t, =

but I can't predict the future.
I think having the ability to switch between Option1 and Option2 at runtime=
 is =

a nice feature.

We could as well create two codec drivers (with shared core code) for Optio=
n1 =

and Option2 as well, having compile time selection between the two. It woul=
d =

be even more easier and cleaner.

If we can not short out things these are backup plans for the future, but I =

would really like to see the runtime selection to be the 'master plan'

-- =

P=E9ter
