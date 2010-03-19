From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add support for Left
	Justified format
Date: Fri, 19 Mar 2010 12:00:03 +0200
Message-ID: <201003191200.03750.peter.ujfalusi@nokia.com>
References: <1268989879-18303-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100319112854.99c1f692.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id B78642434C
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 11:00:27 +0100 (CET)
In-Reply-To: <20100319112854.99c1f692.jhnikula@gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Friday 19 March 2010 11:28:54 ext Jarkko Nikula wrote:
> On Fri, 19 Mar 2010 11:11:19 +0200
> =

> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> > Basic support for Left Justified coding for OMAP McBSP.
> > =

> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > ---
> > =

> >  sound/soc/omap/omap-mcbsp.c |   10 +++++++++-
> >  1 files changed, 9 insertions(+), 1 deletions(-)
> =

> I don't point it out immediately but is the FS polarity correct?
> According to WM8772 spec, the left/right justified modes has inverted
> FS polarity from I2S.

Yes, that is correct, and I'm aware of that.
However, I have done some testing:
I have a sample prepared, which only has data on the left channel, than I d=
id =

tried I2S and LEFT_J...

With:
/* I2S mode */
fmt =3D	SND_SOC_DAIFMT_I2S |
		SND_SOC_DAIFMT_NB_NF |
		SND_SOC_DAIFMT_CBM_CFM;

The data line has data when the FS is low (when FS is high, that data line =
has =

0). So this is correct I2S.

Now with:
/* Left justified */
fmt =3D	SND_SOC_DAIFMT_LEFT_J |
		SND_SOC_DAIFMT_NB_IF |
 		SND_SOC_DAIFMT_CBM_CFM;

The data line has data when the FS is high (when FS is low, that data line =
has =

0). So this is correct Left Justified.

At least it seams that McBSP is actually shifting out the data at the corre=
ct =

place, when it is slave..

Oh, and I can not explain why this is working, but I do trust on my scope, =
and =

it shows me that it is correct :o

-- =

P=E9ter
