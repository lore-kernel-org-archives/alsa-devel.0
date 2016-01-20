From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [RFC 2/6] ALSA: pcm: add IEC958 channel status
	control helper
Date: Wed, 20 Jan 2016 15:16:04 +0100
Message-ID: <569F96A4.5060200@st.com>
References: <1453210836-16218-1-git-send-email-arnaud.pouliquen@st.com>
 <1453210836-16218-3-git-send-email-arnaud.pouliquen@st.com>
 <20160119170048.GO19062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D36D2605F1
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 15:16:09 +0100 (CET)
In-Reply-To: <20160119170048.GO19062@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org



On 01/19/2016 06:00 PM, Russell King - ARM Linux wrote:
> On Tue, Jan 19, 2016 at 02:40:32PM +0100, Arnaud Pouliquen wrote:

>> +static int snd_pcm_iec958_get(struct snd_kcontrol *kcontrol,
>> +			      struct snd_ctl_elem_value *uctl)
>> +{
>> +	struct snd_pcm_iec958_params *params = snd_kcontrol_chip(kcontrol);
>> +
>> +	if (params->mutex)
>> +		mutex_unlock(params->mutex);
>> +	uctl->value.iec958.status[0] = params->iec->status[0];
>> +	uctl->value.iec958.status[1] = params->iec->status[1];
>> +	uctl->value.iec958.status[2] = params->iec->status[2];
>> +	uctl->value.iec958.status[3] = params->iec->status[3];
>> +	uctl->value.iec958.status[4] = params->iec->status[4];
>> +	if (params->mutex)
>> +		mutex_unlock(params->mutex);
> 
> I'm not sure it makes sense for the mutex to be optional.
I have no use case in mind that justifies optional mutex.
Just did it for flexibility...
I can suppress condition to force drivers to use it.

> 
>> +	return 0;
>> +}
>> +
>> +static int snd_pcm_iec958_put(struct snd_kcontrol *kcontrol,
>> +			      struct snd_ctl_elem_value *uctl)
>> +{
>> +	struct snd_pcm_iec958_params *params = snd_kcontrol_chip(kcontrol);
>> +	int err = 0;
>> +
>> +	if (params->mutex)
>> +		mutex_lock(params->mutex);
>> +	if (params->ctrl_set)
>> +		err = params->ctrl_set(params->pdata,
>> +				       uctl->value.iec958.status, 5);
>> +	if (!err) {
>> +		params->iec->status[0] = uctl->value.iec958.status[0];
>> +		params->iec->status[1] = uctl->value.iec958.status[1];
>> +		params->iec->status[2] = uctl->value.iec958.status[2];
>> +		params->iec->status[3] = uctl->value.iec958.status[3];
>> +		params->iec->status[4] = uctl->value.iec958.status[4];
>> +	}
>> +	if (params->mutex)
>> +		mutex_unlock(params->mutex);
>> +
>> +	return 0;
> 
> I think you're supposed to report whether anything changed, rather
> than just zero on success.
right, need to return 1 or err
> 
>> +}
>> +
>> +static const struct snd_kcontrol_new iec958_ctls[] = {
>> +	{
>> +		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
>> +		.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
> 
> Shouldn't this have a .access member?  What if the audio driver
> modifies the IEC958 status for PCM playback - shouldn't it have
> the ability to have SNDRV_CTL_ELEM_ACCESS_VOLATILE added?
> 
i will add READ + VOLATILE access for capture, RW +VOLATILE access for
playback.
Should i also add some other controls by default, like controls for
consumer and professional mask for playback?
