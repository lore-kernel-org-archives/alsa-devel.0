From: Libin Yang <libin.yang@linux.intel.com>
Subject: Re: [RFC PATCH 2/2] ALSA: hda - HDMI codec driver
 dynamically attach PCM
Date: Mon, 9 Nov 2015 16:45:19 +0800
Message-ID: <56405D1F.5030902@linux.intel.com>
References: <1446538973-109373-1-git-send-email-libin.yang@linux.intel.com>
 <1446538973-109373-3-git-send-email-libin.yang@linux.intel.com>
 <s5htwp3nicg.wl-tiwai@suse.de> <563999C2.90406@linux.intel.com>
 <563C3BBC.60009@linux.intel.com> <s5hpoznlcez.wl-tiwai@suse.de>
 <563FF90A.3000206@linux.intel.com> <s5hoaf3k3og.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id EFEC2260527
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 09:47:07 +0100 (CET)
In-Reply-To: <s5hoaf3k3og.wl-tiwai@suse.de>
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
Cc: Libin Yang <libin.yang@intel.com>, alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com
List-Id: alsa-devel@alsa-project.org


On 11/09/2015 03:55 PM, Takashi Iwai wrote:
> On Mon, 09 Nov 2015 02:38:18 +0100,
> Libin Yang wrote:
>>
>> Hi Takashi,
>>
>> On 11/06/2015 05:12 PM, Takashi Iwai wrote:
>>> On Fri, 06 Nov 2015 06:33:48 +0100,
>>> Libin Yang wrote:
>>>>
>>>> Hi Takashi,
>>>>
>>>> On 11/04/2015 01:38 PM, Libin Yang wrote:
>>>>> On 11/04/2015 12:44 AM, Takashi Iwai wrote:
>>>>>> On Tue, 03 Nov 2015 09:22:53 +0100,
>>>>>> libin.yang@linux.intel.com wrote:
>>>>>>>
>>>>>>> From: Libin Yang <libin.yang@intel.com>
>>>>>>>
>>>>>>> Allocate the PCM based on the number of pin and device entry.
>>>>>>> The number of PCM is pin num plus device entry number per pin.
>>>>>>> For example, on Intel platform, it will be 5 PCMs.
>>>>>>>
>>>>>>> Do not attach the PCM to pin in initialization.
>>>>>>> Dynamically attach PCM to pin when monitor is connected
>>>>>>> in HDMI audio codec driver.
>>>>>>>
>>>>>>> When monitor is disconnected, detach the PCM from the pin.
>>>>>>> And if the audio is playing, stop the playback.
>>>>>>>
>>>>>>> The below is the example of device entry and PCM binding:
>>>>>>> For a monitor is plugged in, we need to dynamically assign
>>>>>>> this monitor to 5 PCM devices (on Intel platform):
>>>>>>> For a monitor at pin nid 0x05, dev index 0, it will prefer PCM 3
>>>>>>> For a monitor at pin nid 0x06, dev index 0, it will prefer PCM 7
>>>>>>> For a monitor at pin nid 0x07, dev index 0, it will prefer PCM 8
>>>>>>> For a monitor at dev index 1 (any pin), it will prefer PCM 9
>>>>>>> For a monitor at dev index 2 (any pin), it will prefer PCM 10
>>>>>>>
>>>>>>> If the preferred PCM is not available, try PCM in this order:
>>>>>>> 9, 10, 3, 7 ,8.
>>>>>>>
>>>>>>> Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
>>>>>>
>>>>>> We should split the changes to a few patches here.  For example,
>>>>>> stopping the stream at discussion is basically an implementation
>>>>>> independent from the MST itself.  IOW, the dynamic attach/detach can
>>>>>> be implemented and tested even without MST support.  Let's code them
>>>>>> at first, then add MST support.
>>>>>
>>>>> This patch actually doesn't depend on MST. I use the dev_num to
>>>>> determine how many PCMs to be created.
>>>>>
>>>>> To Split the patch, how about I create the PCM number based the pin
>>>>> number in the patch?
>>>>>
>>>>>>
>>>>>> Also, it's an open question whether we apply the dynamic attach/detach
>>>>>> to all devices that use the generic hdmi framework.  It means
>>>>>> including AMD and Nvidia.  You hard-coded it to be applied
>>>>>> unconditionally.  Would it break anything potentially...?
>>>>>
>>>>> I have no other verdors platforms to test. But it seems to be OK on
>>>>> other platforms. The impact is, i think, it will stop the stream when
>>>>> monitor is disconnected. Should we apply the code by judging whehter
>>>>> it is Intel platform?
>>>>
>>>> If you are concerning the impact on other vendors, what about I create
>>>> a separate mst codec driver? In the driver, I will still use virtual
>>>> pin, but other vendors platform will not be supported at the moment.
>>>> Other vendors can add their patches to the new codec driver to support
>>>> their own mst audio.
>>>
>>> No, it's not the option.  Such a behavior change is the big burden to
>>> user-space.  We should provide consistent behavior as much as
>>> possible.
>>
>> OK, I see. What do you think if I judge the platform before using DP
>> MST mode?
>
> Yes, I'd love to have more tests before doing any radical changes.
>
> As already mentioned, basically your work has to individual changes:
> the stream validation and dynamic disconnect per monitor plug/unplug,
> and the MST support via dynamic PCM assignment.
>
> The former is definitely a generic framework, and it's worth to have
> even without MST support.  OTOH, the former *is* the biggest change
> from user-space POV.  User won't notice much about the latter -- the
> usage pattern should be almost same.  So, it's the former change we
> need to test and evaluate carefully.

OK. I will split the patch into 2 parts: one is dynamic disconnect, 
the other is MST support.

For the safety, the dynamic assignment and MST support will only be 
used on Intel platforms: HSW, BDW, SKL. I can do the test on the 
platforms.

Best Regards,
Libin

>
>
> Takashi
>
