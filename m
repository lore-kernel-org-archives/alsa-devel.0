From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Possible fix for snd-hda-intel model=no-jd failing
 since ~linux-3.9-rc1
Date: Thu, 11 Sep 2014 11:07:10 +0200
Message-ID: <5411663E.8070106@canonical.com>
References: <1410421639.47518.YahooMailNeo@web160601.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000904060301020605000605"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C3CB26501D
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 11:07:04 +0200 (CEST)
In-Reply-To: <1410421639.47518.YahooMailNeo@web160601.mail.bf1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Richter <adam_richter2004@yahoo.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000904060301020605000605
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit



On 2014-09-11 09:47, Adam Richter wrote:
> Hi.

Hi Adam,

Interesting problem. Could you submit alsa-info ( 
http://www.alsa-project.org/alsa-info.sh ) and point us to it? It makes 
it possible to run the code in an emulator.

> This is a bug and suggested temporary fix that I originally posted to the linux-sound mailing list about a month and a half ago.  I am grateful to Takashi Awai for informing me after my follow-up inquiry about it today that I should submit it to the alsa-devel mailing list instead.  Please feel free to redirect me further if appropriate.  I did not notice any contact information for sound/pci/hda in
> linux-3.16-rc4/MAINATINERS.
>
> Anyhow, here is the bug report and a one line proposed temporary fix.
>
>
> The "model=no-jd" argument has not initialized the analog audio output jack correctly for me since linux-3.9-rc1 (if I recall correctly) through linux-3.17-rc4, although I have not tried every release candidate in between.

A lot of things changed with 3.9, so that makes sense. Btw, 
"model=no-jd" works only for specific machines. You can use the hint 
"jack-detect=0" instead.

> The symptom is that, on a computer with an analog audio output jack
> that has incorrect jack sense (a hardware bug), audio output is completely muted until I physically replug the cable, even though I specified "model=no-jd" as an argument to the snd-hda-intel kernel module, which is supposed to cause the kernel to ignore the jack sense reported by hardware and just drive the audio output even if the hardware jack sense indicates nothing is plugged in.  This problem did not occur until approximate Linux 3.9-rc1.
>
> I have found a few single line workarounds that work, of which my
> favorite is the following (also attached to this email, in case any
> mailer subjects this message to reformatting), because it does not add
> code to anything that gets called frequently.
>
> --- linux-3.17.0-rc4-64bit/sound/pci/hda/hda_jack.c.orig    2014-09-07 16:09:43.000000000 -0700
> +++ linux-3.17.0-rc4-64bit/sound/pci/hda/hda_jack.c    2014-09-10 18:41:53.422900040 -0700
> @@ -106,6 +106,7 @@ snd_hda_jack_tbl_new(struct hda_codec *c
>       jack->nid = nid;
>       jack->jack_dirty = 1;
>       jack->tag = codec->jacktbl.used;
> +    jack->phantom_jack = codec->no_jack_detect;
>       return jack;
>   }
>   EXPORT_SYMBOL_GPL(snd_hda_jack_tbl_new);
>
>
> Signed-off-by: Adam J. Richter <adam_richter2004@yahoo.com>
>
>
> I consider this a workaround rather than than a perfect fix, because I
> think the underlying problem seems to be some kind of initialization
> order issue that I don't fully understand.  Basically, by the time
> jack->phantom_jack was being set, some caller had already called
> jack_detect_update(), which loaded the incorrect jack sense result
> from hardware and cleared jack->jack_dirty, so the jack sense would
> not be set again.  At least that is what I think the underlying
> problem probably is.
>
> Also, if a change like this is to be integrated, I'd like to know if
> it might be better for the line that I added to be:
>
>            jack->phantom_jack = !is_jack_detectable(codec, nid);

Yes, this would probably be better.

I guess that somehow snd_hda_jack_enable_callback gets called for the 
phantom jack, but I'm not sure exactly how (alsa-info would help).

Nevertheless I'm attaching a patch. I assume it also resolves your problem?

Takashi, what do you think of the attached patch?

>
> ...which is what add_jack_kctl does (not sure why add_jack_kctls does
> not, by the way, at the risk of making a spectacle of my ignorance).
> My doubt about this approach is that perhaps is_jack_detectable()
> relies on some initialization that has not occurred at that point.
>
> Anyhow, I'd like to get the process started of either pushing this
> change upstream or quickly developing a more correct fix.  If a more
> correct fix does not become apparent in the next few days, I would
> recommend pushing the workaround upstream now until some future code
> cleanup, so people will no longer be effected by the bug.
>
> Any technical input or advice on how to proceed is welcome.  Thanks
> for taking the time to consider this.
>
>
> Adam Richter
>
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------000904060301020605000605
Content-Type: text/x-patch;
 name="0001-ALSA-hda-Do-not-enable-unsol-events-on-phantom-jacks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-Do-not-enable-unsol-events-on-phantom-jacks.pa";
 filename*1="tch"

>From e5ce94c6156d1c588f29745ade06d1d76c87a0a1 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Thu, 11 Sep 2014 11:04:42 +0200
Subject: [PATCH] ALSA: hda - Do not enable unsol events on phantom jacks

To make sure we don't enable unsol events on phantom jacks,
we move the logic for determining what a phantom jack is to
snd_hda_jack_tbl_new.

Reported-by: Adam Richter <adam_richter2004@yahoo.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_jack.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 9746d73..376ce8f 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -105,6 +105,12 @@ snd_hda_jack_tbl_new(struct hda_codec *codec, hda_nid_t nid)
 		return NULL;
 	jack->nid = nid;
 	jack->jack_dirty = 1;
+	if (get_wcaps_type(get_wcaps(codec, nid)) == AC_WID_PIN) {
+		unsigned int def_conf = snd_hda_codec_get_pincfg(codec, nid);
+		unsigned int conn = get_defcfg_connect(def_conf);
+		if ((conn != AC_JACK_PORT_COMPLEX) || !is_jack_detectable(codec, nid))
+			jack->phantom_jack = 1;
+	}
 	jack->tag = codec->jacktbl.used;
 	return jack;
 }
@@ -230,6 +236,8 @@ int snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
 		jack->action = action;
 	if (cb)
 		jack->callback = cb;
+	if (jack->phantom_jack)
+		return 0;
 	if (codec->jackpoll_interval > 0)
 		return 0; /* No unsol if we're polling instead */
 	return snd_hda_codec_write_cache(codec, nid, 0,
@@ -334,8 +342,8 @@ static void hda_free_jack_priv(struct snd_jack *jack)
  * This assigns a jack-detection kctl to the given pin.  The kcontrol
  * will have the given name and index.
  */
-static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
-			  const char *name, int idx, bool phantom_jack)
+int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
+			  const char *name, int idx)
 {
 	struct hda_jack_tbl *jack;
 	struct snd_kcontrol *kctl;
@@ -353,12 +361,11 @@ static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 	if (err < 0)
 		return err;
 	jack->kctl = kctl;
-	jack->phantom_jack = !!phantom_jack;
 
 	state = snd_hda_jack_detect(codec, nid);
 	snd_kctl_jack_report(codec->bus->card, kctl, state);
 #ifdef CONFIG_SND_HDA_INPUT_JACK
-	if (!phantom_jack) {
+	if (!jack->phantom_jack) {
 		jack->type = get_input_jack_type(codec, nid);
 		err = snd_jack_new(codec->bus->card, name, jack->type,
 				   &jack->jack);
@@ -371,12 +378,6 @@ static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 #endif
 	return 0;
 }
-
-int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
-			  const char *name, int idx)
-{
-	return __snd_hda_jack_add_kctl(codec, nid, name, idx, false);
-}
 EXPORT_SYMBOL_GPL(snd_hda_jack_add_kctl);
 
 /* get the unique index number for the given kctl name */
@@ -406,7 +407,7 @@ static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
 	unsigned int def_conf, conn;
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	int idx, err;
-	bool phantom_jack;
+	struct hda_jack_tbl *jack;
 
 	if (!nid)
 		return 0;
@@ -414,23 +415,25 @@ static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
 	conn = get_defcfg_connect(def_conf);
 	if (conn == AC_JACK_PORT_NONE)
 		return 0;
-	phantom_jack = (conn != AC_JACK_PORT_COMPLEX) ||
-		       !is_jack_detectable(codec, nid);
 
 	if (base_name) {
 		strlcpy(name, base_name, sizeof(name));
 		idx = 0;
 	} else
 		snd_hda_get_pin_label(codec, nid, cfg, name, sizeof(name), &idx);
-	if (phantom_jack)
+
+	jack = snd_hda_jack_tbl_new(codec, nid);
+	if (!jack)
+		return -ENOMEM;
+	if (jack->phantom_jack)
 		/* Example final name: "Internal Mic Phantom Jack" */
 		strncat(name, " Phantom", sizeof(name) - strlen(name) - 1);
 	idx = get_unique_index(codec, name, idx);
-	err = __snd_hda_jack_add_kctl(codec, nid, name, idx, phantom_jack);
+	err = snd_hda_jack_add_kctl(codec, nid, name, idx);
 	if (err < 0)
 		return err;
 
-	if (!phantom_jack)
+	if (!jack->phantom_jack)
 		return snd_hda_jack_detect_enable(codec, nid, 0);
 	return 0;
 }
-- 
1.9.1


--------------000904060301020605000605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000904060301020605000605--
