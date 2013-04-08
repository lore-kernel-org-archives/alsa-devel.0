From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH] ALSA: hda - Apply codec delay to wallclock.
Date: Mon, 8 Apr 2013 08:44:12 -0700
Message-ID: <CAEUnVG4Emisk+hYHmZD4WbvSRPqpEQu3aekCD71O6JEztWGjPw@mail.gmail.com>
References: <1365207724-6288-1-git-send-email-dgreid@chromium.org>
 <s5hehem3i09.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 48CBA265B63
 for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2013 17:44:33 +0200 (CEST)
Received: by mail-ee0-f51.google.com with SMTP id c4so2373721eek.38
 for <alsa-devel@alsa-project.org>; Mon, 08 Apr 2013 08:44:33 -0700 (PDT)
In-Reply-To: <s5hehem3i09.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 7, 2013 at 12:41 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri,  5 Apr 2013 17:22:04 -0700,
> Dylan Reid wrote:
>>
>> For playback add the codec-side delay to the timestamp, for capture
>> subtract it.  This brings the timestamps in line with the time that
>> was recently added to the delay reporting.
>>
>> Signed-off-by: Dylan Reid <dgreid@chromium.org>
>> ---
>>  sound/pci/hda/hda_intel.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 735567e..ec8ac71 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -1889,6 +1889,27 @@ static void azx_timecounter_init(struct snd_pcm_substream *substream,
>>               tc->cycle_last = last;
>>  }
>>
>> +static u64 azx_add_codec_delay_nsec(struct snd_pcm_substream *substream,
>> +                             u64 nsec)
>> +{
>> +     struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
>> +     int stream = substream->stream;
>> +     struct hda_pcm_stream *hinfo = apcm->hinfo[stream];
>> +     struct hda_codec *codec = apcm->codec;
>> +     u64 codec_nsec;
>> +
>> +     if (hinfo->ops.get_delay) {
>> +             codec_nsec =
>> +                     hinfo->ops.get_delay(hinfo, codec, substream) * 1000000;
>> +             if (stream == SNDRV_PCM_STREAM_CAPTURE)
>> +                     nsec = (nsec > codec_nsec) ? nsec - codec_nsec : 0;
>> +             else if (stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +                     nsec += codec_nsec;
>
> I think the compensation is applied in a wrong direction.
>
> For the playback, the wallclock indicates the timestamp corresponding
> to the position currently being played.  With the codec delay, the
> position is back more, i.e. the timestamp has to be subtracted.
>

OK, I was thinking of the timestamp as the wall time when the next
sample will be played.  If it represents the time the currently
rendered sample was fed into the pipeline, this makes sense, I'll
change it to subtract for output.  In this case, what does it mean for
input?  I was thinking of it as the time the sample was converted by
the A-to-D.

Thanks,

-dg

>
> Takashi
>
>> +     }
>> +
>> +     return nsec;
>> +}
>> +
>>  static int azx_get_wallclock_tstamp(struct snd_pcm_substream *substream,
>>                               struct timespec *ts)
>>  {
>> @@ -1897,6 +1918,7 @@ static int azx_get_wallclock_tstamp(struct snd_pcm_substream *substream,
>>
>>       nsec = timecounter_read(&azx_dev->azx_tc);
>>       nsec = div_u64(nsec, 3); /* can be optimized */
>> +     nsec = azx_add_codec_delay_nsec(substream, nsec);
>>
>>       *ts = ns_to_timespec(nsec);
>>
>> --
>> 1.8.1.3.605.g02339dd
>>
