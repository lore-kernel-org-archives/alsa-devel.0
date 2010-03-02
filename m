From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC 4/4] ASoC: OMAP3: Report delay on playback
	caused by the internal FIFO
Date: Tue, 2 Mar 2010 15:52:36 +0200
Message-ID: <201003021552.36622.peter.ujfalusi@nokia.com>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<1267537191-25254-5-git-send-email-peter.ujfalusi@nokia.com>
	<20100302134707.GF10658@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id BFFE11038EA
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 14:52:47 +0100 (CET)
In-Reply-To: <20100302134707.GF10658@sirena.org.uk>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 02 March 2010 15:47:07 ext Mark Brown wrote:
> On Tue, Mar 02, 2010 at 03:39:51PM +0200, Peter Ujfalusi wrote:
> > +	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> > +		fifo_use =3D omap_mcbsp_get_tx_buffstat(mcbsp_data->bus_id);
> > +	else
> > +		return 0;
> =

> You're already handling the playback vs. capture thing here! :)

Oh yes, I do. I have removed the capture (rx related) reporting, since as I =

mentioned, I was not sure how to, and what to report.
But is it OK to have initially support for playback delay handling, and if =
there =

is a need, add the capture later?

> =

> > +	/*
> > +	 * Devide the used locations with the channel count to get the
> =

> Divide.

Yes ;)

-- =

P=E9ter
