From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: [BUG] NULL pointer dereference in patch_sigmatel.c
Date: Mon, 10 Aug 2009 02:02:06 +0300
Message-ID: <4A7F556E.9060809@pardus.org.tr>
References: <4A5F84D6.5040708@pardus.org.tr>
	<s5h1vofac2z.wl%tiwai@suse.de>	<s5hy6qn8wyj.wl%tiwai@suse.de>
	<4A7ADD87.4030109@pardus.org.tr>	<s5hfxc5114w.wl%tiwai@suse.de>
	<4A7BF4F7.20405@pardus.org.tr>	<ad2655cb0908070243h6318dbdep80d90a08fa6c435b@mail.gmail.com>	<s5hiqh0ymkn.wl%tiwai@suse.de>
	<4A7C03BE.7040300@pardus.org.tr>	<s5hd477zyo1.wl%tiwai@suse.de>
	<4A7C2E87.1060102@pardus.org.tr>	<s5hljlvyc8m.wl%tiwai@suse.de>
	<4A7EBCB7.8010104@pardus.org.tr> <s5h63cwvpbd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.uludag.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FAE024588
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 01:02:12 +0200 (CEST)
In-Reply-To: <s5h63cwvpbd.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Sun, 09 Aug 2009 15:10:31 +0300,
>
>   
> Could you load the module with probe_only=1 option and give
> alsa-info.sh output (or at least codec#* proc file)?
>   

Ok, will provide that info too. BTW,

CPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1b.0 to 64
** codec:0xf5846800
** spec->dmux_nids:0x00000000
BUG: unable to handle kernel NULL pointer dereference at 00000000
IP: [<f8c7b4d5>] :snd_hda_codec_idt:stac92xx_init+0x29b/0x520
*pde = 00000000 
Oops: 0000 [#1] SMP


spec->dmux_nids is NULL. Found the following commit:

From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 29 Jul 2009 14:32:55 +0000 (+0200)
Subject: ALSA: hda - Add missing DMUX initialization for auto-mic with STAC/IDT
X-Git-Url: http://git.kernel.org/?p=linux%2Fkernel%2Fgit%2Ftiwai%2Fsound-2.6.git;a=commitdiff_plain;h=15b4f296fce683497ecc815b2f9b6f121fb3fef8

ALSA: hda - Add missing DMUX initialization for auto-mic with STAC/IDT

Added the missing initialization of DMUX connection (to analog input)
for auto-mic mode with STAC/IDT codecs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index abc44db..2405f84 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4359,6 +4359,9 @@ static int stac92xx_init(struct hda_codec *codec)
 			stac_toggle_power_map(codec, cfg->hp_pins[i], 1);
 	}
 	if (spec->auto_mic) {
+		/* initialize connection to analog input */
+		snd_hda_codec_write_cache(codec, spec->dmux_nids[0], 0,
+					  AC_VERB_SET_CONNECT_SEL, 0);
 		if (enable_pin_detect(codec, spec->ext_mic.pin, STAC_MIC_EVENT))
 			stac_issue_unsol_event(codec, spec->ext_mic.pin);
 	}
