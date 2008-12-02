From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: ASoC: TWL4030 codec: Multiple DAC nameing
Date: Tue, 2 Dec 2008 12:33:07 +0200
Message-ID: <200812021233.08255.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id D8196245A5
	for <alsa-devel@alsa-project.org>; Tue,  2 Dec 2008 11:33:15 +0100 (CET)
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
To: alsa-devel@alsa-project.org
Cc: ext Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Hello,

Now I have some working prototype for the TWL4030 codec DAPM playback routi=
ng.
But before I send the patches I want to clear out something:
Since the TWL has four DACs and I want to map all of them, what would be th=
e =

correct SND_SOC_DAPM_DAC naming for them?

At the moment I have these:

/* DACs */
SND_SOC_DAPM_DAC("DACR1", "Right Front Playback",
		TWL4030_REG_AVDAC_CTL, 0, 0),
SND_SOC_DAPM_DAC("DACL1", "Left Front Playback",
		TWL4030_REG_AVDAC_CTL, 1, 0),
SND_SOC_DAPM_DAC("DACR2", "Right Rear Playback",
		TWL4030_REG_AVDAC_CTL, 2, 0),
SND_SOC_DAPM_DAC("DACL2", "Left Rear Playback",
		TWL4030_REG_AVDAC_CTL, 3, 0),

Are these are OK, or should I just use "Right Playback" for both DACR1 and =

DACR2?

Btw: the 'dynamic' routing and switching now works (no user visible power =

control for the DACs and APGAs) in a way, that if the output is configured =
to =

take the audio from one of the DAC, than the corresponding chain (APGA, DAC=
) =

will be powered on only.

Thanks,
P=E9ter
