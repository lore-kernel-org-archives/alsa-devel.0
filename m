From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: Add optional pointer to machine
	audio routes to snd_soc_card
Date: Mon, 20 Dec 2010 13:22:49 +0200
Message-ID: <201012201322.49437.peter.ujfalusi@nokia.com>
References: <1292607580-27040-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 9ED0F24522
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 12:22:47 +0100 (CET)
In-Reply-To: <1292607580-27040-1-git-send-email-jhnikula@gmail.com>
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

On Friday 17 December 2010 19:39:40 ext Jarkko Nikula wrote:
> This is targeted mostly to cross-device setups where single audio map
> defining routes around and between the codecs looks cleaner than defining
> and registering maps to each codec separately from machine init callbacks.
> =

> This could be also used to reduce simple machine init callbacks where only
> snd_soc_dapm_add_routes and snd_soc_dapm_sync are called. However, this
> does work only if the widgets names are unique in the system.
> =

> Idea of common audio map came from Peter Ujfalusi
> <peter.ujfalusi@nokia.com>.
> =

> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---

For sure we need to have the card level DAPM map, when we have more than on=
e =

codec in the system.
What I was thinking is more like to move the DAPM map from codec domain up =
to =

card level.
What I mean is, that when you build up your ASoC card, the DAPM map/routes =
are =

going to be attached to the card, and not to the codec.
If you have one codec on one card, then it is not going to change much, but=
, if =

you have multiple codecs you will still have one single DAPM map for the ca=
rd, =

which stretches through multiple codecs.

When you have more codecs, you specify the prefix for the codecs, so the ca=
rd =

DAPM map/route will have prefixed widgets. You use the prefixed widget name=
s to =

make the connections needed in your system.

When you debug such a system you are anyway interested in the global DAPM s=
tatus =

at every given time.

One thing that might need to be changed in DAPM is how we handle the =

connected/not connected endpoints.
Currently if you have DAPM_OUTPUT, and you do not connect it to speaker/HP/=
line, =

it is handled like it has some connection.
In multi comp this might be not what we want.
Also the treatment of the inputs might need to be changed.

In this example:
codec1:
DAPM_OUTPUT("to speaker")
DAPM_OUTPUT("to line out")

codec2:
DAPM_INPUT("line in")
DAPM_SWITCH("bypass")
DAPM_OUTPUT("to speaker")

{"bypass", "Switch", "Line in"},
{"to speaker", "Switch", "bypass"},


In machine you would have something like this:

DAPM_SPK("Speaker1")
DAPM_SPK("Speaker2")

{"Speaker1", NULL, "codec1 to speaker"},

{"Speaker2", NULL, "codec2 to speaker"},
{"codec2 Line in", NULL, "codec1 to line out"},

Now if you enable the bypass on codec2, it shall not bring up the codec2 bi=
as, =

since we do not have full route.
If one starts the playback on codec1, and the codec2 bypass is enabled, tha=
n we =

need to power the codec1, and codec2 DAPM path.
If we do not have the:
{"codec2 Line in", NULL, "codec1 to line out"},
in the machine driver, we shall not power the bypass path in codec2, even i=
f the =

switch is on, since the machine does not specified any connection.
IMHO this is more logical, than treating non connected OUTPUTs/INPUTs as =

connected.
But this is a different issue.

I think we shall try to move the DAPM mapping/routing from codec to card do=
main, =

and also change the behavior of not connected pins.

-- =

P=E9ter
