From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: ASoC: SND_SOC_DAPM_LINE behavior
Date: Tue, 29 Sep 2009 15:36:39 +0300
Message-ID: <200909291536.39792.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 5130F10387C
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Sep 2009 14:36:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hello,

as I'm writing a new codec driver I have noticed the following (using 2.6.3=
1 =

kernel).

The codec itself is really simple, it is only capable of playback and it ca=
n =

bypass audio from line-in to the output.
The DAPM routing is something like this in the codec driver:

|DAC|------------->|              |              =

                   |Playback Mixer|->|OUTPUT|
|INPUT|->|Bypass|->|              |
         |SWITCH|

Now if in the machine driver I create the following DAPM widget:
SND_SOC_DAPM_LINE("Line In", NULL),

and than connect this DAPM_LINE to the codec's INPUT (LINE-IN):
{"LINE-IN", NULL, "Line In"},

Than the codec bias level would be always in ON state, regardless of the st=
ate =

of the Bypass Switch (it is off by default).
I can use the snd_soc_dapm_disable_pin(codec, "Line In") in the machine dri=
ver =

to disable the pin, which moves the codec to STANDBY state.

Now, if I change the SND_SOC_DAPM_LINE to
SND_SOC_DAPM_MIC("Line In", NULL),
in the machine driver, than the codec bias would be STANDBY as long as the =

Bypass switches are off, if they changed to on, than the codec bias goes to=
 ON, =

as expected.

Is this expected behavior?

-- =

P=E9ter
