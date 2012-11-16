From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/2] pcm_pulse: set prebuf parameter
 according to software parameters
Date: Fri, 16 Nov 2012 17:35:58 +0100
Message-ID: <50A66B6E.7000100@canonical.com>
References: <201211142007.19751@leon.remlab.net>
 <1352916477-17552-2-git-send-email-remi@remlab.net>
 <50A4A103.1090802@canonical.com> <201211161749.59094@leon.remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id ECF9126509E
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2012 17:35:56 +0100 (CET)
In-Reply-To: <201211161749.59094@leon.remlab.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?R=E9mi_Denis-Courmont?= <remi@remlab.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/16/2012 04:49 PM, R=E9mi Denis-Courmont wrote:
> Le jeudi 15 novembre 2012 10:00:03, David Henningsson a =E9crit :
>> On 11/14/2012 07:07 PM, R=E9mi Denis-Courmont wrote:
>>> The current default value for prebuf is very high, almost the full
>>> virtual ALSA buffer. This breaks some application especially where
>>> low latency is involved.
>>>
>>> This patch makes pcm_pulse implement the sw_params callback and get
>>> the prebuf value from the ALSA software parameters. Thus the
>>> trigger latency is much more like what an ALSA application should
>>> expect from an ALSA PCM device.
>>
>> This seems reasonable I believe; see review comments below.
>>
>>> ---
>>>
>>>    pulse/pcm_pulse.c |   25 +++++++++++++++++++++++++
>>>    1 file changed, 25 insertions(+)
>>>
>>> diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
>>> index 0165120..08b6cea 100644
>>> --- a/pulse/pcm_pulse.c
>>> +++ b/pulse/pcm_pulse.c
>>> @@ -859,6 +859,30 @@ static int pulse_hw_params(snd_pcm_ioplug_t * io,
>>>
>>>    	return err;
>>>
>>>    }
>>>
>>> +static int pulse_sw_params(snd_pcm_ioplug_t *io, snd_pcm_sw_params_t
>>> *params) +{
>>> +	snd_pcm_pulse_t *pcm =3D io->private_data;
>>> +	snd_pcm_uframes_t start_threshold;
>>> +
>>> +	assert(pcm);
>>> +
>>> +	if (!pcm->p || !pcm->p->mainloop)
>>> +		return -EBADFD;
>>> +
>>> +	pa_threaded_mainloop_lock(pcm->p->mainloop);
>>> +
>>> +	snd_pcm_sw_params_get_start_threshold(params, &start_threshold);
>>> +
>>> +	if (start_threshold < io->period_size)
>>> +		start_threshold =3D io->period_size;
>>
>> Why do we need the above constraint?
>
> In my experience, PulseAudio really does not like having less than a peri=
od
> worth of buffered samples. I guess the code assumes there is always at le=
ast
> that much, and may underrun if not.
>
> But sure enough, we could remove the constraint and blame the ALSA applic=
ation
> for using inadequate parameters if a problem occurs. What do you prefer?

Assuming you're right about the almost-empty buffer being subject to =

"false underruns" (which, IIRC I confirmed a while ago), probably just a =

comment explaining why we need it or so. I didn't know that the limit =

was one period_size though.


-- =

David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
