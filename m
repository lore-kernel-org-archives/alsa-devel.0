From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 6/6] ASoC: Beagle: Add support for 4
	channel mode
Date: Tue, 7 Apr 2009 07:45:31 +0300
Message-ID: <200904070745.31538.peter.ujfalusi@nokia.com>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-7-git-send-email-peter.ujfalusi@nokia.com>
	<20090406125028.GB14169@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 224862441A
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Apr 2009 06:45:49 +0200 (CEST)
In-Reply-To: <20090406125028.GB14169@sirena.org.uk>
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Monday 06 April 2009 15:50:29 ext Mark Brown wrote:
> On Mon, Apr 06, 2009 at 03:19:32PM +0300, Peter Ujfalusi wrote:
> > +	switch (params_channels(params)) {
> > +	case 2: /* Stereo I2S mode */
> > +		fmt =3D	SND_SOC_DAIFMT_I2S |
> > +			SND_SOC_DAIFMT_NB_NF |
> > +			SND_SOC_DAIFMT_CBM_CFM;
> > +		break;
> > +	case 4: /* Four channel TDM mode */
> > +		fmt =3D	SND_SOC_DAIFMT_DSP_A |
>
> Might it not be easier to just run in DSP mode all the time?

The reason for this is the fact that twl4030 in TDM mode only supports 4. =

channel.

The Audio interface has three modes:
codec mode (i2s) - Stereo
Left-justified   - Stereo
Right-justified  - Stereo
TDM              - 4 channels

-- =

P=E9ter
