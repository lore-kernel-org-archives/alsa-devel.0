From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [BUG]ABit aa8xe sound card not selected
Date: Thu, 22 May 2014 10:30:31 +0800
Message-ID: <CAN8cciYkdkrSpCmo8D+eTfwhX36hYfA9XLOuGD3rxU9FHvyjXg@mail.gmail.com>
References: <DUB127-W341DC0DDBAE2B6BECE8FCE83360@phx.gbl>
 <CAN8cciY6O3tzsVMmyQF1Xq-8MRUK-XtUa0JjtjdVn7vjETxgZQ@mail.gmail.com>
 <BLU436-SMTP25820E06E9F4D27CD71A5AA833C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f180.google.com (mail-qc0-f180.google.com
 [209.85.216.180])
 by alsa0.perex.cz (Postfix) with ESMTP id AF40E26546B
 for <alsa-devel@alsa-project.org>; Thu, 22 May 2014 04:30:32 +0200 (CEST)
Received: by mail-qc0-f180.google.com with SMTP id i17so4749796qcy.11
 for <alsa-devel@alsa-project.org>; Wed, 21 May 2014 19:30:31 -0700 (PDT)
In-Reply-To: <BLU436-SMTP25820E06E9F4D27CD71A5AA833C0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefano Statuti <stefano.statuti@hotmail.it>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> i tried to force the install one of olds kernel like 3.12 but ubuntu
crash on start. removed the 3.12 i reinstall the 3.13 same identical
problem (no audio).
> tried to install the lastest development kernel but not solve my problem.
>
> For the detailed ALC880 config pins , I reveived this by Raimond on
ubuntu-launchpad (
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1319291 ) but I
dont know how to apply the fix that you have sayd me, sorry. Can you send
me a link for a guide that could help me?
>
> Maybe I have to modify the config file into
/sys/class/sound/hwC0D0/init_pin_configs folder ? tried with root but is
impossible to save.

http://voices.canonical.com/david.henningsson/2012/07/13/top-five-wrong-ways-to-fix-your-audio/

When your BIOS does not setup pin default for all pin comples

The only way you get your alc880 work is to edit
/etc/modprobe.d/alsa-base.conf and add the following line if your
motherboard have six audio jacks and digital out at rear panel

options snd-hda-intel model=6stack-digout

or

options snd-hda-intel model=6stack-automute

If your computer chassis have a hda front audio panel which support jack
detection

>> >
>> >
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/Documentation/sound/alsa/HD-Audio-Models.txt
>>
>> have you try the model=6stack-digout or 6stack-automute ?
>>
>>
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_realtek.c?id=67b6ec3196da235317ff1b9474f17379b78f3294
>>
>> ALC880_FIXUP_6ST_BASE] = {
>> + .type = ALC_FIXUP_PINS,
>> + .v.pins = (const struct alc_pincfg[]) {
>> + { 0x14, 0x01014010 }, /* front */
>> + { 0x15, 0x01016412 }, /* surr */
>> + { 0x16, 0x01011411 }, /* CLFE */
>> + { 0x17, 0x01012414 }, /* side */
>> + { 0x18, 0x01a19c30 }, /* mic-in */
>> + { 0x19, 0x02a19c40 }, /* front-mic */
>> + { 0x1a, 0x01813031 }, /* line-in */
>> + { 0x1b, 0x0121411f }, /* HP */
>>
>> HP in ALC880_FIXUP_6ST_BASE explicitly disable jack detection ,
>>
>> Do you need a new model which support headphone automute speaker with
digital output since 6stack-automute does not have digital ouput ?
>>
>>
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_realtek.c?id=5397145f4faeabbb7937ac784f734b06b20ed921
>>
>> >
>> > 00:1b.0 0403: 8086:2668 (rev 04)
>> >
>> >  Subsystem: 147b:1045
>> >
>> > send email to alsa-devel mailing list to add pci quirk since Bios does
not setup pin default
>> >  Default 0x00000000: [Jack] Line Out at Ext N/A
>> >
>> > Sysfs Files
>> >
>> > !!-----------
>> >
>> > /sys/class/sound/hwC0D0/init_pin_configs:
>> >
>> > 0x14 0x00000000
>> >
>> > 0x15 0x00000000
>> >
>> > 0x16 0x00000000
>> >
>> > 0x17 0x00000000
>> >
>> > 0x18 0x00000000
>> >
>> > 0x19 0x00000000
>> >
>> > 0x1a 0x00000000
>> >
>> > 0x1b 0x00000000
>> >
>> > 0x1c 0x00000000
>> >
>> > 0x1d 0x00000000
>> >
>> > 0x1e 0x00000000
>> >
>> > 0x1f 0x00000000
>> > -----
>> >
>>
>>
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/hda_auto_parser.c?id=9b7564a64999597844513604df4a206fa4da3b69
>>
>> Do you mean the driver still does not provide any warning message when
all your pins are ignored by the driver ?
>>
>
