From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Ambiguous DAPM widget names and DPCM
Date: Fri, 26 Jul 2013 11:13:17 +0200
Message-ID: <51F23DAD.70305@ti.com>
References: <51EE3F18.3030207@gmail.com> <20130723123017.GV9858@sirena.org.uk>
 <51EEA2A3.8030106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 87108265698
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 11:13:20 +0200 (CEST)
In-Reply-To: <51EEA2A3.8030106@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/23/2013 05:34 PM, Daniel Mack wrote:
> With printk() in snd_soc_dapm_new_control(), I see the following widgets
> being created during boot (one pair for each Codec, and two pairs for
> the platform dai):
> =

> [    1.963501]  snd_soc_dapm_new_control() ceb6b680 name Playback
> [    1.971739]  snd_soc_dapm_new_control() ceb6b5c0 name Capture
> [    1.996001]  snd_soc_dapm_new_control() ceb6b500 name Playback
> [    2.004354]  snd_soc_dapm_new_control() ceb6b440 name Capture
> [    2.019684]  snd_soc_dapm_new_control() ceb6b380 name Playback
> [    2.028053]  snd_soc_dapm_new_control() ceb6b2c0 name Capture
> [    2.047526]  snd_soc_dapm_new_control() ceb6b200 name Playback
> [    2.055846]  snd_soc_dapm_new_control() ceb6b140 name Capture
> [    2.071168]  snd_soc_dapm_new_control() ceb6b080 name Playback
> [    2.079461]  snd_soc_dapm_new_control() ceb8ff00 name Capture

Can you print these with dev_err(dapm->dev, ...); so we can see the context
where it is going to be added?
It might worth asking the core to prefix the codecs DAPM, so you avoid name
duplication on the same context.
Both cs4271 and ak4101 have 'Playback'/'Capture' names for the streams.

BTW: do you see error messages about name duplication ("widget %s already
exists for context\n")? Or warning about already existing debugfs entries f=
rom
DAPM?

-- =

P=E9ter
