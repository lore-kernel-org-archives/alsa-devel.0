From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1 - try2] ASoC: add support for multiple
	cards/codecs in debugfs
Date: Thu, 1 Oct 2009 14:02:04 +0300
Message-ID: <200910011402.04406.peter.ujfalusi@nokia.com>
References: <1254382367-27948-1-git-send-email-peter.ujfalusi@nokia.com>
	<1254382367-27948-2-git-send-email-peter.ujfalusi@nokia.com>
	<20091001105107.GB19998@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 75347103909
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 13:02:10 +0200 (CEST)
In-Reply-To: <20091001105107.GB19998@rakim.wolfsonmicro.main>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thursday 01 October 2009 13:51:07 ext Mark Brown wrote:
> On Thu, Oct 01, 2009 at 10:32:47AM +0300, Peter Ujfalusi wrote:
> > In order to support multiple codecs on the same system in the debugfs
> > the directory hierarchy need to be changed by adding directory per codec
> > under the asoc direcorty:
> >
> > debugfs/asoc/{dev_name(socdev->dev)}-{codec->name}/codec_reg
> =

> I'd rather use dev_name() for the CODEC itself if possible, that is more
> likely to be stable going forward and one of the immediate aims with the
> API refactoring is to remove socdev entirely at runtime.

At this point the codec->dev was NULL, that is why I have used the socdev->=
dev =

instead.

> =

> That can be done in a followup, though.
> =

> > @@ -126,7 +126,7 @@ static int soc_pcm_apply_symmetry(struct
> > snd_pcm_substream *substream)
> >
> >  	if (codec_dai->symmetric_rates || cpu_dai->symmetric_rates ||
> >  	    machine->symmetric_rates) {
> > -		dev_dbg(card->dev, "Symmetry forces %dHz rate\n",
> > +		dev_dbg(card->dev, "Symmetry forces %dHz rate\n",
> >  			machine->rate);
> >
> >  		ret =3D snd_pcm_hw_constraint_minmax(substream->runtime,
> =

> but this doesn't seem to accomplish that goal?  I can't actually spot
> the difference either, I'm assuming it's just whitespace?  If so I'll
> apply as-is.

It is my editor, which removed the tailing space from that line, I have =

mentioned it in the intro mail.

> =


-- =

P=E9ter
