From: Ralf Jung <post@ralfj.de>
Subject: Re: PROBLEM: Internal microphone (& combined headset
 jack, in default config) not working on Acer VN7-592G (Skylake)
Date: Sun, 15 Jan 2017 10:52:12 +0100
Message-ID: <fe7fce02-9f22-53e9-f7a3-fa74bfbf3e66@ralfj.de>
References: <990a87bf-735b-d978-b6ba-74bb7a65a244@ralfj.de>
 <s5ha8avyywb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------6932041063FD79FF12760C0D"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eins.ralfj.de (eins.ralfj.de [85.214.220.216])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C4182654AD
 for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2017 10:52:15 +0100 (CET)
In-Reply-To: <s5ha8avyywb.wl-tiwai@suse.de>
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

This is a multi-part message in MIME format.
--------------6932041063FD79FF12760C0D
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

Hi,

Thanks for the quick reply!

>> I was able to improve the situation by adding this to modprobe.d:
>>   options snd-hda-intel model=dell-headset-multi
>> Now, mics and external speakers plugged in work fine (where for mics, I
>> need to manually configure them in pacuvontrol: "Speakers" and
>> "Microphone").  Combined headsets also work (with "Headphones" and
>> "Headset Microphone"), i.e. I get audio in and audio out, but the audio
>> in from the microphone is fairly noisy.  I am not sure whether this is
>> due to the headset or the laptop; I am using the same headset with my
>> phone and people I called did not complain about noise.
>>   Furthermore, there is a weird effect: I have a headset with *separate*
>> plugs for speaker and mic (which I used above to test the speaker vs.
>> mic functionality).  If I plug in the speaker part, but configure it as
>> a microhpone (out: "Speakers", in: "Microphone"), then I actually get a
>> (rather noisy) input signal. Not sure what is going on there, but I'm
>> reasonably sure it is getting that signal from the headset, not the
>> internal mic of the laptop.
> 
> It's a configuration with "headphone mic" for Dell, so it doesn't fit
> with yours properly.
> 
> Look at the lspci -nv output, and check the PCI SSID of the
> corresponding device.  Then try to add an entry applying some fixup,
> e.g. ALC269_FIXUP_ASPIRE_HEADSET_MIC, in alc269_fixup_tbl[] defined in
> sound/pci/hda/patch_realtek.c:
> 
> static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> .....
>         SND_PCI_QUIRK(0x1025, XXXX, "Acer Your Model", ALC269_FIXUP_ASPIRE_HEADSET_MIC),
> .....
> 
> There are other definitions for 1025:*, so put your own one there.
> The list is sorted in the id number order.
> 
> There are quite lots of fixup models that can be applied, do figure
> out by trial-and-error.

I tried a bunch of fixup models (and even defined one myself), but none
of them made the internal microhpone work.  Funny enough, the
definitions involving "DELL" work best.

Here's what I tried:

ALC269_FIXUP_ASPIRE_HEADSET_MIC, ALC255_FIXUP_ASPIRE_HEADSET_MIC [*]:
Combined headset plugged into the hack works. PLugging in a "pure" mic
doesn't. pavuctl says "Headset Microphone (unplugged)".

ALC255_FIXUP_HEADSET_MODE, ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC:
No mic works, pavuctl: "Analog Input"

ALC255_FIXUP_DELL1_MIC_NO_PRESENCE, ALC269_FIXUP_DELL1_MIC_NO_PRESENCE:
pavuctl: "Headset Microhpone" & "Microphone". Both kinds of microphone
work (after sometimes manually selecting the right thing in pavuctl),
but the "pure" mix has a 50 Hz noise on it that goes away when I unplug
all cable. Notice that this is running the laptop in a different place
and with a different mic than when I previously tried just passing an
option to the vanilla module, so I don't know whether the 50 Hz hum also
appears in the other conditions.  There's no 50 Hz hum with the
"combined" headset.
  There's a weird bug: When starting Audacity, playback breaks and I
have to switch (in pavuctl) to "Microphone" and then back to "Headset
Microphone" to make it work again.

[*] See attached patch.  Notice that I don't know what I am doing here,
I am just pattern-matching.

I can't realistically try all the hundreds of fixups, so I tried those
that sounded most realistic and those that mention ALC255 (which seems
to be the chip I have).  However, as can be seen above, ALC269-fixups
vs. ALC255-fixups doesn't seem to make any difference.

Kind regards,
Ralf

--------------6932041063FD79FF12760C0D
Content-Type: text/x-diff;
 name="sound-fixup.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="sound-fixup.patch"

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.=
c
index 3f75d1b83bf2..fd2af7bfc5eb 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4825,6 +4825,7 @@ enum {
 	ALC255_FIXUP_DELL2_MIC_NO_PRESENCE,
 	ALC255_FIXUP_HEADSET_MODE,
 	ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC,
+	ALC255_FIXUP_ASPIRE_HEADSET_MIC,
 	ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC292_FIXUP_TPT440_DOCK,
 	ALC292_FIXUP_TPT440,
@@ -5302,6 +5303,15 @@ static const struct hda_fixup alc269_fixups[] =3D =
{
 		.type =3D HDA_FIXUP_FUNC,
 		.v.func =3D alc_fixup_headset_mode_alc255_no_hp_mic,
 	},
+	[ALC255_FIXUP_ASPIRE_HEADSET_MIC] =3D {
+		.type =3D HDA_FIXUP_PINS,
+		.v.pins =3D (const struct hda_pintbl[]) {
+			{ 0x19, 0x01a1913c }, /* headset mic w/o jack detect */
+			{ }
+		},
+		.chained =3D true,
+		.chain_id =3D ALC255_FIXUP_HEADSET_MODE,
+	},
 	[ALC293_FIXUP_DELL1_MIC_NO_PRESENCE] =3D {
 		.type =3D HDA_FIXUP_PINS,
 		.v.pins =3D (const struct hda_pintbl[]) {
@@ -5543,6 +5553,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[=
] =3D {
 	SND_PCI_QUIRK(0x1025, 0x0775, "Acer Aspire E1-572", ALC271_FIXUP_HP_GAT=
E_MIC_JACK_E1_572),
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIR=
E_V5_PINS),
 	SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_CHROME_=
BOOK),
+	SND_PCI_QUIRK(0x1025, 0x1039, "Acer Aspire VN7-592G", ALC255_FIXUP_ASPI=
RE_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_DELL_XP=
S),
 	SND_PCI_QUIRK(0x1028, 0x05bd, "Dell Latitude E6440", ALC292_FIXUP_DELL_=
E7X),

--------------6932041063FD79FF12760C0D
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------6932041063FD79FF12760C0D--
