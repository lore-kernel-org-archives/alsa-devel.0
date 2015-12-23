From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v2] sound: hda_intel: add card number to
	irq description
Date: Wed, 23 Dec 2015 08:57:27 +0100
Message-ID: <CAFSsGVuW8AXh-isYJUdVcczBeBwRNA-EZq266yEkkrakXR86Vw@mail.gmail.com>
References: <567991C1.3040507@gmail.com>
	<s5ha8p1wr24.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 5183D265815
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 08:57:28 +0100 (CET)
Received: by mail-wm0-f47.google.com with SMTP id p187so138097591wmp.0
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2015 23:57:28 -0800 (PST)
In-Reply-To: <s5ha8p1wr24.wl-tiwai@suse.de>
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

On Wed, Dec 23, 2015 at 8:40 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 22 Dec 2015 19:09:05 +0100,
> Heiner Kallweit wrote:
>>
>> Currently the info in /proc/interrupts doesn't allow to figure out which
>> interrupt belongs to which card (HDMI, PCH, ..).
>> Therefore add card details to the interrupt description.
>> With the patch the info in /proc/interrupts looks like this:
>>
>> PCI-MSI 442368-edge      snd_hda_intel:card1
>> PCI-MSI 49152-edge      snd_hda_intel:card0
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>> v2:
>> Make extension more generic and implement it in snd_card.
>> This way every driver using struct snd_card can easily be
>> switched to using the more descriptive irq describer.
>
> Thanks, the patch looks good to me, but I have a small hesitation to
> add such a new filed blindly to snd_card struct.   Although it's
> relatively small (32 bytes), it's not zero, after all.
>
> Maybe we'll take this approach in the end, I guess, but let's see
> whether this rings bell to others.
>
We could also allocate the irq describer dynamically with kasprintf
or devm_kasprintf and just add a pointer to snd_card struct.
This would save us a few bytes, question is whether it's worth it.
I'm open to any suggestion.

Heiner
>
> Takashi
>

>> ---
>>  include/sound/core.h      | 1 +
>>  sound/core/init.c         | 3 +++
>>  sound/pci/hda/hda_intel.c | 2 +-
>>  3 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/sound/core.h b/include/sound/core.h
>> index cdfecaf..31079ea 100644
>> --- a/include/sound/core.h
>> +++ b/include/sound/core.h
>> @@ -99,6 +99,7 @@ struct snd_card {
>>       char driver[16];                /* driver name */
>>       char shortname[32];             /* short name of this soundcard */
>>       char longname[80];              /* name of this soundcard */
>> +     char irq_descr[32];             /* Interrupt description */
>>       char mixername[80];             /* mixer name */
>>       char components[128];           /* card components delimited with
>>                                                               space */
>> diff --git a/sound/core/init.c b/sound/core/init.c
>> index 20f37fb..6bda843 100644
>> --- a/sound/core/init.c
>> +++ b/sound/core/init.c
>> @@ -268,6 +268,9 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
>>       if (err < 0)
>>               goto __error;
>>
>> +     snprintf(card->irq_descr, sizeof(card->irq_descr), "%s:%s",
>> +              dev_driver_string(card->dev), dev_name(&card->card_dev));
>> +
>>       /* the control interface cannot be accessed from the user space until */
>>       /* snd_cards_bitmask and snd_cards are set with snd_card_register */
>>       err = snd_ctl_create(card);
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 83800ac..c0bef11 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -725,7 +725,7 @@ static int azx_acquire_irq(struct azx *chip, int do_disconnect)
>>
>>       if (request_irq(chip->pci->irq, azx_interrupt,
>>                       chip->msi ? 0 : IRQF_SHARED,
>> -                     KBUILD_MODNAME, chip)) {
>> +                     chip->card->irq_descr, chip)) {
>>               dev_err(chip->card->dev,
>>                       "unable to grab IRQ %d, disabling device\n",
>>                       chip->pci->irq);
>> --
>> 2.6.4
>>
>>
>>
