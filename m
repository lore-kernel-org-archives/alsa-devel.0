From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 11/14] ASoC: SOF: Add PM support
Date: Wed, 12 Dec 2018 10:08:01 -0600
Message-ID: <11a26786-7d1a-02d6-4217-4780edbc2911@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-12-pierre-louis.bossart@linux.intel.com>
 <s5hsgz3j809.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hsgz3j809.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, alsa-devel@alsa-project.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


On 12/12/18 5:32 AM, Takashi Iwai wrote:
> On Tue, 11 Dec 2018 22:23:15 +0100,
> Pierre-Louis Bossart wrote:
>> +#define RUNTIME_PM 1
> What's this?  This seems used in snd_soc_runtime_suspend() and
> _resume().  But it's a just normal boolean flag, no?

yes, it's useless. I saw it in one of my checks and forgot about it, 
will fix.

>
>> +static void sof_suspend_streams(struct snd_sof_dev *sdev)
>> +{
>> +	struct snd_sof_pcm *spcm;
>> +	struct snd_pcm_substream *substream;
>> +	int dir;
>> +
>> +	/* suspend all running streams */
>> +	list_for_each_entry(spcm, &sdev->pcm_list, list) {
>> +
>> +		mutex_lock(&spcm->mutex);
>> +
>> +		/* suspend running playback stream */
>> +		dir = SNDRV_PCM_STREAM_PLAYBACK;
>> +		substream = spcm->stream[dir].substream;
>> +
>> +		if (substream && substream->runtime) {
>> +
>> +			snd_pcm_suspend(substream);
>> +
>> +			/*
>> +			 * set restore_stream so that hw_params can be
>> +			 * restored during resume
>> +			 */
>> +			spcm->restore_stream[dir] = 1;
>> +		}
>> +
>> +		/* suspend running capture stream */
>> +		dir = SNDRV_PCM_STREAM_CAPTURE;
>> +		substream = spcm->stream[dir].substream;
>> +
>> +		if (substream && substream->runtime) {
>> +
>> +			snd_pcm_suspend(substream);
>> +
>> +			/*
>> +			 * set restore_stream so that hw_params can be
>> +			 * restored during resume
>> +			 */
>> +			spcm->restore_stream[dir] = 1;
>> +		}
> Both playback and capture do the same thing, so this can be a loop of
> dir.
yes, valid point, will fix.
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
