From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 4/4] ASoC: tlv320dac33: Support for turning
	off the codec in BIAS_STANDBY
Date: Fri, 30 Apr 2010 14:42:32 +0300
Message-ID: <201004301442.32581.peter.ujfalusi@nokia.com>
References: <1272612715-13387-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100430102309.GD21607@sirena.org.uk>
	<201004301355.25797.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C7A7103912
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 13:43:17 +0200 (CEST)
In-Reply-To: <201004301355.25797.peter.ujfalusi@nokia.com>
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
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Friday 30 April 2010 13:55:25 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> =

> Now, if I use DAPM_SUPPLY attached to the DAC:
> If the codec has been brought up because the loopback is enabled, than the
> dac33_prepare_chip will be called twice: once from dac33_pcm_prepare, and
> then from the SUPPLY event.
> This might be also the case if I use the post-DAPM prepare (or pre)

And I admit that you are actually right (and I was wrong) :D

By adding SND_SOC_DAPM_PRE widget to a codec, and move the former content o=
f =

dac33_pcm_prepare function to PRE_PMU event works like charm.

It is called all the time, when the stream starts/restarts.
So I'll get rid of the dac33_pcm_prepare, and clean up the dac33_set_bias_l=
evel, =

and resubmit the series.

Thank you Mark for guiding me to the correct direction!

-- =

P=E9ter
