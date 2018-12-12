From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH v3 05/14] ASoC: SOF:
 Add PCM operations support
Date: Wed, 12 Dec 2018 10:10:17 -0600
Message-ID: <4f4a71f9-b67f-c16e-5d5f-6f73495feb95@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-6-pierre-louis.bossart@linux.intel.com>
 <s5hd0q7uq5l.wl-tiwai@suse.de>
 <0e727a47-26b1-7772-1a8c-ca49a0e805af@linux.intel.com>
 <s5h8t0ukaxm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5h8t0ukaxm.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 12/12/18 9:43 AM, Takashi Iwai wrote:
> On Wed, 12 Dec 2018 16:29:23 +0100,
> Pierre-Louis Bossart wrote:
>>>> +	snd_sof_pcm_platform_trigger(sdev, substream, cmd);
>>>> +
>>>> +	/* send IPC to the DSP */
>>>> +	ret = sof_ipc_tx_message(sdev->ipc, stream.hdr.cmd, &stream,
>>>> +				 sizeof(stream), &reply, sizeof(reply));
>>>> +
>>>> +	return ret;
>>> ... so the whole trigger action is non-atomic PCM only?
>> Not sure if I fully understand your point here. The trigger does
>> indeed need an IPC to proceed, but the front-ends are marked as such
>> with the .nonatomic field set to true. Not sure how different this is
>> from existing atom/sst or Skylake drivers.
> Hm, so this relies purely on FE, and it seems that we have no check
> whether FE and BE match wrt nonatomic PCM ops.  It has to be
> addressed, but it's a different topic.
>
> At most, you can put some notes in the code that all these are
> non-atomic ops.  This makes it clearer, for example, that spinlock
> with irqsave is often redundant.
Yes, noted, we'll check the spinlock use and add comments as need when 
operations are non-atomic. Thanks for the suggestions, much appreciated.
