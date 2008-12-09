From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 4/9] ASoC: TWL4030: DAPM mapping of the
	Earpiece output
Date: Tue, 9 Dec 2008 12:08:48 +0200
Message-ID: <200812091208.49048.peter.ujfalusi@nokia.com>
References: <1228805151-29385-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228805151-29385-5-git-send-email-peter.ujfalusi@nokia.com>
	<20081209100307.GC1630@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 2378610383C
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 11:08:57 +0100 (CET)
In-Reply-To: <20081209100307.GC1630@sirena.org.uk>
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
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Tuesday 09 December 2008 12:03:07 ext Mark Brown wrote:
> On Tue, Dec 09, 2008 at 08:45:46AM +0200, Peter Ujfalusi wrote:
> > +static const char *twl4030_earpiece_texts[] =3D
> > +		{"Off", "DACL1", "DACL2", "Invalid",
> > +		"DACR1"};
>
> ...
>
> > +	/* Internal playback routings */
> > +	/* Earpiece */
> > +	{"Earpiece Mux", "DACL1 Switch", "ARXL1_APGA"},
> > +	{"Earpiece Mux", "DACL2 Switch", "ARXL2_APGA"},
> > +	{"Earpiece Mux", "DACR1 Switch", "ARXR1_APGA"},
>
> These are now out of sync with each other.

Aargh...

-- =

P=E9ter
