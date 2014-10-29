From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Shared volume control again
Date: Wed, 29 Oct 2014 20:47:59 +0100
Message-ID: <5451446F.8020203@canonical.com>
References: <s5hegtq6c8d.wl-tiwai@suse.de>	<54511FEE.40906@canonical.com>
 <s5hbnou6bir.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 100E9260517
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 20:48:01 +0100 (CET)
In-Reply-To: <s5hbnou6bir.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2014-10-29 18:17, Takashi Iwai wrote:
> At Wed, 29 Oct 2014 18:12:14 +0100,
> David Henningsson wrote:
>>
>>
>>
>> On 2014-10-29 18:02, Takashi Iwai wrote:
>>> Hi,
>>>
>>> thinking of the problem about shared volume controls again, I stumbled
>>> on a case where your suggested solution doesn't work well.  Namely,
>>> when a headphone volume is shared for two headphones (one on the
>>> laptop and one on the dock), how should it be named?  One is
>>> "Headphone" and another is "Dock Headphone".  That's a bit tricky.
>>>
>>> So, in the end, we need the mapping representation somehow more
>>> explicitly than the control name.
>>>
>>> Thoughts?
>>
>> In practice, it seems like we more often than not share DAC for all
>> headphones. Also it is very common today that a jack called "Front
>> Headphone" has a volume control called only "Headphone".
>>
>> That's the status quo. As a result we have only one headphone path in
>> PulseAudio for all types of headphones.
>
> OK, so "Headphone" volume should be handled by both "Headphone Jack"
> and "Dock Headphone Jack" detections?  Then it's fine.  I thought this
> wasn't the case (from my memory dealing with an old bug report).

Yes. The "Dock Headphone Jack" name was added quite recently though, so 
it's only in git master right now.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
