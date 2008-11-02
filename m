From: "Michael Gruber" <lists.mg@googlemail.com>
Subject: Re: hda-intel - Add digout to ALC880 F1734 model
Date: Sun, 2 Nov 2008 17:02:51 +0100
Message-ID: <74d457500811020802j3354abeepebbe2cac1d799d76@mail.gmail.com>
References: <74d457500811010543x42103855n5f68136fd564b1bf@mail.gmail.com>
	<s5hwsfmid6f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D6E324340
	for <alsa-devel@alsa-project.org>; Sun,  2 Nov 2008 17:02:52 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so1987793rvb.32
	for <alsa-devel@alsa-project.org>; Sun, 02 Nov 2008 08:02:51 -0800 (PST)
In-Reply-To: <s5hwsfmid6f.wl%tiwai@suse.de>
Content-Disposition: inline
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

On Sun, Nov 2, 2008 at 12:23, Takashi Iwai <tiwai@suse.de> wrote:
> At Sat, 1 Nov 2008 13:43:25 +0100,
> Michael Gruber wrote:
>>
>> Backstory:
>> The patch "ALSA: hda - Add infrastructure for dynamic stream allocation"
>> http://git.alsa-project.org/?p=alsa-kmirror.git;a=commit;h=ae32c9fe811fed22715342494c08a11fabc87762
>> broke the detection of my card. With this patch applied the dmesg output is:
>>
>> [ 3761.464838] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level,
>> low) -> IRQ 16
>> [ 3761.464863] PCI: Setting latency timer of device 0000:00:1b.0 to 64
>> [ 3761.499927] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
>> [ 3761.499945] HDA Intel: probe of 0000:00:1b.0 failed with error -22
>
> Could you check whether you get any other error messages with
> CONFIG_SND_DEBUG=y?
>
>> When I loaded the module with model=... then it would work only for some
>> models, but not for others. I found out that the ones which worked were the
>> ones with a digout. I added the digout to the F1734 model and now it is
>> working again.
>>
>> I can't test if the digout is really working because I lack the hardware, but
>> when I turn on the IEC958 control in the mixer then red light is emitted from
>> my headphone port.
>>
>> I will attach a patch that adds digout to this model because this seems the
>> right thing to do, but I don't know whether there is something wrong with the
>> aforementioned patch that caused my problem in the first place.
>
> Yeah, it shouldn't break the existing thing, at least.
>
>
> thanks,
>
> Takashi
>

[  261.045920] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level,
low) -> IRQ 16
[  261.045945] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[  261.045949] ALSA
/home/*/Desktop/test-alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:2130:
chipset global capabilities = 0x4401
[  261.076055] ALSA
/home/*/Desktop/test-alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:771:
codec_mask = 0x3
[  261.079523] ALSA
/home/*/Desktop/test-alsa/alsa-driver/pci/hda/hda_codec.c:2579:
hda_codec: model 'F1734' is selected for config 1734:107c (FSC F1734)
[  261.079920] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[  261.079933] HDA Intel: probe of 0000:00:1b.0 failed with error -22

That is all.
