From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/2] ASoC: OMAP: Use single-phase for DSP
	mode
Date: Thu, 16 Apr 2009 12:58:43 +0300
Message-ID: <200904161258.43648.peter.ujfalusi@nokia.com>
References: <1239799136-28729-1-git-send-email-peter.ujfalusi@nokia.com>
	<200904161243.01010.peter.ujfalusi@nokia.com>
	<20090416094847.GC16318@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 704D9103973
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 11:59:13 +0200 (CEST)
In-Reply-To: <20090416094847.GC16318@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 16 April 2009 12:48:47 ext Mark Brown wrote:
> Presumably OSK5912 has been broken since it was merged?  Either that or
> the incorrectly inverted FS polarity happened to result in a setup which
> gives functional audio.

I would not say that, I guess it was working at the time when it was merged=
 - =

I also got the DSP_A mode working with 'incorrect' mcbsp code and =

configuration...
But it does not really matter, how and when this DSP_B mode got into the wr=
ong =

track.
Now it is correct for both DSP_A and DSP_B modes, we need to keep it that w=
ay =

for the time being ;)

I would say that at least Jarkko's two patches should go as soon as possibl=
e =

to avoid further confusions regarding to DSP_B mode.

-- =

P=E9ter
