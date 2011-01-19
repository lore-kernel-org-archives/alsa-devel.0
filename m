From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/3] ASoC: Add support for sequencing within
Date: Wed, 19 Jan 2011 10:19:38 +0200
Message-ID: <4D369E9A.1030501@nokia.com>
References: <1295367614-12143-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1295367614-12143-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id D4623244C5
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 09:19:41 +0100 (CET)
In-Reply-To: <1295367614-12143-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 01/18/11 18:20, ext Mark Brown wrote:
> With larger devices there may be many widgets of the same type in series
> in an audio path. Allow drivers to specify an additional level of ordering
> within each widget type by adding a subsequence number to widgets and then
> splitting operations on widgets so that widgets of the same type but
> different sequence numbers are processed separately.  A typical example
> would be a supply widget which requires that another widget be enabled
> to provide power or clocking.
> =

> SND_SOC_DAPM_PGA_S() and SND_SOC_DAPM_SUPPLY_S() macros are provided
> allowing this to be used with PGAs and supplies as these are the most
> commonly affected widgets.

Not really for this series...
I have been also wondering on the power up/down sequence ordering in a
complex setup.
I might be totally wrong, but never the less:
I have been wondering, if we just go, and follow the sequence of the
DAPM widgets in on the path on powerup, and follow the reverse sequence
on powerdown.

Take something like this:
DAC->PGA1->MIXER1->PGA2->MUX->PGA3->MIXER2->OUTPUT->SPEAKER
 ^      ^                       ^
SUPPLY1 SUPPLY2                 SUPPLY3

The sequence now:
SUPPLY1->SUPPLY2->SUPPLY3->MUX->DAC->MIXER1->MIXER2->PGA1->PGA2->PGA3->SPEA=
KER

Now we are going to be able to change the order of PGA, and SUPPLY.
We were able to do that earlier by changing the order of the PGA/SUPPLY
within the snd_soc_dapm_widget struct (I know... it is not really explicit).

But if we actually follow the route we could have sequence of:
SUPPLY1->DAC->SUPPLY2->PGA1->MIXER1->PGA2->MUX->SUPPLY3->PGA3->MIXER2->SPEA=
KER

When we build up the DAPM tree, we usually follow the spec, basically
modeling the HW, so we can take care of the recommended sequences.

IMHO in this way we would have better control over the sequences, and we
might be in better position to combat pop noises, since we have more
explicit control over the sequence of events.

I have not looked how hard it would be to change the DAPM to do this.
Anyways I would not started to do this without asking... I know there
are really good reasons to have the current DAPM sequence handling, but
I do wonder, if it make sense to do this.

What do you think?

-- =

P=E9ter
