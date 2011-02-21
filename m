From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Fix mic initialization in VIA auto
 parser (was: pci/hda/patch_via.c - broken between 2.6.36 and 2.6.37
 (bisected))
Date: Mon, 21 Feb 2011 10:29:50 +0100
Message-ID: <4D62308E.8070606@canonical.com>
References: <ijqrmf$tlg$1@dough.gmane.org>	<AANLkTin4TQvLwZX_mjhHq66STrsrXJu9a+bvsiSdxXub@mail.gmail.com>	<4D6223CD.4060900@canonical.com>
	<AANLkTinDJ7k3pXqg7ZP5pcGVXUt+xWYRTv-pa4_=J15b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080401030604030008020500"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 4730A24392
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 10:29:53 +0100 (CET)
In-Reply-To: <AANLkTinDJ7k3pXqg7ZP5pcGVXUt+xWYRTv-pa4_=J15b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Goldstein <goldstein.mark@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080401030604030008020500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 2011-02-21 09:43, Mark Goldstein wrote:
> On Mon, Feb 21, 2011 at 10:35 AM, David Henningsson
> <david.henningsson@canonical.com>  wrote:
>> On 2011-02-20 12:06, Mark Goldstein wrote:
>>>
>>> I think the Mic part might be the same problem I had. I found out that
>>> the following code:
>>>
>>> static void via_auto_init_analog_input(struct hda_codec *codec)
>>> {
>>>         struct via_spec *spec = codec->spec;
>>>         const struct auto_pin_cfg *cfg =&spec->autocfg;
>>>         unsigned int ctl;
>>>         int i;
>>>
>>>         for (i = 0; i<    cfg->num_inputs; i++) {
>>>                 hda_nid_t nid = cfg->inputs[i].pin;
>>>                 if (spec->smart51_enabled&&    is_smart51_pins(spec, nid))
>>>                         ctl = PIN_OUT;
>>>                 else if (i == AUTO_PIN_MIC)
>>>                           ^^^^^^^^^^^^^^^^^^^^^^^^^
>>>                         ctl = PIN_VREF50;
>>>                 else
>>>                         ctl = PIN_IN;
>>>                 snd_hda_codec_write(codec, nid, 0,
>>>                                     AC_VERB_SET_PIN_WIDGET_CONTROL, ctl);
>>>         }
>>> }
>>>
>>> configures correctly only the first MIC (in my case it was Rear MIC).
>>> Front Mic pin was configured as HiZ.
>>> Changing the underlined condition to
>>>
>>> else if (cfg->input[i].type == AUTO_PIN_MIC)
>>>
>>> resolved the issue for me. (In alsa driver 1.0.23 this code was
>>> different, it checked that i<= FRONT_MIC index).
>>>
>>> I'm also just the user of alsa driver, so can't decide whether this is
>>> the proper fix. Maybe someone of knowledgeable developers could check
>>> it.
>>
>> It looks like the proper fix to me. If you like the fame and fortune ;-) of
>> having a commits in the kernel, I encourage you to submit a patch. Remember
>> to have proper "Cc: stable@kernel.org" and "Signed-off-by" lines in the the
>> patch header, and to cc Takashi on the resulting email.
>>
>> If not, I'll be happy to do it for you. It seems like an important fix to
>> me.
>>
>> --
>> David Henningsson, Canonical Ltd.
>> http://launchpad.net/~diwic
>>
>
> David,
>
> I've never dealt with submitting patches, so probably it'll be better
> (and definitely faster) if you could do it.
>
> Thank you,

Ok, here comes the patch!

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------080401030604030008020500
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Fix-mic-initialization-in-VIA-auto-parser.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Fix-mic-initialization-in-VIA-auto-parser.patc";
 filename*1="h"

>From a28dd20815b47134bc342a6ec9b9da6e80f59837 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 21 Feb 2011 10:23:18 +0100
Subject: [PATCH] ALSA: HDA: Fix mic initialization in VIA auto parser

This typo caused some microphone inputs not to be correctly
initialized on VIA codecs.

Reported-By: Mark Goldstein <goldstein.mark@gmail.com>
Cc: stable@kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_via.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index a76c326..63b0054 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -567,7 +567,7 @@ static void via_auto_init_analog_input(struct hda_codec *codec)
 		hda_nid_t nid = cfg->inputs[i].pin;
 		if (spec->smart51_enabled && is_smart51_pins(spec, nid))
 			ctl = PIN_OUT;
-		else if (i == AUTO_PIN_MIC)
+		else if (cfg->inputs[i].type == AUTO_PIN_MIC)
 			ctl = PIN_VREF50;
 		else
 			ctl = PIN_IN;
-- 
1.7.1


--------------080401030604030008020500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080401030604030008020500--
