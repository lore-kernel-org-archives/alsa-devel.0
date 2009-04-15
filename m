From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 05/14] ASoC: Provide core support for
	symmetric sample rates
Date: Wed, 15 Apr 2009 09:31:46 +0300
Message-ID: <200904150931.47272.peter.ujfalusi@nokia.com>
References: <20090414123220.GA6342@rakim.wolfsonmicro.main>
	<1239712393-6428-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 47C272435D
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 08:32:19 +0200 (CEST)
In-Reply-To: <1239712393-6428-6-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 14 April 2009 15:33:04 ext Mark Brown wrote:
> Many devices require symmetric configurations of capture and playback
> data formats, often due to shared clocking but sometimes also due to
> other shared playback and record configuration in the device. Start
> providing core support for this by allowing the DAIs or the machine
> to specify that the sample rates used should be kept symmetric.
>
> A flag symmetric_rates is provided in the snd_soc_dai and
> snd_soc_dai_link structures. If this is set in either of the DAIs or in
> the machine then a constraint will be applied when a stream is already
> open preventing any changes in sample rate.
>
> +
> +		ret =3D snd_pcm_hw_constraint_minmax(substream->runtime,
> +						   SNDRV_PCM_HW_PARAM_RATE,
> +						   machine->rate,
> +						   machine->rate);

Would it make sense to add also the channel count and probably sample_bits =
as =

constraint as well here?
I think the symmetric means that you should not be able to change any of th=
e =

parameters.

-- =

P=E9ter
