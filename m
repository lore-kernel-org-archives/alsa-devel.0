From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH v4 16/20] ASoC: SOF:
 Add PCI device support
Date: Mon, 1 Apr 2019 13:26:13 -0400
Message-ID: <f4e5f957-b4f1-174c-3569-cf5c21b55ac4@linux.intel.com>
References: <20190321161055.26582-1-pierre-louis.bossart@linux.intel.com>
 <20190321161055.26582-17-pierre-louis.bossart@linux.intel.com>
 <20190328174819.GM9224@smile.fi.intel.com>
 <20190328174918.GN9224@smile.fi.intel.com>
 <9f48d5e7-8a95-db2f-0605-b15e45670ce0@linux.intel.com>
 <20190328220826.GQ9224@smile.fi.intel.com>
 <d6b6fc83-c362-4b86-ebb1-9c79dbb36858@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <d6b6fc83-c362-4b86-ebb1-9c79dbb36858@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 3/29/19 8:30 PM, Pierre-Louis Bossart wrote:
> On 3/28/19 6:08 PM, Andy Shevchenko wrote:
>> On Thu, Mar 28, 2019 at 02:21:47PM -0400, Pierre-Louis Bossart wrote:
>>>>>> +#if IS_ENABLED(CONFIG_SND_SOC_SOF_EDISON)
>>>>>
>>>>> Can we use Merrifield / mrfld instead of EDISON in entire series?
>>>
>>> we could, but I don't know of any other platform than Edison to run the
>>> code. I know it's less accurate from an architecture perspective but 
>>> felt
>>> Merrifield was confusing for non-Intel folks.
>>
>> We use Merrifield across the entire kernel. It would be confusing 
>> other way around.
>> So, please, change it to be consistent with the rest of the kernel.
> 
> Since this is the only comment so far, I'll add a follow-up patch.

Discard this reply, I'll address this in an update to address Takashi's 
comments as well.


Actually I need feedback from reviewers/maintainers: I could either 
provide an update addressing just comments from Andy and Takashi, or 
provide a larger update that would include known fixes and 
simplifications from SOF contributors on github, e.g. on the IPC. We 
have about 15-20 delta patches that were accepted on github, not sure 
what the preference is, just addressing comments so far or getting the 
latest and greatest patches squashed?
