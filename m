From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 02/18] ASoC: omap-mcpdm: Assign the dai DMA
 data at earlier time
Date: Wed, 16 Apr 2014 13:25:31 +0300
Message-ID: <534E5A9B.4050900@ti.com>
References: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
 <1397640211-15447-3-git-send-email-peter.ujfalusi@ti.com>
 <20140416101535.GQ12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 65809265141
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 12:25:36 +0200 (CEST)
In-Reply-To: <20140416101535.GQ12304@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, notasas@gmail.com
List-Id: alsa-devel@alsa-project.org

On 04/16/2014 01:15 PM, Mark Brown wrote:
> On Wed, Apr 16, 2014 at 12:23:15PM +0300, Peter Ujfalusi wrote:
> =

>> -	snd_soc_dai_set_dma_data(dai, substream,
>> -				 &mcpdm->dma_data[substream->stream]);
>> -
>>  	return 0;
>>  }
>>  =

>> @@ -406,6 +403,10 @@ static int omap_mcpdm_probe(struct snd_soc_dai *dai)
>>  	mcpdm->config[SNDRV_PCM_STREAM_PLAYBACK].threshold =3D 2;
>>  	mcpdm->config[SNDRV_PCM_STREAM_CAPTURE].threshold =3D
>>  							MCPDM_UP_THRES_MAX - 3;
>> +
>> +	dai->playback_dma_data =3D &mcpdm->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
>> +	dai->capture_dma_data =3D &mcpdm->dma_data[SNDRV_PCM_STREAM_CAPTURE];
>> +
> =

> Any reason to stop using _set_dma_data()?

At dai driver probe we do not have substream and snd_soc_dai_set_dma_data()
relies on that (substream->stream) to figure out which dma_data to set.

This change is not a must for omap right now, but I have seen on davinci th=
at
we need to have the playback/capture_dma_data set at this time if we are us=
ing
the ASoC generic dmaengine pcm for platform (I use edma-pcm on davinci righ=
t now).

-- =

P=E9ter
