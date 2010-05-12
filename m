From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/5] allow up to 32 PCM devices
Date: Wed, 12 May 2010 11:49:01 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005121148100.6856@eeebox2.perex-int.cz>
References: <20100512013015.752623810@intel.com>
	<20100512015713.762299923@intel.com>
	<alpine.LNX.2.00.1005120925400.6856@eeebox2.perex-int.cz>
	<s5htyqdsg0w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 2782E103881
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 11:49:02 +0200 (CEST)
In-Reply-To: <s5htyqdsg0w.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 12 May 2010, Takashi Iwai wrote:

> At Wed, 12 May 2010 09:29:57 +0200 (CEST),
> Jaroslav Kysela wrote:
>>
>> On Wed, 12 May 2010, Wu Fengguang wrote:
>>
>>> Reserve 32 minor numbers for PCM playback devices.
>>>
>>> The Intel SandyBridge HDMI audio codec provides 3 PCM devices with
>>> indices 3, 7, 8. Among which the device 8's minor number will be
>>> overlapped with the first capture device's minor number in the current
>>> static minor number allocation scheme.
>>>
>>> Also increase SNDRV_PCM_DEVICES to make pcm_dev_bits big enough to hold
>>> the increasing number of PCM devices.
>>
>> I don't agree to have only 4 slots for soundcards in the static minor
>> numbering. Maybe the driver should be converted to use subdevices or we
>> might drop the static minor number allocation at all (it might have only
>> impact for old distros).
>
> Dropping such a base feature is really no good option.  Better to give
> simply an error for more than 8 PCMs in such a case, IMO.
>
> I also wonder whether having 4 individual PCMs is a way to go.  We may
> have PCM substreams, if any.  OTOH, the current IEC958 stream

Yes, I noted this above.

> assignment mechanism doesn't consider multiple substreams well, e.g.
> we have no proper way to match the IEC958 status bits control to a PCM
> substream.

We have subdevice member in snd_ctl_elem_id, so I don't see a problem.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
