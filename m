From: Kusanagi Kouichi <slash@ma.neweb.ne.jp>
Subject: Re: [PATCH] ALSA: hda - Add digital BEEP
	generator	support for Realtek codecs.
Date: Sat, 7 Feb 2009 19:40:52 +0900
Message-ID: <200902071040534227980006MA83@nm06mta.auone-net.jp>
References: <200902031428523216360006MA62@nm06mta.auone-net.jp>
	<s5hbptjbna3.wl%tiwai@suse.de>
	<200902040837524161510006MA49@nm06mta.auone-net.jp>
	<s5hocxia1tx.wl%tiwai@suse.de>
	<200902041420132766610006MA66@nm06mta.auone-net.jp>
	<s5hljsm8doj.wl%tiwai@suse.de> <s5hprhv7ct2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nmomta.auone-net.jp (nm06omta08.auone-net.jp [219.125.112.25])
	by alsa0.perex.cz (Postfix) with SMTP id E66E81037E3
	for <alsa-devel@alsa-project.org>; Sat,  7 Feb 2009 11:40:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hprhv7ct2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 06, 2009 at 05:25:13PM +0100, Takashi Iwai wrote:
> At Wed, 04 Feb 2009 15:44:12 +0100,
> I wrote:
> > 
> > At Wed, 4 Feb 2009 23:20:12 +0900,
> > Kusanagi Kouichi wrote:
> > > 
> > > On Wed, Feb 04, 2009 at 12:17:14PM +0100, Takashi Iwai wrote:
> > > > Fair enough.
> > > > 
> > > > Though, there is still one problem -- not all models enabled the
> > > > analog beep path.  So, the next step is to create beep controls in all
> > > > possible situations.
> > > 
> > > I'll try later.
> > 
> > This can be a separate (additional) patch.  Let's get the first patch
> > into the main tree so that one can work on further issues.
> 
> ... and now fixed on sound git tree.

Some models for alc268 still seems to lack a beep control.
Is it OK to add a beep control unconditionally?

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-hda-Add-mising-beep-controls-for-realtek-alc268-cod.patch"

>From 184d1a1b1c3976a8a76b2f3b40ad02992b44db48 Mon Sep 17 00:00:00 2001
From: Kusanagi Kouichi <slash@ma.neweb.ne.jp>
Date: Sat, 7 Feb 2009 19:30:05 +0900
Subject: [PATCH] hda: Add mising beep controls for realtek alc268 codec.

So far, some models didn't add a beep control since they don't use
analog beep in.

Signed-off-by: Kusanagi Kouichi <slash@ma.neweb.ne.jp>
---
 sound/pci/hda/patch_realtek.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f594a09..2fa26f9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11887,7 +11887,7 @@ static struct snd_pci_quirk alc268_cfg_tbl[] = {
 
 static struct alc_config_preset alc268_presets[] = {
 	[ALC267_QUANTA_IL1] = {
-		.mixers = { alc267_quanta_il1_mixer },
+		.mixers = { alc267_quanta_il1_mixer, alc268_beep_mixer },
 		.init_verbs = { alc268_base_init_verbs, alc268_eapd_verbs,
 				alc267_quanta_il1_verbs },
 		.num_dacs = ARRAY_SIZE(alc268_dac_nids),
@@ -11969,7 +11969,7 @@ static struct alc_config_preset alc268_presets[] = {
 	},
 	[ALC268_ACER_ASPIRE_ONE] = {
 		.mixers = { alc268_acer_aspire_one_mixer,
-				alc268_capture_alt_mixer },
+				alc268_capture_alt_mixer, alc268_beep_mixer },
 		.init_verbs = { alc268_base_init_verbs, alc268_eapd_verbs,
 				alc268_acer_aspire_one_verbs },
 		.num_dacs = ARRAY_SIZE(alc268_dac_nids),
-- 
1.5.6.5


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--UlVJffcvxoiEqYs2--
