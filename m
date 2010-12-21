From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: Add optional pointer to machine
	audio routes to snd_soc_card
Date: Tue, 21 Dec 2010 09:42:15 +0200
Message-ID: <201012210942.15878.peter.ujfalusi@nokia.com>
References: <1292607580-27040-1-git-send-email-jhnikula@gmail.com>
	<201012201322.49437.peter.ujfalusi@nokia.com>
	<20101220120201.GB26706@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id EEBAF24391
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 08:42:15 +0100 (CET)
In-Reply-To: <20101220120201.GB26706@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

sorry for the late reply, but I have constant mail reception problems, and =
I do =

not receive mails, or randomly receiving them...

On Monday 20 December 2010 14:02:01 ext Mark Brown wrote:
> > What I was thinking is more like to move the DAPM map from codec domain
> > up to card level.
> > What I mean is, that when you build up your ASoC card, the DAPM
> > map/routes are going to be attached to the card, and not to the codec.
> =

> At runtime everyting is treated (or should be treated) as one map - the

That's good.

> > One thing that might need to be changed in DAPM is how we handle the
> > connected/not connected endpoints.
> > Currently if you have DAPM_OUTPUT, and you do not connect it to
> > speaker/HP/line, it is handled like it has some connection.
> > In multi comp this might be not what we want.
> > Also the treatment of the inputs might need to be changed.
> =

> I don't see anything different here with multi-component?  The general
> idea is that by default a floating output or input should be treated as
> connected.

As I said, it is another issue. It is just that for me it is more logical t=
o =

treat the floating inputs/outputws as not connected. It is not that big pro=
blem, =

since from machine driver I can mark the unsused pins as nc.

> > Now if you enable the bypass on codec2, it shall not bring up the codec2
> > bias, since we do not have full route.
> =

> This isn't abundantly clear - there may potentially be analogue
> interface issues if two devices which aren't connected aren't both
> powered up and down together.  Robust system design should avoid these
> issues but I'd prefer it if software were conservative and at the very
> least always had an option to ensure everything is powered on at once.

If you look at things in card level, I still think that in the case I have =

described the codec2 shall not change bias level.
If it does before the playback starts on the codec1, we might end up hearin=
g the =

pop from codec1 powering up, since the codec2 path has been already up (wit=
h the =

speaker enabled).
If the DAPM treats this situation in a same way, if it was within one codec=
, =

than we are able to reduce the pop noise on the output.
It is not a black magic to do so, and since we have single DAPM map/routing=
 it =

can be done with small effort. I think.

> > If we do not have the:
> > {"codec2 Line in", NULL, "codec1 to line out"},
> > in the machine driver, we shall not power the bypass path in codec2, ev=
en
> > if the switch is on, since the machine does not specified any
> > connection.
> > =

> > IMHO this is more logical, than treating non connected OUTPUTs/INPUTs as
> > connected.
> > But this is a different issue.
> =

> I don't see any relationship between multi-component and the state of
> the pins here?  If there's a path through the device the path would be
> there even if there's only one device in the system.

Yeah, it is different issue.
If the card has been treated as one device, I see no problems. But if we tr=
eat a =

codec as device within a card, we might have some issues, but it can be sol=
ved =

with small effort.

-- =

P=E9ter
