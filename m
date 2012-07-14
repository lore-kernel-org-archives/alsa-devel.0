From: Wang Xingchao <wangxingchao2011@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Add DeviceID for Haswell HDA
Date: Sat, 14 Jul 2012 17:25:19 +0800
Message-ID: <CA+v+29g9o3254YwD_e9MkP38roTN0dTUoUrs8TZNTtJ_pXkLRQ@mail.gmail.com>
References: <1339554232-3410-1-git-send-email-xingchao.wang@intel.com>
	<s5hr4tjwvxz.wl%tiwai@suse.de> <50005F66.3050401@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
	[209.85.216.44]) by alsa0.perex.cz (Postfix) with ESMTP id 352A724376
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Jul 2012 11:25:40 +0200 (CEST)
Received: by qadz3 with SMTP id z3so826730qad.17
	for <alsa-devel@alsa-project.org>; Sat, 14 Jul 2012 02:25:39 -0700 (PDT)
In-Reply-To: <50005F66.3050401@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2012/7/14 Jaroslav Kysela <perex@perex.cz>:
> Date 13.6.2012 08:46, Takashi Iwai wrote:
>> At Wed, 13 Jun 2012 10:23:51 +0800,
>> Wang Xingchao wrote:
>>>
>>> this patch add proper id for Haswell HDA Controller.
>>>
>>> Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
>>
>> Oh, now ID number decreases to 0xxx? :)
>>
>> While we are on this: could you verify whether position_fix=4 (combo)
>> options works for Haswell?  In this mode, LPIB is used for playback
>> positioning while POS buffer is used for capture.
>>
>> Seth (Cc'ed) figured out that this mode works better than the default
>> (usually POS buf both for playback and capture) on the recent Intel
>> controller chips, so I guess it'd be applied to Haswell, too.
>
> The combo works OK for the Haswell. I think that the patch should be
> applied with the HDMI ID patch "[PATCH] ALSA: hda - add Haswell HDMI pci
> id".
>
> Acked-by: Jaroslav Kysela <perex@perex.cz>
>
> But it seems that the HDA bridge (8086:0c0c) with the HDMI codecs is
> detected as first in the PCI probe in this system, which is not ideal.
> So the card0 is HDMI only and card1 is analog:
>

that's right. In the board named Sharkbay there're two HDA
controllers, one is Lynxpoint HDA with ALC* codec and the other one is
Haswell HDA which only connected with HDMI audio. There's also drm
patches to enable HDMI audio on haswell, i will send them out after
some cleanup.

also please wait a moment before apply this patch, it's not the final
right version after some work on HDMI audio enabling. At least the
driver type is "SCH" not "PCH".  i will resend the patch in second
version.

Before that i will also verify whether Haswell could work well with
test Seth's patch.

thanks
--xingchao
