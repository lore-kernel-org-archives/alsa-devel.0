From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: When select 2.1 profile in pulseaudio,
 how do pulseaudio select notebook 's internal subwoofer or 5.1
 external speaker ?
Date: Sun, 12 Jul 2015 17:17:30 +0800
Message-ID: <CAN8ccibtBLuTDv6ABvuFv-HCv=R7ntJfKR64bO=-XjUAOQvcWg@mail.gmail.com>
References: <CAN8ccia43iJJOkB9w=XOxHBNtaO52ExJ4brKZCFGT=sxcik0VA@mail.gmail.com>
 <1572017.Cv3FZsEbDC@luklap.workgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id D5637260687
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2015 11:17:31 +0200 (CEST)
Received: by oihq81 with SMTP id q81so23157062oih.2
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2015 02:17:30 -0700 (PDT)
In-Reply-To: <1572017.Cv3FZsEbDC@luklap.workgroup>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?xYF1a2FzeiBXb2puacWCb3dpY3o=?= <lukasz.wojnilowicz@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, tiwai@suse.de, David Henningsson <david.henningsson@canonical.com>, Anssi Hannula <anssi.hannula@iki.fi>
List-Id: alsa-devel@alsa-project.org

> >
> > Do pulseaudio 2.1 profile select the internal subwoofer or your 5.1
> > external speaker ?
>
> My external speaker (i.e not subwoofer but center). It always was so.
>

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=ee81abb623cb5e03c182d16871bb4fb34fdc9b4f

+/* default channel maps for 2.1 speakers;
+ * since HD-audio supports only stereo, odd number channels are omitted
+ */
+const struct snd_pcm_chmap_elem snd_pcm_2_1_chmaps[] = {
+ { .channels = 2,
+   .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR } },
+ { .channels = 4,
+   .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,
+    SNDRV_CHMAP_LFE, SNDRV_CHMAP_LFE } },
+ { }
+};

The default 2.1 channel map for internal subwoofer does not has 5.1 channel
map

But your notebook have three jacks at ext front which support 5.1
In your case,there is no default 2.1 channel map when the current model has
three speaker pins

after remove the not exist internal surround speakers,


     [ALC882_FIXUP_ACER_ASPIRE_4930G] = {
-        .type = HDA_FIXUP_PINS,
-        .v.pins = (const struct hda_pintbl[]) {
-            { 0x16, 0x99130111 }, /* CLFE speaker */
-            { 0x17, 0x99130112 }, /* surround speaker */
-            { }
-        },


you need to use the left channel version of  2.1 channel and 5.1 channel map

+static const struct snd_pcm_chmap_elem acer_pcm_chmaps[] = {

+ { .channels = 2, + .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR } }, + {
.channels = 4, + .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,

+ SNDRV_CHMAP_LFE, SNDRV_CHMAP_NA } }, /* LFE only on left */

+ { .channels = 4, + .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,

+ SNDRV_CHMAP_RL, SNDRV_CHMAP_RR } },

+ { .channels = 6,

+ .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,

+ SNDRV_CHMAP_RL, SNDRV_CHMAP_RR,

+ SNDRV_CHMAP_FC, SNDRV_CHMAP_LFE } },

+ { }

+};


http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=48f1b308cc66152eb6db66742dd0d08d888cda8d;hp=5c4cd46810cef8850b037fca9e38ffd43b0bff2
<http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=48f1b308cc66152eb6db66742dd0d08d888cda8d;hp=5c4cd46810cef8850b037fca9e38ffd43b0bff22>

conf: Allow 2.1 surround to use different number of channels

This way, cards that support LFE on four channels (e g laptop with
internal subwoofer) can do that, and other cards on a six channel setup
can use that as well.


which channel map is used by alsa lib when you open surround21 pcm device
since your notebook will have both channel maps ?
