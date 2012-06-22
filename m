From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] Inverted internal mic
Date: Fri, 22 Jun 2012 19:33:06 +0200
Message-ID: <4FE4AC52.4050600@canonical.com>
References: <4F4C9714.1080307@canonical.com> <s5haa43ux7u.wl%tiwai@suse.de>
	<4F4CA438.90103@canonical.com> <s5hvcmrp7ji.wl%tiwai@suse.de>
	<4F4CD1AF.2050409@canonical.com> <s5hboojozx7.wl%tiwai@suse.de>
	<4F4CE264.7040008@canonical.com>
	<loom.20120619T050139-760@post.gmane.org>
	<4FE02D8B.7050201@canonical.com> <s5htxy6f6tt.wl%tiwai@suse.de>
	<4FE275AF.4080004@canonical.com> <s5hhau4esiu.wl%tiwai@suse.de>
	<4FE31BEC.20708@canonical.com> <s5hbokcerax.wl%tiwai@suse.de>
	<4FE32E74.1040902@canonical.com> <s5h62aj4rov.wl%tiwai@suse.de>
	<4FE44D1F.1060903@canonical.com> <s5h1ul7d31x.wl%tiwai@suse.de>
	<s5hsjdnbjka.wl%tiwai@suse.de> <4FE48EF7.6060101@canonical.com>
	<s5ha9zvbbno.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030106040506020209090705"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id D55BA103F54
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2012 19:32:59 +0200 (CEST)
In-Reply-To: <s5ha9zvbbno.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030106040506020209090705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 06/22/2012 05:37 PM, Takashi Iwai wrote:
> At Fri, 22 Jun 2012 17:27:51 +0200,
> David Henningsson wrote:
>>
>> On 06/22/2012 02:46 PM, Takashi Iwai wrote:
>>>    /*
>>> + * Inverted digital-mic handling
>>> + *
>>> + * First off, it's a bit tricky.  The "Inverted Internal Mic Capture Switch"
>>> + * gives the additional mute only to the right channel of the digital mic
>>> + * capture stream.  This is a workaround for avoiding the almost silence
>>> + * by summing the stereo stereo stream from some (known to be ForteMedia)
>>
>> Stereo stereo? It's "stereo" in stereo! :-)
>
> Yeah, quad channels.  Fixed now.
>
>>> + * digital mic unit.
>>> + *
>>> + * The logic is to call alc_inv_dmic_sync() after each action (possibly)
>>> + * modifying ADC amp.  When the mute flag is set, it mutes the R-channel
>>> + * without caching so that the cache can still keep the original value.
>>> + * The cached value is then restored when the flag is set off or any other
>>> + * than d-mic is used as the current input source.
>>
>> Ok, I get it now.
>>
>> There is a slight drawback with this (IMO a bit hacky) patch, and that
>> is that you can get a short signal spike on the right channel when you
>> turn "Capture Switch" on while "Inverted Capture" is off. Hopefully it
>> is not a practical problem.
>
> Right, I fully admit it's hacky :)
>
> A good thing by this is, however, that it doesn't touch other parts
> too intrusively but just wraps over it.
>
>> Thanks for looking at this long-standing problem :-)
>
> I'm going to commit it once after hearing the test with a real machine
> from Eliot.

Hi,

I'm adding the machines I know of in the patch attached (please commit 
together with your patch).

For users running Ubuntu 12.04 (I think Eliot does), I have also made a 
dkms package for easy testing of these two patches, and I also asked 
existing bug reporters to test it.

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1002978/+attachment/3200653/+files/alsa-hda-dkms_0.1_all.deb

Happy weekend!

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------030106040506020209090705
Content-Type: text/x-patch;
 name="0001-ALSA-hda-Add-inverted-mic-quirks-for-Asus-U41SV-Acer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-Add-inverted-mic-quirks-for-Asus-U41SV-Acer.pa";
 filename*1="tch"

>From d4e041e6d5077b061eb99954e9d71a5ad5f8f4de Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Fri, 22 Jun 2012 19:12:10 +0200
Subject: [PATCH] ALSA: hda - Add inverted mic quirks for Asus U41SV, Acer
 1810TZ and AOD260

These machines have inverted phase on right channel for their
internal mics.

BugLink: https://bugs.launchpad.net/bugs/997227
BugLink: https://bugs.launchpad.net/bugs/996611
BugLink: https://bugs.launchpad.net/bugs/1006089
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |   23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 53cd730..9be7da1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5918,6 +5918,14 @@ static void alc269_fixup_mic2_mute(struct hda_codec *codec,
 	}
 }
 
+static void alc269_fixup_inv_dmic(struct hda_codec *codec,
+				  const struct alc_fixup *fix, int action)
+{
+	if (action == ALC_FIXUP_ACT_PROBE)
+		alc_add_inv_dmic_mixer(codec, 0x12);
+}
+
+
 enum {
 	ALC269_FIXUP_SONY_VAIO,
 	ALC275_FIXUP_SONY_VAIO_GPIO2,
@@ -5936,6 +5944,7 @@ enum {
 	ALC269VB_FIXUP_AMIC,
 	ALC269VB_FIXUP_DMIC,
 	ALC269_FIXUP_MIC2_MUTE_LED,
+	ALC269_FIXUP_INV_DMIC,
 };
 
 static const struct alc_fixup alc269_fixups[] = {
@@ -6060,12 +6069,19 @@ static const struct alc_fixup alc269_fixups[] = {
 		.type = ALC_FIXUP_FUNC,
 		.v.func = alc269_fixup_mic2_mute,
 	},
+	[ALC269_FIXUP_INV_DMIC] = {
+		.type = ALC_FIXUP_FUNC,
+		.v.func = alc269_fixup_inv_dmic,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
+	SND_PCI_QUIRK(0x1025, 0x029b, "Acer 1810TZ", ALC269_FIXUP_INV_DMIC),
+	SND_PCI_QUIRK(0x1025, 0x0349, "Acer AOD260", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_MIC2_MUTE_LED),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
+	SND_PCI_QUIRK(0x1043, 0x1b13, "Asus U41SV", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x834a, "ASUS S101", ALC269_FIXUP_STEREO_DMIC),
@@ -6534,12 +6550,7 @@ static void alc272_fixup_mario(struct hda_codec *codec,
 		       "hda_codec: failed to override amp caps for NID 0x2\n");
 }
 
-static void alc662_fixup_inv_dmic(struct hda_codec *codec,
-				  const struct alc_fixup *fix, int action)
-{
-	if (action == ALC_FIXUP_ACT_PROBE)
-		alc_add_inv_dmic_mixer(codec, 0x12);
-}
+#define alc662_fixup_inv_dmic alc269_fixup_inv_dmic
 
 enum {
 	ALC662_FIXUP_ASPIRE,
-- 
1.7.9.5


--------------030106040506020209090705
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030106040506020209090705--
