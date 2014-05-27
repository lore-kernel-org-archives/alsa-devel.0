From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH 4/5] ALSA: hda - drop def association and
 sequence from pinconf comparing
Date: Tue, 27 May 2014 10:25:34 +0800
Message-ID: <CAJ=jqub_w_9vppPdO0dnz0nYztsGr3yn5DM4eHu-PWmhQnv1SA@mail.gmail.com>
References: <1401092564-14293-1-git-send-email-hui.wang@canonical.com>
 <1401092564-14293-4-git-send-email-hui.wang@canonical.com>
 <5383136A.3040006@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f175.google.com (mail-qc0-f175.google.com
 [209.85.216.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F0E3265192
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 04:25:35 +0200 (CEST)
Received: by mail-qc0-f175.google.com with SMTP id w7so13034738qcr.20
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 19:25:34 -0700 (PDT)
In-Reply-To: <5383136A.3040006@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Hui Wang <hui.wang@canonical.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi David,

BIOS today implements verbtable which is provided by codec vendor
based on hardware design, and it is indeed not uncommon that the
verbtable includes used pin only and leaves unused pins untouched.

On Mon, May 26, 2014 at 6:11 PM, David Henningsson
<david.henningsson@canonical.com> wrote:
> (Add Alex Hung to CC)
>
> On 2014-05-26 10:22, Hui Wang wrote:
>>
>> A lot a machine have the same codec, but they have different default
>> pinconf setting just because the def association and sequence is
>> different, as a result they can't share a hda_pintbl[], to overcome
>> it, we don't compare def association and sequence in the pinconf
>> matching.
>
>
> Uhm, really? Alex, does this seem reasonable from a BIOS perspective, i e,
> that BIOS people normally would set def association and sequence different
> while leaving everything else unchanged?
>
>>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>>   sound/pci/hda/hda_auto_parser.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/pci/hda/hda_auto_parser.c
>> b/sound/pci/hda/hda_auto_parser.c
>> index b684c6e..3cf9137 100644
>> --- a/sound/pci/hda/hda_auto_parser.c
>> +++ b/sound/pci/hda/hda_auto_parser.c
>> @@ -844,7 +844,8 @@ static bool pin_config_match(struct hda_codec *codec,
>>   {
>>         for (; pins->nid; pins++) {
>>                 u32 def_conf = snd_hda_codec_get_pincfg(codec, pins->nid);
>> -               if (pins->val != def_conf)
>> +               u32 mask = 0xffffff00;
>> +               if ((pins->val & mask) != (def_conf & mask))
>>                         return false;
>>         }
>>         return true;
>>
>
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic



-- 
Cheers,
Alex Hung
