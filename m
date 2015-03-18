From: Hui Wang <hui.wang@canonical.com>
Subject: Re: getting the sound to work on my asus m6s00v
Date: Wed, 18 Mar 2015 10:05:01 +0800
Message-ID: <5508DD4D.3040901@canonical.com>
References: <5a713868662bb9ea47f5a30bd1849ce8@swn.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 56ED1260418
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 03:05:09 +0100 (CET)
In-Reply-To: <5a713868662bb9ea47f5a30bd1849ce8@swn.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christian Gleerup <cromozon@swn.nu>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/18/2015 05:45 AM, Christian Gleerup wrote:
> I had some problems getting the sound to work on my asus m6s00v
> (I think that is the model, it is a bit worn so I can't really read it)
>
> the symptoms was
> * on the integrated speakers, no sound at all
> * on the headphone speakers, sound for a very very short period that faded into nothing.
>
> with help from debianuser on freenode#alsa we managed to get it working.
> the option that i had to load the module with is the following:
> sudo modprobe snd-hda-intel model=3stack-digout
> the status now (perfect)...
> * sound on integrated speaker.
> * sound in headphones (disables integrated speaker output which is fine)
> * mic works, both for direct playback and recording
> * when recording it is the 'digital' channel that controls the volume of the recording level, all others
>
> Notice:
> I don't have OSS or pulseaudio installed.
>
> I am thinking it would be really nice if the driver automatically could detect that this option is required.
>
> this is the output from the alsa-info script
> http://www.alsa-project.org/db/?f=28b98a3bd1efc6a80dbd5c54b52c4472d8ea5496
>
> let me know if I can do anything to help with this.
It seems the latest kernel already had a fixup for this machine, but the 
fixup is ALC880_FIXUP_ASUS_W5A instead of ALC880_FIXUP_3ST_DIG. Probably 
you should use latest upstream kernel without "model=3stack-digout" to 
test again, if it can't fix your problem, maybe the patch below can work.

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1349,7 +1349,7 @@ static const struct hda_fixup alc880_fixups[] = {

  static const struct snd_pci_quirk alc880_fixup_tbl[] = {
         SND_PCI_QUIRK(0x1019, 0x0f69, "Coeus G610P", ALC880_FIXUP_W810),
-       SND_PCI_QUIRK(0x1043, 0x10c3, "ASUS W5A", ALC880_FIXUP_ASUS_W5A),
+       SND_PCI_QUIRK(0x1043, 0x10c3, "ASUS W5A", ALC880_FIXUP_3ST_DIG),
         SND_PCI_QUIRK(0x1043, 0x1964, "ASUS Z71V", ALC880_FIXUP_Z71V),
         SND_PCI_QUIRK_VENDOR(0x1043, "ASUS", ALC880_FIXUP_GPIO1),
         SND_PCI_QUIRK(0x147b, 0x1045, "ABit AA8XE", 
ALC880_FIXUP_6ST_AUTOMUTE),

> Regards.
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
