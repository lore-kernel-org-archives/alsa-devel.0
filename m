From: Huacai Chen <chenhuacai@gmail.com>
Subject: Re: [PATCH V2 13/16] ALSA: HDA: Make hda sound card
 usable for Loongson.
Date: Tue, 19 Jun 2012 18:47:42 +0800
Message-ID: <CAAhV-H4ALZMW21=6DfGms2wjfuBzKLHrpgV28he8PG77YWbqYA@mail.gmail.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
	<1340088624-25550-14-git-send-email-chenhc@lemote.com>
	<s5hd34vlkin.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
	[209.85.217.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D162103F39
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2012 12:47:43 +0200 (CEST)
Received: by lban1 with SMTP id n1so5166782lba.38
	for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2012 03:47:42 -0700 (PDT)
In-Reply-To: <s5hd34vlkin.wl%tiwai@suse.de>
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
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Zhangjin Wu <wuzhangjin@gmail.com>, Hua Yan <yanh@lemote.com>, Ralf Baechle <ralf@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>, Huacai Chen <chenhc@lemote.com>, Hongliang Tao <taohl@lemote.com>
List-Id: alsa-devel@alsa-project.org

Thanks, I'll improve the patch.

On Tue, Jun 19, 2012 at 5:26 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 19 Jun 2012 14:50:21 +0800,
> Huacai Chen wrote:
>>
>> Lemote A1004(Laptop) and A1205(All-In-One) use Conexant's hda codec,
>> this patch make it usable:
>> 1, Use 32-bit DMA as a workaround (Loongson has a hardware bug that it
>> =A0 =A0doesn't support DMA address above 4GB).
>> 2, Modify patch_conexant.c to add Lemote specific code.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> Signed-off-by: Hongliang Tao <taohl@lemote.com>
>> Signed-off-by: Hua Yan <yanh@lemote.com>
>> Cc: alsa-devel@alsa-project.org
>> ---
>> =A0include/linux/pci_ids.h =A0 =A0 =A0 =A0| =A0 =A02 +
>> =A0sound/pci/hda/hda_intel.c =A0 =A0 =A0| =A0 =A05 ++++
>> =A0sound/pci/hda/patch_conexant.c | =A0 52 +++++++++++++++++++++++++++++=
+++++++++-
>> =A03 files changed, 57 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index ab741b0..d8b0a52 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2906,3 +2906,5 @@
>> =A0#define PCI_DEVICE_ID_XEN_PLATFORM =A0 0x0001
>>
>> =A0#define PCI_VENDOR_ID_OCZ =A0 =A0 =A0 =A0 =A0 =A00x1b85
>> +
>> +#define PCI_VENDOR_ID_LEMOTE =A0 =A0 =A0 =A0 0x1c06
>
> As Clemens already suggested, please split your patch. =A0The addition
> of PCI ID, addition of the workaround in HD-audio controller code, and
> the modification to Conexant codec code are all different things.
>
>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 2b6392b..2b73ed4 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -3013,6 +3013,11 @@ static int DELAYED_INIT_MARK azx_first_init(struc=
t azx *chip)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 gcap &=3D ~ICH6_GCAP_64OK;
>> =A0 =A0 =A0 }
>>
>> +#ifdef CONFIG_CPU_LOONGSON3
>> + =A0 =A0 /* Workaround: Loongson 3 doesn't support 64-bit DMA */
>> + =A0 =A0 gcap &=3D ~ICH6_GCAP_64OK;
>> +#endif
>
> Where is CONFIG_CPU_LOONGSON3 defined at all?
> This isn't found in the upstream Linus or linux-next tree.
>
>
>> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexa=
nt.c
>> index 3acb582..1c8dfb9 100644
>> --- a/sound/pci/hda/patch_conexant.c
>> +++ b/sound/pci/hda/patch_conexant.c
>> @@ -142,6 +142,7 @@ struct conexant_spec {
>> =A0 =A0 =A0 unsigned int thinkpad:1;
>> =A0 =A0 =A0 unsigned int hp_laptop:1;
>> =A0 =A0 =A0 unsigned int asus:1;
>> + =A0 =A0 unsigned int lemote:1;
>
> In general, we don't accept such a static quirk any longer unless a
> special reason is given. =A0Doesn't the auto-parser work for you?
>
>
> thanks,
>
> Takashi
