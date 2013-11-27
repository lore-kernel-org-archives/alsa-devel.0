From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Enable mute/mic-mute LEDs for
 more Thinkpads with Conexant codec
Date: Wed, 27 Nov 2013 15:39:19 +0800
Message-ID: <5295A1A7.2020804@canonical.com>
References: <1385522812-29678-1-git-send-email-hui.wang@canonical.com>
 <5295805C.8060104@canonical.com> <s5h7gbuwdhr.wl%tiwai@suse.de>
 <52959B2D.6000900@canonical.com> <s5h38miwboj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id EBEB62619F0
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 08:39:26 +0100 (CET)
In-Reply-To: <s5h38miwboj.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, yk@canonical.com, alex.hung@canonical.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 11/27/2013 03:23 PM, Takashi Iwai wrote:
> At Wed, 27 Nov 2013 15:11:41 +0800,
> Hui Wang wrote:
>> On 11/27/2013 02:44 PM, Takashi Iwai wrote:
>>> At Wed, 27 Nov 2013 06:17:16 +0100,
>>> David Henningsson wrote:
>>>> On 11/27/2013 04:26 AM, Hui Wang wrote:
>>>>> Most Thinkpad Edge series laptops use conexant codec, so far although
>>>>> the codecs have different minor Vendor Id and minor Subsystem Id, but
>>>>> they all belong to the cxt_5066 family, this change can make the
>>>>> mute/mic-mute LEDs support more generic among cxt_5066 family.
>>>> Hi Hui and thanks for your patch!
>>>>
>>>> It's also nice that you have tested the patch on several machines and
>>>> found it to be working.
>>>>
>>>> As for the actual implementation - as the rest of the thinkpad-acpi code
>>>> is copy-pasted between patch_realtek and patch_conexant, I think this
>>>> would also apply here, i e, no code in hda_local.h, instead copy from
>>>> patch_realtek to patch_conexant as necessary.
>>>>
>>>> While copy-pasting code is not the most elegant of solutions, I got the
>>>> impression from Takashi that he preferred that for now.
>>> If you'd like it to be included in 3.13, please just copy the small
>>> code snippet.
>> Yes we hope it can be merged to 3.13, so as your request, i just copy
>> the small code snippet in the V2 patch.
>>> For 3.14, we can move the thinkpad-related code into another file, but
>>> I have some bad feeling to put it into hda_local.h or whatever the
>>> common code base.
>>> Maybe just create hda_thinkpad.c or such and include from both
>>> patch_realtek.c and patch_conexant.c.  As long as the code size is
>>> small enough and they are all static, it should be fine.
>> Good suggestion, if we have more machines to test and the testing expose
>> more problems,
>> we should think about moving the common functions to the hda_thinkpad.c.
> Hrm, this comment makes me worry a bit to include into 3.13.
> Hasn't been the patch tested fully?  The merge window was already
> closed, and it means that we really need only fixes, the ones that
> won't regress obviously...
Sorry to make you misunderstand, this patch definitely works well on the 
machines with Conexant codec (cxt5066 family).  I have tested this patch 
on  9 laptops whose codecs all belong to cxt5066 family, they all worked 
well.

The problem i pointed to was that, assuming we meet a machine with 
conexant codec in future, but this codec doesn't belong to cxt5066 
family, this patch will not work on this machine, but this patch will 
not introduce regress on this machine as well.

Regards,
Hui.
>
> Takashi
>
>
>>
