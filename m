From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH v3 07/14] ASoC: SOF:
 Add DSP firmware logger support
Date: Wed, 12 Dec 2018 11:01:15 -0600
Message-ID: <647a8beb-1653-bb36-eed0-0e847ba5c7ea@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-8-pierre-louis.bossart@linux.intel.com>
 <s5hva3zj8y3.wl-tiwai@suse.de>
 <a5828bbb-e9c1-05ed-e50b-ae7ea93189ad@linux.intel.com>
 <s5h1s6mk9kz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5h1s6mk9kz.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 12/12/18 10:12 AM, Takashi Iwai wrote:
> On Wed, 12 Dec 2018 17:04:42 +0100,
> Pierre-Louis Bossart wrote:
>>
>> On 12/12/18 5:11 AM, Takashi Iwai wrote:
>>> On Tue, 11 Dec 2018 22:23:11 +0100,
>>> Pierre-Louis Bossart wrote:
>>>> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>>>>
>>>> This patch adds support for real-time DSP logging (timestamped events
>>>> and bespoke binary data) for firmware debug. The current solution
>>>> relies on DMA transfers to system memory that is then accessed by
>>>> userspace tools such as sof-logger. For Intel platforms, two types of
>>>> DMAs are currently used (GP-DMA for Baytrail/CherryTrail and HDaudio
>>>> DMA for SKL+)
>>>>
>>>> Due to historical reasons, the driver code follows the DSP firmware
>>>> conventions and refers to 'traces', but it is currently unrelated to
>>>> the Linux trace subsystem. Future solutions will include support for
>>>> more advanced hardware (e.g. MIPI Sys-T), additional formats and the
>>>> ability to enable/disable specific traces dynamically.
>>> So what's the reason not to use Linux standard tracing infrastructure?
>> I obviously failed to convey the intent in the commit message :-(
>>
>> What we have today is just a DMA-based transfers of 'trace' data into
>> a ring buffer. That's it. it's very similar to what always existed on
>> Atom and Skylake, just more transparent and released for upstream
>> reviews this time.
>>
>> Is it optimal or final? Absolutely not. There will be evolutions such as
>>
>> A) support for multi-cores on the DSP side, each with their own
>> 'trace' capability.
>>
>> B) support for other hardware platforms which may not have a DMA.
>>
>> C) support for 'probes' to retrieve and inject PCM data into specific
>> firmware nodes.
>>
>> This patch does not create a new generic tracing infrastructure for
>> Linux. We are exploring ways by which this standard tracing
>> infrastructure can be used, we just haven't had time to look into it
>> as we focused on runtime_pm and new platforms first.
>>
>> Also we need to make sure the DSP traces are not defined for Linux
>> only, it's intended that the SOF firmware is used in non-Linux
>> environments, so we want to use what Linux provides, but not constrain
>> SOF to work for Linux only.
>>
>> Does this help?
> OK, that's fine.  Liam and I talked about Linux tracing for SOF, and I
> thought this might be that.  But this is rather a hardware data
> logging, so it's a different beast.
Thanks. I'll rework the commit message for the third time to be clearer...
