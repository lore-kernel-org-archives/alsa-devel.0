From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 13/14] ASoC: SOF: Add xtensa support
Date: Tue, 11 Dec 2018 18:00:26 -0600
Message-ID: <33d6f056-efce-6855-3d71-34649482ed58@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-14-pierre-louis.bossart@linux.intel.com>
 <20181211230813.GM10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211230813.GM10650@smile.fi.intel.com>
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
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 12/11/18 5:08 PM, Andy Shevchenko wrote:
> On Tue, Dec 11, 2018 at 03:23:17PM -0600, Pierre-Louis Bossart wrote:
>> Add common directory for xtensa architecture
>> +	for (i = 0; i <= stack_words - 4; i += 4) {
>> +		dev_err(sdev->dev, "0x%8.8x: 0x%8.8x 0x%8.8x 0x%8.8x 0x%8.8x\n",
>> +			stack_ptr + i, stack[i], stack[i + 1], stack[i + 2],
>> +			stack[i + 3]);
>> +	}
>> +
>> +	/* deal with any remaining words */
>> +	switch (stack_words - i) {
>> +	case 0:
>> +		break;
>> +	case 1:
>> +		dev_err(sdev->dev, "0x%8.8x: 0x%8.8x\n",
>> +			stack_ptr + stack_words - 1, stack[stack_words - 1]);
>> +		break;
>> +	case 2:
>> +		dev_err(sdev->dev, "0x%8.8x: 0x%8.8x 0x%8.8x\n",
>> +			stack_ptr + stack_words - 2, stack[stack_words - 2],
>> +			stack[stack_words - 1]);
>> +		break;
>> +	case 3:
>> +		dev_err(sdev->dev, "0x%8.8x: 0x%8.8x 0x%8.8x 0x%8.8x\n",
>> +			stack_ptr + stack_words - 3, stack[stack_words - 3],
>> +			stack[stack_words - 2], stack[stack_words - 1]);
>> +		break;
>> +	default:
>> +		break;
>> +	}
> hex_dump_to_buffer().
I vaguely recall there was a reason not to do it, we'll relook at this.
