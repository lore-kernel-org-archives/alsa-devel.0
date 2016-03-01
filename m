From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v3 1/4] ALSA: pcm: add IEC958 channel
 status control helper
Date: Tue, 1 Mar 2016 11:46:54 +0100
Message-ID: <56D5731E.102@st.com>
References: <1456820357-2545-1-git-send-email-arnaud.pouliquen@st.com>
 <1456820357-2545-2-git-send-email-arnaud.pouliquen@st.com>
 <s5hoaaywoi0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id D69A8261546
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 11:46:59 +0100 (CET)
In-Reply-To: <s5hoaaywoi0.wl-tiwai@suse.de>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Moise GERGAUD <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org



On 03/01/2016 10:12 AM, Takashi Iwai wrote:
> On Tue, 01 Mar 2016 09:19:14 +0100,
> Arnaud Pouliquen wrote:
>>
>> Add IEC958 channel status helper that creates control to handle the
>> IEC60958 status bits.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> 
> What is the reason to make the mutex pointer instead of the own one?
> Any need for sharing the mutex?
Yes, need to share mutex to avoid race condition between control update
and action on pcm stream ( hw_param or prepare)
> 
> And, if it has to be assigned explicitly by user, you have to write it
> explicitly, too.
ok, if not enough explicit, i will add comment in snd_pcm_iec958_params
definition
> 
> Another small nitpicking:

>> +static int snd_pcm_iec958_put(struct snd_kcontrol *kcontrol,
>> +			      struct snd_ctl_elem_value *uctl)
>> +{
>> +	struct snd_pcm_iec958_params *params = snd_kcontrol_chip(kcontrol);
>> +	int err = 0;
>> +
>> +	if (!params->mutex)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(params->mutex);
>> +	if (params->ctrl_set)
>> +		err = params->ctrl_set(params->pdata,
>> +				       uctl->value.iec958.status);
> 
> So, in your design, ctrl_set isn't mandatory?
Hypothesis is that for some hardwares, callback is not
needed, only channels status values are needed. As example
some hardwares could not want to support switch from audio to none-audio
mode without stopping PCM.

> 
>> +int snd_pcm_create_iec958_ctl(struct snd_pcm *pcm,
>> +			      struct snd_pcm_iec958_params *params, int stream)
>> +{
>> +	struct snd_kcontrol_new knew;
>> +
>> +	if (stream > SNDRV_PCM_STREAM_LAST)
>> +		return -EINVAL;
>> +
>> +	knew = iec958_ctls[stream];
>> +	knew.device = pcm->device;
>> +	knew.index = pcm->device;
>> +	knew.count = pcm->streams[stream].substream_count;
> 
> Hmm, this doesn't always work.  It will create the substream_count
> ctls starting from the pcm dev# as index.  What if there are 2 PCM
> devices where both contain 4 substreams?
> 
> I admit that the current ctl <-> PCM mapping is messing.  There are
> some heuristics and you're trying to follow that.  But blindly
> applying to all cases doesn't seem to work.
> 
yes this is not clean.
i'm not very familiar with substream usage, so any suggestion is welcome.
The only use case I have in mind is a HDMI connected through 4  I2S data
wire...
I can see 2 options:
- Associate control only to pcm device.
- Create a control per sub-device

Do we really need to associate one IEC control per substream?

Thanks
Arnaud
