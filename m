From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [pulseaudio-discuss] pulseaudio fails to start
 with kernel 4.11, caused by new snd_hdmi_lpe_audio module)
Date: Fri, 24 Mar 2017 23:01:47 +0100
Message-ID: <30b18b96-eaa4-70e0-522d-dc8237d25642@redhat.com>
References: <2549c113-f06b-f22e-d36e-f59fc2969bcb@redhat.com>
 <s5h8to0w4fs.wl-tiwai@suse.de>
 <6754b5cd-f6d0-e2e3-0f01-992946ec1b92@linux.intel.com>
 <s5hk27jjigd.wl-tiwai@suse.de>
 <1490082870.1321124.918129488.4F3143F8@webmail.messagingengine.com>
 <bba100b1-5e74-093a-7625-a7feaba1a065@redhat.com>
 <b693d927-229e-e00a-ada5-29d12154547b@linux.intel.com>
 <s5hvar0fjzf.wl-tiwai@suse.de> <1490379539.24554.2.camel@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 86038266927
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 23:01:51 +0100 (CET)
In-Reply-To: <1490379539.24554.2.camel@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tanu Kaskinen <tanuk@iki.fi>, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 03/24/2017 07:18 PM, Tanu Kaskinen wrote:
> On Thu, 2017-03-23 at 09:57 +0100, Takashi Iwai wrote:
>> On Thu, 23 Mar 2017 04:16:52 +0100,
>> Pierre-Louis Bossart wrote:
>>>
>>> On 3/21/17 2:56 AM, Hans de Goede wrote:
>>>> I: [pulseaudio] alsa-sink.c: Using 1.0 fragments of size 352832 bytes
>>>> (2000.18ms), buffer size is 352832 bytes (2000.18ms)
>>>> I: [pulseaudio] alsa-sink.c: Time scheduling watermark is 20.00ms
>>>> I: [pulseaudio] alsa-sink.c: Driver does not support hardware volume
>>>> control, falling back to software volume control.
>>>> I: [pulseaudio] alsa-sink.c: Driver does not support hardware mute
>>>> control, falling back to software mute control.
>>>> I: [alsa-sink-HdmiLpeAudio] core-util.c: Successfully enabled SCHED_RR
>>>> scheduling for thread, with priority 5.
>>>> I: [alsa-sink-HdmiLpeAudio] alsa-sink.c: Starting playback.
>>>> I: [alsa-sink-HdmiLpeAudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HWSYNC
>>>> failed (-32)
>>>
>>> Humm, single period and hw_sync failed, this could be testing the
>>> robustness of the single-period code and its mapping on multiple DMA
>>> descriptors? I haven't looked at the alsa module in eons but can't the
>>> number of periods be forced to two with module parameters while
>>> keeping the timer-based schedulng?
>
> I think the code doesn't currently support this.
>
>> It's -EPIPE and this is supposed to be the intentional error code from
>> HDMI LPE audio driver.  The streaming doesn't work when the gfx is
>> disconnected or the monitor audio is off.  It accepts the open, but it
>> returns -EPIPE for further accesses.
>>
>> Maybe -EPIPE is no sensible choice, but the problem is that the driver
>> can't use the PCM DISCONNECT state because PA interprets it being the
>> complete disconnection of the card object instead of a temporary
>> disablement of PCM.
>
> So is this a PulseAudio bug?
>
> I: [alsa-sink-HdmiLpeAudio] alsa-sink.c: Starting playback.
> I: [alsa-sink-HdmiLpeAudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HWSYNC failed (-32)
>
> The "Starting playback" message is printed just before the
> snd_pcm_start() call. PulseAudio doesn't check the return value of
> snd_pcm_start(), but maybe it should? Does the HWSYNC happen in
> snd_pcm_start()?
>
> Can this EPIPE thing happen also during playback, not just when
> starting?

So is this the likely cause of the RT code killing pa, or do you
still need me to gather perf output ?

Regards,

Hans
