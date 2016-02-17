From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [RFC v2 2/6] ALSA: pcm: add IEC958 channel status
	control helper
Date: Wed, 17 Feb 2016 10:07:49 +0100
Message-ID: <56C43865.9070008@st.com>
References: <1453484912-24547-1-git-send-email-arnaud.pouliquen@st.com>
 <1453484912-24547-3-git-send-email-arnaud.pouliquen@st.com>
 <20160217003145.GF19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D3D55265D9E
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 10:07:52 +0100 (CET)
In-Reply-To: <20160217003145.GF19428@n2100.arm.linux.org.uk>
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



On 02/17/2016 01:31 AM, Russell King - ARM Linux wrote:
> On Fri, Jan 22, 2016 at 06:48:28PM +0100, Arnaud Pouliquen wrote:
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
> I thought I had already commented about the mutex - maybe not.  Please
> don't make these conditional like this: if you need the mutex to
> eliminate a race condition, then you need it to eliminate the race
> condition and it can't be "optional".  Elimination of race conditions
> is never optional!
> 
> Please get rid of all these conditions and make it mandatory that a
> mutex is supplied.
> 
> Thanks.

Ok, i will suppress condition. I also need to use a spinlock instead of
the mutex, to be able to support race condition with atomic callbacks
(trigger, pointer, and ack)
