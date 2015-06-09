From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - PCH HDA controller not
 controlled by i915 power
Date: Tue, 09 Jun 2015 10:51:19 +0200
Message-ID: <5576A907.9050305@canonical.com>
References: <1433829918-5807-1-git-send-email-libin.yang@intel.com>	<s5h1thlbder.wl-tiwai@suse.de>	<55768BCB.3060001@canonical.com>
 <s5hy4jt9td4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AD152606CD
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 10:51:18 +0200 (CEST)
In-Reply-To: <s5hy4jt9td4.wl-tiwai@suse.de>
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
Cc: libin.yang@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2015-06-09 10:30, Takashi Iwai wrote:
> At Tue, 09 Jun 2015 08:46:35 +0200,
> David Henningsson wrote:
>>
>>
>>
>> On 2015-06-09 08:31, Takashi Iwai wrote:
>>> At Tue,  9 Jun 2015 14:05:18 +0800,
>>> libin.yang@intel.com wrote:
>>>>
>>>> From: Libin Yang <libin.yang@intel.com>
>>>>
>>>> On some Intel platforms, the HDMI codec is connected to PCH HDA
>>>> controller. In this case, AZX_DCAPS_I915_POWERWELL is set and
>>>> the i915 power well failure should not block the hda controller
>>>> initialization.
>>>>
>>>> Signed-off-by: Libin Yang <libin.yang@intel.com>
>>>
>>> Is this fix needed for 4.1, or it's only for 4.2?
>>
>> It's a bug fix, and as such should go to all kernels, even with cc to
>> stable. That said, it mainly concerns Skylake, so kernels that don't
>> support Skylake would not need a backport.
>
> The patch can't be applied even to 4.1 as is because of the code
> structure change.  So, Cc to stable doesn't work, in anyway.
>
>>> I vaguely remember of a bug report.  If there is any relevant bug
>>> report, please give the link, too.
>>
>> I think this was raised to Intel by us. The use case is when the
>> integrated GPU is disabled and a discrete GPU is used. In this case the
>> i915 module fails to load. If then the HDMI and analog codec are both on
>> the same controller, the entire controller fails instead of just the
>> HDMI codec.
>>
>> I'll see if I can get the patch tested ASAP.
>
> OK, the bug seems needed for 4.1 and earlier.  But Libin's patch is
> only for 4.2.  And even worse, backporting this isn't
> straightforward due to the lack of need_i915_power field.  Hmm.
>
> I think we can make it easier by just allowing to continue the probe.
> A totally untested patch for 4.1 is below.

As part of the wider discussion, I think we could continue instead of 
failing also on Haswell and Broadwell. This is to some degree 
hypothetical, but if the i915 module does not load for some reason, then 
the i915 module would not turn the power well off either, so it remains 
on the entire time (and then audio could potentially work).

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
