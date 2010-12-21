From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: Add optional pointer to machine
	audio routes to snd_soc_card
Date: Tue, 21 Dec 2010 09:30:46 +0200
Message-ID: <201012210930.46971.peter.ujfalusi@nokia.com>
References: <1292607580-27040-1-git-send-email-jhnikula@gmail.com>
	<201012201322.49437.peter.ujfalusi@nokia.com>
	<20101220141700.f33cae2e.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B31024374
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 08:30:49 +0100 (CET)
In-Reply-To: <20101220141700.f33cae2e.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Monday 20 December 2010 14:17:00 ext Jarkko Nikula wrote:
> On Mon, 20 Dec 2010 13:22:49 +0200
> =

> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> > For sure we need to have the card level DAPM map, when we have more than
> > one codec in the system.
> > What I was thinking is more like to move the DAPM map from codec domain
> > up to card level.
> > What I mean is, that when you build up your ASoC card, the DAPM
> > map/routes are going to be attached to the card, and not to the codec.
> =

> Actually paths and widgets are already decoupled from codec and moved
> to card domain. Map/route is initialization time thing which still has
> dependency to codec. I.e. snd_soc_dapm_add_route favors a widget from
> a calling dapm context (codec).

I see.

> This is due if there are machines with multiple codecs that are not
> cross-connected but if they have widgets with a same name and I didn't
> want to force them to use name prefixing and thus causing
> userspace-kernel space breakage (kcontrol names changed) compared to
> current implementation.

If you have multiple codecs in your device, it is likely that those codecs =
will =

have colliding widget names for sure.
IMHO using prefixes for multi codec cards shall not break the userspace-ker=
nel =

interface, since with old ASoC we had one codec per one card.
So if you move your machine to real multi-comp, then you anyway break the =

userspace-kernel interface by moving the PCMs to one card from the original=
 PCM =

per card way.
If you have one codec in your system you do not need to prefix that, so you =

break nothing.
I would use prefixes in real multi codec cases...
Are we using the prefixes for the non DAPM kcontrols as well? I think we sh=
all, =

if the prefix is defined.

-- =

P=E9ter
