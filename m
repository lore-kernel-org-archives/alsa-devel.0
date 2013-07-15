From: Kailang <kailang@realtek.com>
Subject: Re: [PATCH] ALSA: hda - Fix error accessing
	non-existent node for Realtek codecs
Date: Mon, 15 Jul 2013 17:33:45 +0800
Message-ID: <D8B2B171026A4233BF92EE8F855CB5B3@realtek.com.tw>
References: <1373876452-11336-1-git-send-email-david.henningsson@canonical.com><s5hy598yzgh.wl%tiwai@suse.de>	<51E3B9A8.3020806@canonical.com>
 <s5hr4f0yxzw.wl%tiwai@suse.de>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id C08FC26084D
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 11:33:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Yes, DSP could be connected to any codecs.
Because Intel use alc282 codec. So, we patched alc269 variants now.

----- Original Message ----- 
From: "Takashi Iwai" <tiwai@suse.de>
To: "David Henningsson" <david.henningsson@canonical.com>
Cc: <alsa-devel@alsa-project.org>; <mengdong.lin@intel.com>; "Kailang" 
<kailang@realtek.com>
Sent: Monday, July 15, 2013 5:26 PM
Subject: Re: [PATCH] ALSA: hda - Fix error accessing non-existent node for 
Realtek codecs


At Mon, 15 Jul 2013 10:58:16 +0200,
David Henningsson wrote:
>
> On 07/15/2013 10:55 AM, Takashi Iwai wrote:
> > At Mon, 15 Jul 2013 10:20:52 +0200,
> > David Henningsson wrote:
> >>
> >> A recent commit caused my hda-emu based test tool to complain about
> >> accessing nodes that don't exist. This simple test works around this.
> >>
> >> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
> >> ---
> >>   sound/pci/hda/patch_realtek.c |    3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> I don't have ALC5505 hardware here, no alsa-info to look at, and I 
> >> don't know
> >> what it is. Therefore it would be good with some confirmation that this 
> >> patch
> >> does not break such hardware, which could be the case if the Realtek 
> >> codec
> >> breaks the HDA spec by having "hidden" nodes.
> >
> > It seems that ALC5505 itself doesn't appear in the codec information
> > but it appears transparent to the real codec behind it.  So the node
> > 0x51 doesn't exist in the widget list of the codec, and your  patch
> > will break.
>
> I suspected that, but without alsa-info there was no way to tell if this
> was the case or not.
>
> > we may need to patch hda-emu instead...
>
> Okay. Also, is there a way to limit the effect here, like, what codec
> (or codec variants) have this secret 0x51 node? Right now it's being
> tested for most of ALC2xx codecs.

I guess this won't be limited to any codec type.  The DSP itself seems
transparent, so it could be connected to any codec.

Right now, we patched alc269 variants because they are only real
cases, so far.


Takashi


>
> >
> >
> > Takashi
> >
> >>
> >> diff --git a/sound/pci/hda/patch_realtek.c 
> >> b/sound/pci/hda/patch_realtek.c
> >> index 8bd2261..ca73f10 100644
> >> --- a/sound/pci/hda/patch_realtek.c
> >> +++ b/sound/pci/hda/patch_realtek.c
> >> @@ -3844,7 +3844,8 @@ static int patch_alc269(struct hda_codec *codec)
> >>   break;
> >>   }
> >>
> >> - if (snd_hda_codec_read(codec, 0x51, 0, AC_VERB_PARAMETERS, 0) == 
> >> 0x10ec5505) {
> >> + if (codec->num_nodes > 0x51 &&
> >> +     snd_hda_codec_read(codec, 0x51, 0, AC_VERB_PARAMETERS, 0) == 
> >> 0x10ec5505) {
> >>   spec->has_alc5505_dsp = true;
> >>   spec->init_hook = alc5505_dsp_init;
> >>   }
> >> --
> >> 1.7.9.5
> >>
> >
>
>
>
> -- 
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
>

------Please consider the environment before printing this e-mail. 
