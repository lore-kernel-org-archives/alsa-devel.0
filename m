From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] ALSA: hda - Enable runtime pm for Haswell
Date: Mon, 27 May 2013 15:02:21 +0200
Message-ID: <51A3595D.1000603@intel.com>
References: <1368692945-2122-1-git-send-email-xingchao.wang@linux.intel.com>
 <s5hehd7jomk.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC4890118154B8@SHSMSX104.ccr.corp.intel.com>
 <s5h4ndva7g8.wl%tiwai@suse.de> <519CA768.5020305@intel.com>
 <46B810F6945F7C4788E11DCE57EC489011816442@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 54EB126030A
 for <alsa-devel@alsa-project.org>; Mon, 27 May 2013 15:02:34 +0200 (CEST)
In-Reply-To: <46B810F6945F7C4788E11DCE57EC489011816442@SHSMSX104.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Wang, Xingchao" <xingchao.wang@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Li,
 Jocelyn" <jocelyn.li@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On 5/23/2013 4:59 AM, Wang, Xingchao wrote:
> Hi Rafael,
>
>
>> -----Original Message-----
>> From: Wysocki, Rafael J
>> Sent: Wednesday, May 22, 2013 7:09 PM
>> To: Takashi Iwai
>> Cc: Wang, Xingchao; Girdwood, Liam R; Lin, Mengdong; Li, Jocelyn;
>> alsa-devel@alsa-project.org; Wang Xingchao
>> Subject: Re: [PATCH] ALSA: hda - Enable runtime pm for Haswell
>>
>> On 5/22/2013 7:51 AM, Takashi Iwai wrote:
>>> At Wed, 22 May 2013 03:56:00 +0000,
>>> Wang, Xingchao wrote:
>>>> Hi,
>>>>
>>>> Add Rafael in loop.
>>>>
>>>>> -----Original Message-----
>>>>> From: Takashi Iwai [mailto:tiwai@suse.de]
>>>>> Sent: Thursday, May 16, 2013 4:49 PM
>>>>> To: Wang Xingchao
>>>>> Cc: Girdwood, Liam R; Lin, Mengdong; Li, Jocelyn;
>>>>> alsa-devel@alsa-project.org; Wang, Xingchao
>>>>> Subject: Re: [PATCH] ALSA: hda - Enable runtime pm for Haswell
>>>>>
>>>>> At Thu, 16 May 2013 16:29:05 +0800,
>>>>> Wang Xingchao wrote:
>>>>>> Haswell doesnot support runtime pm by default.
>>>>>> This patch let haswell Display HD-A controller enter runtime
>>>>>> suspend, and bring more power saving whith power-well.
>>>>>>
>>>>>> Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
>>>>> I don't think it's good to fiddle such a thing in the driver side.
>>>>> If Haswell can support runtime PM really, it should be set commonly.
>>>> I wonder whether it's HD-A driver's policy to only support runtime PM if the
>> device can support signal wakup?
>>>> According to Rafael, the device can support runtime PM regardless, no
>> matter it supports PME or not.
>>>> If so, we should remove the "if" condition check here.
>>> Well, if the decision is purely a driver issue, then we can get rid of
>>> PME check.
>> Yes, it is.
>>
>>>     But in that case, it should be simply like:
>>>
>>> azx_probe() {
>>> 	...
>>> 	if (chip->driver_caps & AZX_DCAPS_PM_RUNTIME)
>>> 		pm_runtime_put_noidle(&pci->dev);
>>> 	...
>>> }
>>>
>>> azx_remove() {
>>> 	...
>>> 	if (chip->driver_caps & AZX_DCAPS_PM_RUNTIME)
>>> 		pm_runtime_get_noresume(&pci->dev);
>>> 	...
>>> }
>>>
>>>
>>> AFAIU, calling pm_runtime_allow() enables the runtime PM *forcibly*.
>>> Usually this isn't a good thing.
>>>
>> That's correct.  Moreover, calling both pm_runtime_allow() *and*
>> pm_runtime_put_noidle() together would be a bug IMO.
> It's interesting something maybe wrong in my test:
> 1. withtout calling pm_runtime_allow(), azx_runteim_idle/suspend() will not be called.

That's because you need to echo "auto" into the device's 
/sys/devices/.../power/control file from user space for it to work (most 
likely that's the reason).  If that file already contains "auto" when 
this happens, I'll need to look at the code to tell you what may be wrong.

> 2. another trick is on my Haswell ULT C stepping board, the runtime PM only work
> after exit from resume:
>
> echo mem > /sys/power/state
>
> if you donot let system enter suspend manually, the runtime pm will not be triggered.
>
> Is there any dependency between runtime pm suspend and normal suspend?

There shouldn't be any like this, and if there's one, it is a bug most 
likely.

Thanks,
Rafael

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
z siedziba w Gdansku
ul. Slowackiego 173
80-298 Gdansk

Sad Rejonowy Gdansk Polnoc w Gdansku, 
VII Wydzial Gospodarczy Krajowego Rejestru Sadowego, 
numer KRS 101882

NIP 957-07-52-316
Kapital zakladowy 200.000 zl

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
