From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 04/14] ASoC: SOF: Add support for IPC IO
 between DSP and Host
Date: Mon, 14 Jan 2019 11:39:38 -0600
Message-ID: <8c6a9c24-2371-6b54-4eb4-3132e8fe731f@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-5-pierre-louis.bossart@linux.intel.com>
 <CAEnQRZCj7QQ1N11t44uu0nz2D7rqjc5Avu29-ecbZ9oq4G0xfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAEnQRZCj7QQ1N11t44uu0nz2D7rqjc5Avu29-ecbZ9oq4G0xfw@mail.gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, andriy.shevchenko@intel.com, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, vkoul@kernel.org, Mark Brown <broonie@kernel.org>, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


>> +static void ipc_tx_next_msg(struct work_struct *work)
>> +{
>> +       struct snd_sof_ipc *ipc =
>> +               container_of(work, struct snd_sof_ipc, tx_kwork);
>> +       struct snd_sof_dev *sdev = ipc->sdev;
>> +       struct snd_sof_ipc_msg *msg;
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&sdev->ipc_lock, flags);
>> +
>> +       /* send message if HW read and message in TX list */
> s/HW read/HW ready/ I think.
yes indeed, thanks for the note.
