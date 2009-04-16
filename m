From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re:
 =?iso-8859-1?q?=5B2=2E6=2E30-rc2=5D=5BPATCH_1/2=5D_A?=
 =?iso-8859-1?q?SoC=3A_OMAP=3A_Fix_DSP=5FB_format_=09in_OMAP_McBSP_DAI_dri?=
 =?iso-8859-1?q?ver?=
Date: Thu, 16 Apr 2009 16:42:07 +0300
Message-ID: <200904161642.07406.peter.ujfalusi@nokia.com>
References: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
	<200904161427.30707.peter.ujfalusi@nokia.com>
	<dfeb90390904160605m478dbf66yf78a0c012c2efc58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E001243A9
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 15:42:54 +0200 (CEST)
In-Reply-To: <dfeb90390904160605m478dbf66yf78a0c012c2efc58@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Arun KS <getarunks@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>, ext Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thursday 16 April 2009 16:05:34 ext Arun KS wrote:
>
> Your patches are working.
> I tested for DSP_A and DSP_B. Both works fine on osk5912 board.

Thank you very much for testing it!

> But when I2S is used there is no audio on Right channel(left channel
> is working fine).
> Thinks something is missing on tlv320aic23 driver.

I have tested the patch, which changes the way how the I2S mode is configur=
ed =

and it was working. Also the end result is the same in I2S mode as it was =

before...
And an obvious question: was the I2S mode worked before my patches?

I suppose you used the SND_SOC_DAIFMT_NB_NF with the I2S mode as well (whic=
h =

should be the correct one)?

> Arun

-- =

P=E9ter
