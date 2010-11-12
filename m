From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: mapping externally allocated Scatter Gather DMA
 buffers
Date: Fri, 12 Nov 2010 09:05:26 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011120902590.29422@eeebox2.perex-int.cz>
References: <AANLkTik4VQmsvBiXyoj-wEu5jgjpPVRP0bF7gkp9GJ-E@mail.gmail.com>
	<AANLkTikHL5-6nuf6_sbkAX+y_vUo57tF-SW_j75ijEPJ@mail.gmail.com>
	<alpine.LNX.2.00.1011091530230.29422@eeebox2.perex-int.cz>
	<AANLkTimTrFLv911vVm-eH9EqDyXEwg-y4uFkqbUyVB7v@mail.gmail.com>
	<alpine.LNX.2.00.1011100755560.29422@eeebox2.perex-int.cz>
	<AANLkTi=2pO+x=Okt8RXPJe2TqGexEX70oMCFAtBAkm2U@mail.gmail.com>
	<alpine.LNX.2.00.1011101228061.29422@eeebox2.perex-int.cz>
	<AANLkTim=NT4cPQV+c3Y7eZF81Pv6R--vRgT_jGj7xZQJ@mail.gmail.com>
	<alpine.LNX.2.00.1011101515420.29422@eeebox2.perex-int.cz>
	<AANLkTi=gjN1xfnMZ4R29Sq_=fxYAfJwOQmD_+6beLYSp@mail.gmail.com>
	<alpine.LNX.2.00.1011101859010.29422@eeebox2.perex-int.cz>
	<AANLkTimXTdWRrdA8+ToQp-gPofKohaSJ_Ss5x4S42uo5@mail.gmail.com>
	<alpine.LNX.2.00.1011111113030.29422@eeebox2.perex-int.cz>
	<AANLkTi=g5LR=wm8B7jKy6kHFUjZHzt3NdZD8s3reVMbJ@mail.gmail.com>
	<AANLkTinRzLNTxZCO6eaAxN-=NATnVSHn1jamr2n8EFDT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1783002930-1289549126=:29422"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 36880103815
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 09:05:27 +0100 (CET)
In-Reply-To: <AANLkTinRzLNTxZCO6eaAxN-=NATnVSHn1jamr2n8EFDT@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manu Abraham <abraham.manu@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1783002930-1289549126=:29422
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 12 Nov 2010, Manu Abraham wrote:

> On Thu, Nov 11, 2010 at 6:04 PM, Manu Abraham <abraham.manu@gmail.com> wr=
ote:
>> On Thu, Nov 11, 2010 at 4:00 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>>> On Thu, 11 Nov 2010, Manu Abraham wrote:
>>>
>>>> On Wed, Nov 10, 2010 at 11:35 PM, Jaroslav Kysela <perex@perex.cz> wro=
te:
>>
>>>>
>>>> I adapted the whole thing to make the buffersize divided amongst the
>>>> XS2D_BUFFERS (8):
>>>
>>> Probably yes.
>>>
>>>> I hope the mapping of the buffers is okay ? It looks thus, now ..
>>>
>>> From information you sent me about hw privately, I think that the
>>> period_bytes must be 4096 or multiple of this value with minumum count =
of
>>> periods 8 (or multiple of 8). Otherwise you get a non-continuous memory=
 area
>>> (the hw uses only portion of system memory page, thus there'll be gaps)=
=2E The
>>> problem is that we have MMAP_COMPLEX mode, but no application can handl=
e
>>> (does not implement) this mmap mode and I'm not sure, if we can even
>>> describe the DMA buffer size layout for this case for your specific hw.
>>>
>>> I would use:
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0snd_pcm_hw_constraint_step(runtime, 0,
>>> SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04096);
>>>
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0snd_pcm_hw_constraint_step(runtime, 0, SNDRV=
_PCM_HW_PARAM_PERIODS,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8);
>>>
>>> And define periods_min =3D 8 (max to multiple 8 - choose your max limit=
) and
>>> period_bytes_min to 4096 (max to multiple 4096 - choose your max limit)=
=2E
>>>
>>> Note that -EIO means that your driver does not called
>>> snd_pcm_period_elapsed() and/or the pointer callback returns wrong posi=
tion
>>> to the audio ring buffer.
>>
>>
>>
>> Ok, modified it, also added in code to acquire the stream, It's a bit
>> more complete now.
>> The crazy part that I do see now, is that I see an inconsistent lock
>> state with the hda_intel
>> driver which is the soundcard on my system. But I don't understand why
>> the locking on it
>> has to become inconsistent on loading this driver.
>
>
> Ok, I found the reason: I was passing a single page for the
> page_table, which I guess corrupted the whole stack !!
>
> Eventually, I fixed the same. but ran into another issue ? Should
> trigger not sleep or something that way ?
> Currently, I see the issue as follows in the log, but if the
> ops->run() callback is commented out I don't get that
> weird message/error about lock states.
>
> Now, ops->run(), ie xs2dtl_run() is called with other other streams,
> such as an MPEG stream, where it doesn't
> show any issues.
>
> Any idea, why uncommenting ops->run() produces that message ? Should
> trigger not sleep ? Confused ...

Trigger must be fast without any sleeping. Only fast spinlocks are=20
allowed. If you need sleep, just activate a tasklet and do the start job=20
in the tasklet or a thread.

 =09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-1783002930-1289549126=:29422
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-1783002930-1289549126=:29422--
