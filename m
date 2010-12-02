From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC 2/2] ASoC: tlv320dac33: Request for reordered
	update power sequence
Date: Thu, 2 Dec 2010 14:52:04 +0200
Message-ID: <201012021452.04720.peter.ujfalusi@nokia.com>
References: <1291291390-8669-1-git-send-email-peter.ujfalusi@nokia.com>
	<1291291390-8669-3-git-send-email-peter.ujfalusi@nokia.com>
	<20101202122423.GB859@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id ADE7B10381B
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 13:52:13 +0100 (CET)
In-Reply-To: <20101202122423.GB859@rakim.wolfsonmicro.main>
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
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thursday 02 December 2010 14:24:23 ext Mark Brown wrote:
> On Thu, Dec 02, 2010 at 02:03:10PM +0200, Peter Ujfalusi wrote:
> > +	codec->dapm.dapm_reorder_pupdate =3D 1;

I'm really bad at naming for sure.

> Sorry, meant to say on the previous patch: it's also not ideal that this
> affects all widgets on the CODEC, it means that this is an all or
> nothing change which isn't ideal.

That was my intention to have the ability set this reordered mode for the c=
odec.

Back to the naming.. What about reorder_dapm_update_power, and move the fla=
g to =

the snd_soc_dapm_widget struct?

I could think two ways of moving this per widget config:
Either add new widgets:
SND_SOC_DAPM_REORDERED_SWITCH, and SND_SOC_DAPM_REORDERED_SWITCH_E, which w=
ill =

have the same list of parameters, but sets the reorder_dapm_update_power fl=
ag =

for the widget.
But the widget names looks terible.

Or have a helper function, which can set this flag for the given widget, =

something like:
snd_soc_dapm_set_update_power_reordering(struct snd_soc_codec *codec, const=
 char =

*name);
It will find the widget, and sets the flag for that widget only.
The function name again looks bad.

-- =

P=E9ter
