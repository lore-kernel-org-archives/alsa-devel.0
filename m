From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Multiple speaker jacks (on an IDT codec)
Date: Thu, 06 Sep 2012 11:33:22 +0200
Message-ID: <50486DE2.4000400@canonical.com>
References: <5047D943.5060900@canonical.com> <s5hmx13isnw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090003090101030104080904"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A158E26156C
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 11:33:20 +0200 (CEST)
In-Reply-To: <s5hmx13isnw.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090003090101030104080904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 09/06/2012 08:14 AM, Takashi Iwai wrote:
> At Thu, 06 Sep 2012 00:59:15 +0200,
> David Henningsson wrote:
>>
>> Hi,
>>
>> I'm having a problem with a machine where the parser creates indexed
>> speaker controls. For reference, codecs/idt92hd206-ecs-gf7100pvt shows
>> the same problem.
>>
>> I could use some input on how to fix it in the best way.
>>
>> My first thought was that "[Jack] Speaker" is stupid in itself, and
>> could be fixed like this:
>>
>> diff --git a/sound/pci/hda/hda_auto_parser.c
>> b/sound/pci/hda/hda_auto_parser.c
>> index 4f7d2df..8e32ee5 100644
>> --- a/sound/pci/hda/hda_auto_parser.c
>> +++ b/sound/pci/hda/hda_auto_parser.c
>> @@ -171,6 +171,10 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
>>                           if (conn == AC_JACK_PORT_FIXED)
>>                                   dev = AC_JACK_SPEAKER;
>>                   }
>> +               else if (dev == AC_JACK_SPEAKER) {
>> +                       if (conn == AC_JACK_PORT_COMPLEX)
>> +                               dev = AC_JACK_LINE_OUT;
>> +               }
>>
>>                   switch (dev) {
>>                   case AC_JACK_LINE_OUT:
>>
>> ...but changing generic code is always a bit scary and regression prone
>> (even though I could not think of a good counterexample where that would
>> happen), so not sure if that's the best idea.
>
> Right.  I remember that there are more devices declaring the speakers
> in that way.

I grepped a little through the alsa-infos and found a "[Jack] Speaker at 
Int N/A", which is probably an internal speaker rather than a line 
out...covering all cases is tricky.

>> Next attempt is to modify the control creating function for IDT:
>>
>> diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
>> index 9db3056..c16d0f8 100644
>> --- a/sound/pci/hda/patch_sigmatel.c
>> +++ b/sound/pci/hda/patch_sigmatel.c
>> @@ -3226,9 +3226,12 @@ static int create_multi_out_ctls(struct hda_codec
>> *codec, int num_outs,
>>                                   idx = i;
>>                                   break;
>>                           case AUTO_PIN_SPEAKER_OUT:
>> -                               name = "Speaker";
>> -                               idx = i;
>> -                               break;
>> +                               if (num_outs <= 1) {
>> +                                       name = "Speaker";
>> +                                       idx = i;
>> +                                       break;
>> +                               }
>> +                               /* Fall through in case of multi speaker
>> outs */
>>                           default:
>>                                   name = chname[i];
>>                                   idx = 0;
>>
>>
>> ...since the current behaviour is inconsistent anyway - you get indices
>> for 1 and 3, but "Center"/"LFE" for what should otherwise have been index 2.
>
> Yeah, certainly something fishy there.
> IIRC, the exception was introduced to handle the bass speaker.
> But I guess it's already broken in some level, so we need to revisit
> the implementation.
>
> A concern for the change like above is whether it handles correctly
> the case where machines has multiple built-in speakers with a single
> headphone jack.  We need to check this.

I'm not exactly sure what you're suspecting here, but the only codec I 
found in hda-emu with this configuration was stac9221-macbook-pro-21, 
which is equally broken before and after my patch (before, headphones 
are controlled by speaker index 1, and after, it's controlled by surround).

>> Another way would to just write a pin fix to turn these speakers into
>> line outs, which is what they really are anyway.
>>
>> What do you think?
>
> This might be a safer option.

Having seen that there are several STAC/IDT codecs which have the 
"[Jack] Speaker" construct, I think it would be nice to fix them all 
while at it.

So I'm leaning towards the multi speaker out rename patch. Attaching 
that one.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------090003090101030104080904
Content-Type: text/x-patch;
 name="0001-ALSA-hda-fix-control-names-for-multiple-speaker-out-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-fix-control-names-for-multiple-speaker-out-.pa";
 filename*1="tch"

>From 08f1e126e3e53e39f5ab25d27db09b9795e125b8 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Thu, 6 Sep 2012 11:17:58 +0200
Subject: [PATCH] ALSA: hda - fix control names for multiple speaker out on
 IDT/STAC

For multiple speaker outs, the names were previously
"Speaker,0", "Speaker,1", "Center"/"LFE", "Speaker,3". This is
inconsistent, confusing, and is not picked up correctly by PulseAudio.
Instead use "Front", "Surround", "Center"/"LFE", "Side" which
is more standard.

BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1046734
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_sigmatel.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 9db3056..c16d0f8 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -3226,9 +3226,12 @@ static int create_multi_out_ctls(struct hda_codec *codec, int num_outs,
 				idx = i;
 				break;
 			case AUTO_PIN_SPEAKER_OUT:
-				name = "Speaker";
-				idx = i;
-				break;
+				if (num_outs <= 1) {
+					name = "Speaker";
+					idx = i;
+					break;
+				}
+				/* Fall through in case of multi speaker outs */
 			default:
 				name = chname[i];
 				idx = 0;
-- 
1.7.9.5


--------------090003090101030104080904
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090003090101030104080904--
