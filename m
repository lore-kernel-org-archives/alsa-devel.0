From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/1] ALSA: hda - Use acpi_dev_present()
Date: Thu, 25 Feb 2016 11:42:06 -0600
Message-ID: <56CF3CEE.5000500@linux.intel.com>
References: <cover.1452790983.git.lukas@wunner.de>
 <s5hmvs7l6ys.wl-tiwai@suse.de> <20160220224724.GA19638@wunner.de>
 <s5h1t86xyt1.wl-tiwai@suse.de> <56CB18A7.3000207@linux.intel.com>
 <20160222202331.GA20052@wunner.de> <20160225165905.GA20348@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 09A10261515
 for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2016 18:42:09 +0100 (CET)
In-Reply-To: <20160225165905.GA20348@wunner.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lukas Wunner <lukas@wunner.de>, Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2/25/16 10:59 AM, Lukas Wunner wrote:
> Hi Pierre-Louis, Hi Vinod,
>
> On Mon, Feb 22, 2016 at 09:23:31PM +0100, Lukas Wunner wrote:
>> On Mon, Feb 22, 2016 at 08:18:15AM -0600, Pierre-Louis Bossart wrote:
>>> On 02/21/2016 02:17 AM, Takashi Iwai wrote:
>>>> On Sat, 20 Feb 2016 23:47:24 +0100,
>>>> Lukas Wunner wrote:
>>>>>
>>>>> Hi Takashi,
>>>>>
>>>>> On Fri, Jan 15, 2016 at 06:58:19AM +0100, Takashi Iwai wrote:
>>>>>> On Thu, 14 Jan 2016 22:05:03 +0100, Lukas Wunner wrote:
>>>>>>> Hi Takashi,
>>>>>>>
>>>>>>> the acpi_dev_present() API has now landed in Linus' tree.
>>>>>>> Thus, after Linus' tree gets merged back into yours,
>>>>>>> it would be possible to use the API in the Thinkpad hda drivers
>>>>>>> as per the following patch.
>>>>>>>
>>>>>>> I've also pushed it to GitHub in case anyone prefers
>>>>>>> perusing it in a browser:
>>>>>>> https://github.com/l1k/linux/commit/a1473d726b57eaf97c4de8812c5967603068e261
>>>>>>>
>>>>>>> An ack for this patch was kindly provided by Hui Wang with:
>>>>>>> Message-ID: <5653C291.9090607@canonical.com>
>>>>>>> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-November/100962.html
>>>>>>
>>>>>> A back merge is ugly and I'd like to avoid it.
>>>>>> This is no urgent fix but rather a cleanup, right?  If so, I'd
>>>>>> postpone this to 4.6.
>>>>>
>>>>> I've noticed this patch isn't in one of your trees, so it looks
>>>>> like it's not queued for 4.6 yet. If there are objections against
>>>>> it please let me know. If there aren't, I'd like to gently remind
>>>>> of the patch's existence.
>>>>
>>>> Sorry for the delay, it's merged now.
>>>
>>> heads-up: we've identified that the ACPI subsystem reports devices as
>>> present even if they are explicitly disabled in the BIOS _STA routine.
>>> we have a couple of WIP patches to work around this issue that is
>>> blocking for some CHT-T devices, and they pretty much amount to a
>>> revert and addition of an explicit presence test
>>
>> Thanks for the heads-up. I'm confused though that you're sending this
>> in reply to the thinkpad_helper.c patch, I assume this only concerns
>> the ASoC patch?
>>
>> As you've correctly observed, acpi_dev_present() only checks presence
>> of a HID in the namespace and does not invoke the _STA control method.
>> However the code that it replaced also only checked presence in the
>> namespace, so this is not an issue introduced by my patch but rather
>> one which was present all along.
>>
>> If you need to check the "device is present" bit returned by _STA,
>> you need a pointer to the struct acpi_device. This will allow you
>> to call acpi_bus_get_status() and check its return value for
>> ACPI_STA_DEVICE_PRESENT.
>>
>> We cannot easily add this to acpi_dev_present() because that function
>> no longer does an expensive namespace walk but rather a cheap list
>> iteration which does not yield a pointer to the struct acpi_device.
>>
>> In the first version of acpi_dev_present() I was in fact doing a
>> namespace walk with acpi_get_devices() but Robert Moore objected
>> to that, calling it "truly brute force":
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-November/101046.html
>>
>> Hence if possible you should try to avoid that as well. You may
>> want to consider adding a helper to drivers/acpi/utils.c which
>> takes a HID and returns a struct acpi_device*, it might come in
>> handy for others as well.
>
> Forgot to mention:
>
> There's one driver where you currently check for the presence of a
> specific ACPI device twice. It would probably be good if you could
> eliminate the second check.
>
> I've explained this in detail in an e-mail to linux-acpi in December
> but only cc'ed Mark Brown as I wasn't sure who's responsible for the
> driver: http://www.spinics.net/lists/linux-acpi/msg62068.html
>
> Quote:
>
>> * 1 is a driver for a platform_device (cht_bsw_rt5645.c) which was
>>    instantiated by atom/sst/sst_acpi.c. The driver is responsible
>>    for two chips and differentiates between the two by detecting the
>>    presence of a particular HID. It would be possible to refactor the
>>    code so that atom/sst/sst_acpi.c passes down the matched HID to
>>    cht_bsw_rt5645.c, then it wouldn't be necessary to match for a
>>    second time. Also, the only difference between the two chipsets
>>    seems to be a minute change in struct snd_soc_dapm_route, so I'm
>>    wondering if it's necessary to differentiate between the chipsets
>>    at all.

Yes we are aware of this.
But again we are not going to use acpi_dev_present() anyway since it 
just doesn't filter out devices that aren't enabled by the BIOS, we need 
additional functionality for this.
