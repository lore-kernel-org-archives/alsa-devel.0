From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: tlv320dac33: Control for line output
	gain
Date: Wed, 13 Oct 2010 11:40:26 +0300
Message-ID: <201010131140.26724.peter.ujfalusi@nokia.com>
References: <1286957298-28615-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101013081402.GB6424@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 285621039FB
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 10:40:52 +0200 (CEST)
In-Reply-To: <20101013081402.GB6424@rakim.wolfsonmicro.main>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wednesday 13 October 2010 11:14:03 ext Mark Brown wrote:
> On Wed, Oct 13, 2010 at 11:08:18AM +0300, Peter Ujfalusi wrote:
> > +/* L/R Line Output Gain */
> > +static const char *lr_lineout_gain_texts[] =3D {
> > +	"Line 0.25V/V DAC 1V/V", "Line 0.5V/V DAC 2V/V",
> > +	"Line 1V/V DAC 4V/V", "Line 2V/V DAC 8V/V",
> > +};
> =

> I'm having a hard time parsing what these actually mean so I'm guessing
> users are going to have trouble also - is there anything that could be
> done to make things clearer?

In the documentation these gains are described like that (0.25V.V / 1V/V), =
and I =

wanted to use the same in the enum elements, but what about:

/* L/R Line Output Gain */
static const char *lr_lineout_gain_texts[] =3D {
       "Line -12dB DAC 0dB", "Line -6dB DAC 6dB",
       "Line 0dB DAC 12dB", "Line 6dB DAC 18dB",
};

Value 0 in the registers mean:
linein-to-lineout gain 0.25V/V (-12dB)
dac-to-lineout gain 1V/V (0dB)

Value 1 in the registers mean:
linein-to-lineout gain 0.5V/V (-6dB)
dac-to-lineout gain 2V/V (6dB)

What do you think?

-- =

P=E9ter
