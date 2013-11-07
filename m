From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [RFC] ALSA: hda - check for mute/micmute LEDs on
 all Lenovo machines (Realtek)
Date: Thu, 7 Nov 2013 09:58:45 +0800
Message-ID: <CAJ=jquZ0iir2e59d+afdj91JBYe2MiXsrQdam1PrS4BfKOdBmw@mail.gmail.com>
References: <1383744096-7510-1-git-send-email-david.henningsson@canonical.com>
 <s5hy551v3s7.wl%tiwai@suse.de> <s5htxfpv33f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f43.google.com (mail-qe0-f43.google.com
 [209.85.128.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 82BFA2610A8
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 02:58:46 +0100 (CET)
Received: by mail-qe0-f43.google.com with SMTP id nc12so376049qeb.2
 for <alsa-devel@alsa-project.org>; Wed, 06 Nov 2013 17:58:45 -0800 (PST)
In-Reply-To: <s5htxfpv33f.wl%tiwai@suse.de>
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
Cc: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, YK <yk@canonical.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

@Takashi and David,

DMI is a good way to check models, and we may not need to check the
years as older Thinkpads with no mute led do not have "MMTS" and
"SSMS" control methods in ACPI DSDT. Checking their existence before
making the actual calls in thinkpad-acpi avoids this problems.

Cheers,
Alex Hung

On Thu, Nov 7, 2013 at 1:42 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 06 Nov 2013 18:27:52 +0100,
> Takashi Iwai wrote:
>>
>> At Wed,  6 Nov 2013 14:21:36 +0100,
>> David Henningsson wrote:
>> >
>> > There are many Lenovo machines with mute and/or mic-mute LEDs, so
>> > a quirk list with every SSID would be a lot of maintenance.
>> >
>> > Instead make a vendor quirk in combination with letting the most
>> > common existing quirks also chain to the thinkpad_acpi quirk.
>> >
>> > Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>> > ---
>> >  sound/pci/hda/patch_realtek.c |   13 ++++++++++---
>> >  1 file changed, 10 insertions(+), 3 deletions(-)
>> >
>> > @Takashi,
>> > So, when we had a look at which machines we wanted to add support for, we found
>> > about 10 - 15 machines right away, and that's just the tip of the iceberg. So
>> > adding machine quirks just doesn't seem like the right way to go.
>> >
>> > I think our quirking system is becoming a bit limited here - as the "limit mic
>> > boost" quirk was used by several vendors I did an hackish chain instead of the
>> > normal .chain method. Open for less hackish solutions if you have any?
>> >
>> > @Alex Hung,
>> > this will start to hit Ideapads also, not only Thinkpads. Do you think
>> > there is any harm in that happening to Ideapads and similar, or do we have a
>> > good way to avoid machines that are not Thinkpads (and thus shouldn't call
>> > thinkpad-acpi, I assume)?
>>
>> There are lots of old Ideapads with ALC269, and I don't think they
>> have ACPI mute control.
>
> BTW, an easier way to identify Thinkpad is to just check DMI string.
>
> But, for Ideapads, this isn't really safe, I guess.  If any, you
> should check the year, too, for excluding the old models.
>
>
> Takashi
>
>>
>>
>> Takashi
>>
>> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> > index 215db60..ce30bc4 100644
>> > --- a/sound/pci/hda/patch_realtek.c
>> > +++ b/sound/pci/hda/patch_realtek.c
>> > @@ -3424,6 +3424,10 @@ static void alc269_fixup_limit_int_mic_boost(struct hda_codec *codec,
>> >     struct auto_pin_cfg *cfg = &spec->gen.autocfg;
>> >     int i;
>> >
>> > +   /* Chain to thinkpad_acpi, only if Lenovo */
>> > +   if (codec->bus->pci->subsystem_vendor == 0x17aa)
>> > +           alc_fixup_thinkpad_acpi(codec, fix, action);
>> > +
>> >     /* The mic boosts on level 2 and 3 are too noisy
>> >        on the internal mic input.
>> >        Therefore limit the boost to 0 or 1. */
>> > @@ -3697,6 +3701,8 @@ static const struct hda_fixup alc269_fixups[] = {
>> >     [ALC269_FIXUP_SKU_IGNORE] = {
>> >             .type = HDA_FIXUP_FUNC,
>> >             .v.func = alc_fixup_sku_ignore,
>> > +           .chained = true,
>> > +           .chain_id = ALC269_FIXUP_THINKPAD_ACPI,
>> >     },
>> >     [ALC269_FIXUP_ASUS_G73JW] = {
>> >             .type = HDA_FIXUP_PINS,
>> > @@ -3823,6 +3829,8 @@ static const struct hda_fixup alc269_fixups[] = {
>> >     [ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT] = {
>> >             .type = HDA_FIXUP_FUNC,
>> >             .v.func = alc269_fixup_pincfg_no_hp_to_lineout,
>> > +           .chained = true,
>> > +           .chain_id = ALC269_FIXUP_THINKPAD_ACPI,
>> >     },
>> >     [ALC269_FIXUP_DELL1_MIC_NO_PRESENCE] = {
>> >             .type = HDA_FIXUP_PINS,
>> > @@ -3970,8 +3978,6 @@ static const struct hda_fixup alc269_fixups[] = {
>> >     [ALC269_FIXUP_THINKPAD_ACPI] = {
>> >             .type = HDA_FIXUP_FUNC,
>> >             .v.func = alc_fixup_thinkpad_acpi,
>> > -           .chained = true,
>> > -           .chain_id = ALC269_FIXUP_LIMIT_INT_MIC_BOOST
>> >     },
>> >  };
>> >
>> > @@ -4057,7 +4063,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>> >     SND_PCI_QUIRK(0x17aa, 0x2208, "Thinkpad T431s", ALC269_FIXUP_LENOVO_DOCK),
>> >     SND_PCI_QUIRK(0x17aa, 0x220c, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>> >     SND_PCI_QUIRK(0x17aa, 0x2212, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>> > -   SND_PCI_QUIRK(0x17aa, 0x2214, "Thinkpad", ALC269_FIXUP_THINKPAD_ACPI),
>> > +   SND_PCI_QUIRK(0x17aa, 0x2214, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>> >     SND_PCI_QUIRK(0x17aa, 0x2215, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>> >     SND_PCI_QUIRK(0x17aa, 0x5013, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>> >     SND_PCI_QUIRK(0x17aa, 0x501a, "Thinkpad", ALC283_FIXUP_INT_MIC),
>> > @@ -4065,6 +4071,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>> >     SND_PCI_QUIRK(0x17aa, 0x5109, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>> >     SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
>> >     SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
>> > +   SND_PCI_QUIRK_VENDOR(0x17aa, "Lenovo", ALC269_FIXUP_THINKPAD_ACPI),
>> >     SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
>> >
>> >  #if 0
>> > --
>> > 1.7.9.5
>> >
>> > _______________________________________________
>> > Alsa-devel mailing list
>> > Alsa-devel@alsa-project.org
>> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>



-- 
Cheers,
Alex Hung
