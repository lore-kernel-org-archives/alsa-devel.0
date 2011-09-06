From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/3] ASoC: soc-dapm: API to
	attach	DAPM_SUPPLY to be used for dai
Date: Tue, 6 Sep 2011 16:09:07 +0100
Message-ID: <20110906150907.GA18090@opensource.wolfsonmicro.com>
References: <1314365603-8947-1-git-send-email-peter.ujfalusi@ti.com>
	<11979330.WnlDKWFkCB@barack> <20110903063119.GB6556@sirena.org.uk>
	<2352586.fDPvRLFK0h@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8009010381B
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 17:09:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2352586.fDPvRLFK0h@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 06, 2011 at 01:21:56PM +0300, P=E9ter Ujfalusi wrote:
> On Saturday 03 September 2011 07:31:19 Mark Brown wrote:

> > Actually I think this is fine with my suggestion so long as you make the
> > CODEC SYSCLK visible to DAPM and have the machine driver turn it off at
> > some later point in the shutdown process (eg, in shutdown()).  That way
> > the data paths will still be torn down by DAPM immediately but SYSCLK
> > will still be generated.
> =

> I need to think about this.
> Not sure how it will affect our system, if we do not have pmdown_time in =
the =

> future, when we add full ABE support.

pmdown_time is irrelevant here, it only inserts a delay in the sequence
so if it's not there the delay just goes to zero and the sequence of
events is the same but quicker.
