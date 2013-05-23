From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 4/4 V2] ALSA: hda - Continue probe in work
 context to avoid request_module deadlock
Date: Thu, 23 May 2013 19:41:58 +0200
Message-ID: <519E54E6.90404@canonical.com>
References: <1369273867-2067-1-git-send-email-xingchao.wang@linux.intel.com>
	<s5hip2a8a33.wl%tiwai@suse.de>
	<46B810F6945F7C4788E11DCE57EC48901181688C@SHSMSX104.ccr.corp.intel.com>
	<s5htxluvvo7.wl%tiwai@suse.de>
	<46B810F6945F7C4788E11DCE57EC4890118168BF@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <46B810F6945F7C4788E11DCE57EC4890118168BF@SHSMSX104.ccr.corp.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: "Wang, Xingchao" <xingchao.wang@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Li,
	Jocelyn" <jocelyn.li@intel.com>, "Girdwood,
	Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On 05/23/2013 12:29 PM, Wang, Xingchao wrote:
>
>
>> -----Original Message-----
>> From: Takashi Iwai [mailto:tiwai@suse.de]
>> Sent: Thursday, May 23, 2013 6:27 PM
>> To: Wang, Xingchao
>> Cc: Wang Xingchao; alsa-devel@alsa-project.org;
>> intel-gfx@lists.freedesktop.org; david.henningsson@canonical.com; Girdwood,
>> Liam R; Li, Jocelyn; Lin, Mengdong
>> Subject: Re: [PATCH 4/4 V2] ALSA: hda - Continue probe in work context to avoid
>> request_module deadlock
>>
>> At Thu, 23 May 2013 10:19:27 +0000,
>> Wang, Xingchao wrote:
>>>
>>> Hi Takashi,
>>>
>>>> -----Original Message-----
>>>> From: Takashi Iwai [mailto:tiwai@suse.de]
>>>> Sent: Thursday, May 23, 2013 2:49 PM
>>>> To: Wang Xingchao
>>>> Cc: alsa-devel@alsa-project.org; intel-gfx@lists.freedesktop.org;
>>>> david.henningsson@canonical.com; Girdwood, Liam R; Li, Jocelyn;
>>>> Wang, Xingchao; Lin, Mengdong
>>>> Subject: Re: [PATCH 4/4 V2] ALSA: hda - Continue probe in work
>>>> context to avoid request_module deadlock
>>>>
>>>> At Thu, 23 May 2013 09:51:07 +0800,
>>>> Wang Xingchao wrote:
>>>>>
>>>>> There's deadlock when request_module(i915) in azx_probe.
>>>>> It looks like:
>>>>> device_lock(audio pci device) -> azx_probe -> module_request (or
>>>>> symbol_request) -> modprobe (userspace) -> i915 init ->
>>>>> drm_pci_init
>>>>> -> pci_register_driver -> bus_add_driver -> driver_attach -> which
>>>>> -> in
>>>>> turn tries all locks on pci bus, and when it tries the one on the
>>>>> audio device, it will deadlock.
>>>>>
>>>>> This patch introduce a work to store remaining probe stuff, and
>>>>> let request_module run in safe work context.
>>>>>
>>>>> Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
>>>>> ---
>>>>>   sound/pci/hda/hda_i915.c  |  13 ++++--  sound/pci/hda/hda_intel.c
>>>>> |
>>>>> 105 +++++++++++++++++++++++++++-------------------
>>>>>   2 files changed, 71 insertions(+), 47 deletions(-)
>>>>>
>>>>> diff --git a/sound/pci/hda/hda_i915.c b/sound/pci/hda/hda_i915.c
>>>>> index
>>>>> 76c13d5..7547b20 100644
>>>>> --- a/sound/pci/hda/hda_i915.c
>>>>> +++ b/sound/pci/hda/hda_i915.c
>>>>> @@ -42,13 +42,18 @@ int hda_i915_init(void)  {
>>>>>   	int err = 0;
>>>>>
>>>>> -	get_power = symbol_request(i915_request_power_well);
>>>>> +	get_power = symbol_get(i915_request_power_well);
>>>>>   	if (!get_power) {
>>>>> -		snd_printk(KERN_WARNING "hda-i915: get_power symbol get
>>>> fail\n");
>>>>> -		return -ENODEV;
>>>>> +		request_module("i915");
>>>>> +		get_power = symbol_get(i915_request_power_well);
>>>>> +		if (!get_power) {
>>>>> +			snd_printk(KERN_WARNING "hda-i915: get_power symbol
>> get
>>>> fail\n");
>>>>> +			return -ENODEV;
>>>>> +		}
>>>>> +		snd_printdd("hda-i915: get_power symbol get successful\n");
>>>>
>>>> Why do you need this change?
>>>>
>>>
>>> symbol_request() should be the better API in such case but in my test
>>> it doesnot really load i915 module, that's why I call request_module(i915)
>> directly here.
>>>
>>> Please note there's parameter difference:
>>> request_module("i915")
>>>
>> symbol_request(i915_reauest_power_well)-->request_module("symbol:i915_
>>> request_power_well")
>>>
>>> I donot know why the second one did not really load the module.
>>
>> Well, something is really fishy.  The patch can't be accepted only because it
>> just works by moon phase...
>>
> I will continue to figure out the reason it doesnot work. :(

To the rescue!

I've tried to track this down, and I think this is a problem in modprobe 
with blacklisted modules. I've just emailed the kmod maintainer (with 
Wang Xingchao in cc) and asked for clarification.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
