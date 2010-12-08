From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/2] ASoC: tlv320dac33: Move DACL/R power
	on to PGA widget
Date: Wed, 8 Dec 2010 15:52:36 +0200
Message-ID: <201012081552.37049.peter.ujfalusi@nokia.com>
References: <1291813977-17944-1-git-send-email-peter.ujfalusi@nokia.com>
	<1291813977-17944-2-git-send-email-peter.ujfalusi@nokia.com>
	<20101208134131.GK16418@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AB92103B50
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 14:52:48 +0100 (CET)
In-Reply-To: <20101208134131.GK16418@rakim.wolfsonmicro.main>
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

On Wednesday 08 December 2010 15:41:31 ext Mark Brown wrote:
> On Wed, Dec 08, 2010 at 03:12:57PM +0200, Peter Ujfalusi wrote:
> > +	SND_SOC_DAPM_PGA("Left DAC Power", DAC33_LDAC_PWR_CTRL, 2, 0, NULL, 0=
),
> > +	SND_SOC_DAPM_PGA("Right DAC Power", DAC33_RDAC_PWR_CTRL, 2, 0, NULL,
> > 0),
> =

> These feels like they should be supply widgets for the output amps?
> Might be a bit clearer.

Yes, somehow I tend to forgot about the DAPM_SUPPLY widget ;)

Thanks,
P=E9ter
