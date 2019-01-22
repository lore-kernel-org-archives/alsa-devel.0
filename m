From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 01/21] ASoC: SOF: Intel: Add BYT,
 CHT and BSW DSP HW support.
Date: Tue, 22 Jan 2019 10:22:11 -0600
Message-ID: <5685ecb2-af2f-cb8f-9966-eede1b48f30d@linux.intel.com>
References: <20181211213029.28801-1-pierre-louis.bossart@linux.intel.com>
 <20181211213029.28801-2-pierre-louis.bossart@linux.intel.com>
 <CAEnQRZAVUFbTKC3_P-uDu3wSmBMeu7W=2p32vVnimXjeABxyQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAEnQRZAVUFbTKC3_P-uDu3wSmBMeu7W=2p32vVnimXjeABxyQA@mail.gmail.com>
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
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, andriy.shevchenko@intel.com, Takashi Iwai <tiwai@suse.de>, Pan Xiuli <xiuli.pan@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Alan Cox <alan@linux.intel.com>, Rander Wang <rander.wang@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 1/22/19 1:35 AM, Daniel Baluta wrote:
>> +static int byt_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
>> +{
>> +       u64 cmd = msg->header;
>> +
>> +       /* send the message */
>> +       sof_mailbox_write(sdev, sdev->host_box.offset, msg->msg_data,
>> +                         msg->msg_size);
> I was wondering if the mailbox shared memory wouldn't be better
> implemented as a queue.
> Do you support playing multiple streams in parallel?
>
> We have this use case where we need to to memory to memory
> decoding/encoding with lots
> of streams in parallel.

Sorry Daniel, I didn't get your point.

we do support multiple streams in parallel and there's been quite a few 
issues fixed in the IPC mechanisms due to concurrency. The IPC mechanism 
is serialized however since there are only few resources available, 
typically only a couple of doorbell registers and a small memory window. 
For multiple streams the PCM data is exchanged over DMA typically - the 
streams don't go over the IPC channel but the information related to a 
stream is passed using a tag or ID.

Can you clarify what you had in mind?
