From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 04/14] ASoC: SOF: Add support for IPC IO
 between DSP and Host
Date: Tue, 22 Jan 2019 15:05:23 -0600
Message-ID: <c4555b61-249c-7c7e-65ed-426e4be32309@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-5-pierre-louis.bossart@linux.intel.com>
 <20190109203720.GQ10405@sirena.org.uk>
 <876df209-c829-873e-047e-c73fb0579d68@linux.intel.com>
 <20190122190425.GJ7579@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190122190425.GJ7579@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, tiwai@suse.de, Jie Yang <yang.jie@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 1/22/19 1:04 PM, Mark Brown wrote:
> On Thu, Jan 10, 2019 at 02:11:32PM -0600, Pierre-Louis Bossart wrote:
>
>>>> +	/* attach any data */
>>>> +	if (msg_bytes)
>>>> +		memcpy(msg->msg_data, msg_data, msg_bytes);
>>> How big do these messages get?  Do we need to hold the lock while we
>>> memcpy()?
>> Messages can be as big as the mailbox, which is hardware dependent. It could
>> be from a few bytes to a larger e.g. 4k page or more, and indeed we need to
>> keep the lock.
> Is this copying into an actual mailbox or into some data structure in
> memory?  It looked like it's copying into a buffer for sending rather
> than the mailbox.
I realize between your feedback and Daniel's that we have a terminology 
issue. On the Intel side we don't have a dedicated hardware mailbox 
unit, it's only doorbell registers and shared memory windows.
>
>>>> +	/* schedule the message if not busy */
>>>> +	if (snd_sof_dsp_is_ready(sdev))
>>>> +		schedule_work(&ipc->tx_kwork);
>>> If the DSP is idle is there a reason this has to happen in another
>>> thread?
>> we will rename this as snd_sof_dsp_is_ipc_ready() to avoid any confusion
>> with the DSP state. We only care about IPC registers/doorbells at this
>> point, not the fact that the DSP is in its idle loop.
> You're missing the point - why can't we just immediately send the
> message to the DSP from here, what's the benefit of scheduling some work
> to do that?

I realize this might be Intel-specific and will likely have to evolve.

Keyon/Liam, this is your code, can you comment on Mark's comments (here)


>
>>>> +	spin_unlock_irqrestore(&sdev->ipc_lock, flags);
>>> The thread is also going to take an irq spinlock after all.
>> didn't get this point, sorry.
> One reason to bounce to another thread would be to do something that you
> can't do in this context like take a lock in a place you can't take
> locks but here we're taking a lock that needs thread context already.

Liam/Keyon comment needed here as well.

I think there are multiple questions that should be better answered to

1. why do we schedule a thread when the DSP is not busy

2. what happens if it is?

3. can we avoid freeing the lock to take it again when we schedule?
