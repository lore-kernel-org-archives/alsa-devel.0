From: Kailang <kailang@realtek.com>
Subject: Re: Independent of model for HP
Date: Wed, 4 Dec 2013 15:14:11 +0800
Message-ID: <EA3D2891818D47418E818127429C14D0@realtek.com.tw>
References: <74730F8D6F404E9E8DC22BB9462E306E@realtek.com.tw><s5hwqjn8ugb.wl%tiwai@suse.de><1BEA73746856429CA4D74A71E9BC9D78@realtek.com.tw>
 <s5h61r65ods.wl%tiwai@suse.de>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id A204D26530D
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 08:14:24 +0100 (CET)
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

Hi Takashi,

I forgot to remove one line for hp_automute_hook from 
alc283_fixup_chromebook.

>From 251e68d32dd1028353b7eef3ae557be7c10fae8c Mon Sep 17 00:00:00 2001
From: Kailang Yang <kailang@realtek.com>
Date: Wed, 4 Dec 2013 15:06:14 +0800
Subject: [PATCH] ALSA: hda/realtek - remove hp_automute_hook from
 alc283_fixup_chromebook

I forgot to remove the hp_automute_hook from alc283_fixup_chromebook.
It doesn't need this for other chrome os machine.

Signed-off-by: Kailang Yang <kailang@realtek.com>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d9509d76..d510a88 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3666,7 +3666,6 @@ static void alc283_fixup_chromebook(struct hda_codec 
*codec,
   snd_hda_override_wcaps(codec, 0x03, 0);
   /* Disable AA-loopback as it causes white noise */
   spec->gen.mixer_nid = 0;
-  spec->gen.hp_automute_hook = alc283_hp_automute_hook;
   break;
  case HDA_FIXUP_ACT_INIT:
   /* Enable Line1 input control by verb */


Thanks.
Kailang


> At Tue, 3 Dec 2013 16:12:49 +0800,
> Kailang wrote:
>>
>> Hi Takashi,
>>
>> I merged two patch to attach patch.
>> Change log also post on it.
>
> Thanks, it looks better now, and I applied it.
>
>
> Takashi
>
>>
>> Thanks.
>> Kailang.
>>
>>
>> > At Mon, 2 Dec 2013 17:21:43 +0800,
>> > Kailang wrote:
>> >>
>> >> Hi Takashi,
>> >>
>> >> HP Chrome Book, the headset jack was difference between other chrome
>> >> book.
>> >> It need to manual control Mic jack detect.
>> >
>> > So, this patch moves the thing to a model entry.  I see now the
>> > reason of the previous patch.
>> >
>> > But, please put what you wrote above into the patch changelog.  There
>> > is way too little description in the patch wrt the purpose and the
>> > implementation of the patch.
>> >
>> > And, if we define these different models here, the previous patch to
>> > remove PCI SSID entry can be merged into this single patch.  This
>> > would be less confusing, IMO.  (Of course, add the description in the
>> > patch changelog as well.)
>> >
>> >
>> > thanks,
>> >
>> > Takashi
>> >
>> > ------Please consider the environment before printing this e-mail.
>> [2 0001-independent-of-model-hp.patch <application/octet-stream 
>> (quoted-printable)>]
>> 
