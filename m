From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 4/5] ALSA: hda - drop def association and
 sequence from pinconf comparing
Date: Tue, 27 May 2014 06:41:09 +0200
Message-ID: <53841765.4000404@canonical.com>
References: <1401092564-14293-1-git-send-email-hui.wang@canonical.com>	<1401092564-14293-4-git-send-email-hui.wang@canonical.com>	<5383136A.3040006@canonical.com>
 <CAJ=jqub_w_9vppPdO0dnz0nYztsGr3yn5DM4eHu-PWmhQnv1SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6498E2654C6
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 06:41:09 +0200 (CEST)
In-Reply-To: <CAJ=jqub_w_9vppPdO0dnz0nYztsGr3yn5DM4eHu-PWmhQnv1SA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Hung <alex.hung@canonical.com>
Cc: Hui Wang <hui.wang@canonical.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2014-05-27 04:25, Alex Hung wrote:
> Hi David,
>
> BIOS today implements verbtable which is provided by codec vendor
> based on hardware design, and it is indeed not uncommon that the
> verbtable includes used pin only and leaves unused pins untouched.

Sure, but those unused pins would then have the same default value that 
the codec initializes it with.

Also, it wouldn't be uncommon for BIOS (or codec vendors) to use the 
same verbtable for several machines if they share the same audio hardware.

But none of this explains why anyone would just change def association 
and sequence value between machines? It makes no sense.

>
> On Mon, May 26, 2014 at 6:11 PM, David Henningsson
> <david.henningsson@canonical.com> wrote:
>> (Add Alex Hung to CC)
>>
>> On 2014-05-26 10:22, Hui Wang wrote:
>>>
>>> A lot a machine have the same codec, but they have different default
>>> pinconf setting just because the def association and sequence is
>>> different, as a result they can't share a hda_pintbl[], to overcome
>>> it, we don't compare def association and sequence in the pinconf
>>> matching.
>>
>>
>> Uhm, really? Alex, does this seem reasonable from a BIOS perspective, i e,
>> that BIOS people normally would set def association and sequence different
>> while leaving everything else unchanged?
>>
>>>
>>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>>> ---
>>>    sound/pci/hda/hda_auto_parser.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/sound/pci/hda/hda_auto_parser.c
>>> b/sound/pci/hda/hda_auto_parser.c
>>> index b684c6e..3cf9137 100644
>>> --- a/sound/pci/hda/hda_auto_parser.c
>>> +++ b/sound/pci/hda/hda_auto_parser.c
>>> @@ -844,7 +844,8 @@ static bool pin_config_match(struct hda_codec *codec,
>>>    {
>>>          for (; pins->nid; pins++) {
>>>                  u32 def_conf = snd_hda_codec_get_pincfg(codec, pins->nid);
>>> -               if (pins->val != def_conf)
>>> +               u32 mask = 0xffffff00;
>>> +               if ((pins->val & mask) != (def_conf & mask))
>>>                          return false;
>>>          }
>>>          return true;
>>>
>>
>> --
>> David Henningsson, Canonical Ltd.
>> https://launchpad.net/~diwic
>
>
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
