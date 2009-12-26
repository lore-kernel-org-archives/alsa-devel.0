From: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
Subject: Re: [possible bug] DMI OEM string doesn't match (was
	Re: [PATCH] Recognise and use subdevice 0x3061 found in some
	HP dv6 notebooks.)
Date: Sat, 26 Dec 2009 13:19:23 +0530
Message-ID: <b363f0020912252349y77f73192l74b1b856c3de9b39@mail.gmail.com>
References: <200912140029.42677.kunal.gangakhedkar@gmail.com>
	<200912230002.47741.kunal.gangakhedkar@gmail.com>
	<200912241307.12332.kunal.gangakhedkar@gmail.com>
	<200912260009.17337.kunal.gangakhedkar@gmail.com>
	<s5hhbre7nem.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E9C381037FF
	for <alsa-devel@alsa-project.org>; Sat, 26 Dec 2009 08:49:24 +0100 (CET)
Received: by pwi18 with SMTP id 18so22183663pwi.32
	for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2009 23:49:23 -0800 (PST)
In-Reply-To: <s5hhbre7nem.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, goldwynr@gmail.com
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 26, 2009 at 2:59 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Sat, 26 Dec 2009 00:09:17 +0530,
> Kunal Gangakhedkar wrote:
>>
>> On Thursday 24 Dec 2009 1:07:12 pm Kunal Gangakhedkar wrote:
>> > On Wednesday 23 Dec 2009 12:02:47 am Kunal Gangakhedkar wrote:
>> > >
>> > > Sorry for the late reply - was busy with office work.
>> > > Just built the kernel from your git (sound-2.6.git) master
>> > > (as of commit 07e23a669544942a9154b64c583bdef014f66a15).
>> > >
>> > > This new driver didn't require 'model=3Dhp-dv5' modparm - it did det=
ect and
>> > > use my card properly; so, my patch is not needed anymore, I guess :)
>> > >
>> > > However, the hp_detect=3D1 problem still persists :(.
>> > > I had to use the "echo 'hp_detect=3D1' > /sys/class/sound/hwC0D0/hin=
ts"
>> > > method to get the auto-muting to work.
>> > > It's also true with enable_msi=3D1 modparm.
>> > >
>> > > Anything more you want me to try?
>> > >
>> > > Thanks,
>> > > Kunal
>> > >
>> >
>> > Also, "spec->gpio_led =3D 0x08" in patch_sigmatel.c seems to enable the
>> > colour changing (orange/white) of the mute/unmute button.
>> > I got this info from ubuntu's lucid kernel which somehow
>> > enabled the behaviour.
>> > But, it was missing from the sound-2.6.git master kernel that I built.
>> > I'll do more digging to see why it isn't working in the git kernel.
>> >
>> > This is the code that I copied from lucid kernel into linux-backports-=
modules
>> > that enabled the led behaviour:
>> >
>> > =A0 =A0 if ((codec->subsystem_id >> 16) =3D=3D PCI_VENDOR_ID_HP) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 const struct dmi_device *dev =3D NULL;
>> > =A0 =A0 =A0 =A0 =A0 =A0 while ((dev =3D dmi_find_device(DMI_DEV_TYPE_O=
EM_STRING,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 NULL, dev))) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (strcmp(dev->name, "HP_Mute=
_LED_1")) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (codec-=
>vendor_id) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0x111d760=
8:
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 spec->gpio_led =3D 0x01;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 break;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0x111d760=
0:
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0x111d760=
1:
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0x111d760=
2:
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0x111d760=
3: /* <-- My codec STAC 92HD75B3X5 */
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 spec->gpio_led =3D 0x08;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 break;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > =A0 =A0 =A0 =A0 =A0 =A0 }
>> > =A0 =A0 }
>> >
>> > Thanks,
>> > Kunal
>> >
>>
>> I did a bit of digging around - and the patch_sigmatel.c from sound-2.6.=
git
>> seems to have problem in the find_mute_led_gpio() function.
>> My laptop doesn't seem to have the "HP_Mute_LED_*" OEM string
>> in the DMI table.
>>
>> The DMI table as dumped by "dmidecode --dump":
>> # dmidecode 2.9
>> SMBIOS 2.4 present.
>> 20 structures occupying 1001 bytes.
>> Table at 0x000EB340.
>>
>> Handle 0x0000, DMI type 0, 24 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 00 18 00 00 01 02 00 00 03 0F 90 DA 01 3C 00=
 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 14 00 87 05 0F 17 19 17
>> =A0 =A0 =A0 Strings:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 48 65 77 6C 65 74 74 2D 50 61 63 6B 61 72 64=
 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Hewlett-Packard"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 46 2E 31 37 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "F.17"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 30 38 2F 31 38 2F 32 30 30 39 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "08/18/2009"
>>
>> Handle 0x0001, DMI type 1, 27 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 01 1B 01 00 01 02 03 04 43 4E 46 39 31 37 30=
 53
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 4B 38 00 23 8B B4 43 C7 06 05 06
>> =A0 =A0 =A0 Strings:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 48 65 77 6C 65 74 74 2D 50 61 63 6B 61 72 64=
 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Hewlett-Packard"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 48 50 20 50 61 76 69 6C 69 6F 6E 20 64 76 36=
 20
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 4E 6F 74 65 62 6F 6F 6B 20 50 43 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "HP Pavilion dv6 Notebook PC"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 52 65 76 20 31 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Rev 1"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 43 4E 46 39 31 37 30 53 4B 38 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "CNF9170SK8"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 56 42 36 32 34 50 41 23 41 43 4A 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "VB624PA#ACJ"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 31 30 33 43 5F 35 33 33 35 4B 56 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "103C_5335KV"
>>
>> Handle 0x0002, DMI type 2, 16 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 02 10 02 00 01 02 03 04 05 09 06 03 00 0A 00=
 00
>> =A0 =A0 =A0 Strings:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 51 75 61 6E 74 61 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Quanta"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 33 30 36 31 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "3061"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 31 39 2E 31 37 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "19.17"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 4E 6F 6E 65 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "None"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 42 61 73 65 20 42 6F 61 72 64 20 41 73 73 65=
 74
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 20 54 61 67 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Base Board Asset Tag"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 42 61 73 65 20 42 6F 61 72 64 20 43 68 61 73=
 73
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 69 73 20 4C 6F 63 61 74 69 6F 6E 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Base Board Chassis Location"
>>
>> Handle 0x0003, DMI type 3, 22 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 03 16 03 00 01 0A 02 03 04 03 03 03 03 12 01=
 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 00 00 01 00 00 00
>> =A0 =A0 =A0 Strings:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 51 75 61 6E 74 61 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Quanta"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 4E 2F 41 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "N/A"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 4E 6F 6E 65 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "None"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 20 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 " "
>>
>> Handle 0x0004, DMI type 9, 13 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 09 0D 04 00 01 A5 08 03 04 01 00 06 03
>> =A0 =A0 =A0 Strings:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 50 43 49 20 45 78 70 72 65 73 73 20 53 6C 6F=
 74
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 20 31 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "PCI Express Slot 1"
>>
>> Handle 0x0005, DMI type 9, 13 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 09 0D 05 00 01 A5 08 03 04 02 00 06 00
>> =A0 =A0 =A0 Strings:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 50 43 49 20 45 78 70 72 65 73 73 20 53 6C 6F=
 74
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 20 32 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "PCI Express Slot 2"
>>
>> Handle 0x0006, DMI type 9, 13 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 09 0D 06 00 01 A5 08 03 04 03 00 06 01
>> =A0 =A0 =A0 Strings:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 50 43 49 20 45 78 70 72 65 73 73 20 53 6C 6F=
 74
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 20 33 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "PCI Express Slot 3"
>>
>> Handle 0x0007, DMI type 10, 6 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 0A 06 07 00 83 01
>> =A0 =A0 =A0 Strings:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 30 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "0"
>>
>> Handle 0x0008, DMI type 11, 5 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 0B 05 08 00 04
>> =A0 =A0 =A0 Strings:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 24 48 50 24 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "$HP$"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 4C 4F 43 23 41 43 4A 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "LOC#ACJ"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 41 42 53 20 37 30 2F 37 31 20 37 39 20 37 41=
 20
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 37 42 20 37 43 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ABS 70/71 79 7A 7B 7C"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 43 4E 42 31 20 30 31 31 30 30 30 30 30 31 34=
 31
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 32 31 30 30 30 30 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "CNB1 01100000141210000"
>>
>> Handle 0x0009, DMI type 32, 20 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 20 14 09 00 00 00 00 00 00 00 00 00 00 00 00=
 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 00 00 00 00
>>
>> Handle 0x000A, DMI type 4, 35 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 04 23 0A 00 03 03 E9 02 31 0F 20 00 FF FB 8B=
 17
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 01 8E 08 07 98 08 98 08 41 01 0B 00 0C 00 FF=
 FF
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 05 04 06
>> =A0 =A0 =A0 Strings:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 41 4D 44 20 54 75 72 69 6F 6E 28 74 6D 29 20=
 58
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 32 20 44 75 61 6C 2D 43 6F 72 65 20 4D 6F 62=
 69
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 6C 65 20 52 4D 2D 37 34 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "AMD Turion(tm) X2 Dual-Core Mobile RM-74"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 41 4D 44 20 70 72 6F 63 65 73 73 6F 72 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "AMD processor"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 53 6F 63 6B 65 74 20 4D 32 2F 53 31 47 31 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Socket M2/S1G1"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 46 46 46 46 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "FFFF"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 4E 6F 74 53 75 70 70 6F 72 74 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "NotSupport"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 46 46 46 46 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "FFFF"
>>
>> Handle 0x000B, DMI type 7, 19 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 07 13 0B 00 01 80 01 00 01 00 01 20 00 20 00=
 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 05 05 04
>> =A0 =A0 =A0 Strings:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 4C 31 20 43 61 63 68 65 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "L1 Cache"
>>
>> Handle 0x000C, DMI type 7, 19 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 07 13 0C 00 01 81 01 10 80 10 80 20 00 20 00=
 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 05 05 08
>> =A0 =A0 =A0 Strings:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 4C 32 20 43 61 63 68 65 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "L2 Cache"
>>
>> Handle 0x000D, DMI type 16, 15 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 10 0F 0D 00 03 03 03 00 00 80 00 FE FF 02 00
>>
>> Handle 0x000E, DMI type 17, 27 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 11 1B 0E 00 0D 00 FE FF 40 00 40 00 00 08 0D=
 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 01 02 13 80 00 20 03 03 04 05 06
>> =A0 =A0 =A0 Strings:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 53 4F 44 49 4D 4D 20 30 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "SODIMM 0"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 42 61 6E 6B 20 30 30 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Bank 00"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 30 30 30 30 30 30 30 30 30 30 30 30 30 30 43=
 45
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "00000000000000CE"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 43 45 30 30 30 30 30 30 30 30 30 30 30 30 30=
 30
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 30 32 30 39 31 35 38 32 42 34 41 37 46 44 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "CE0000000000000002091582B4A7FD"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 55 6E 6B 6E 6F 77 6E 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Unknown"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 4D 34 20 37 30 54 35 36 36 33 45 48 33 2D 43=
 46
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 37 20 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "M4 70T5663EH3-CF7 "
>>
>> Handle 0x000F, DMI type 20, 19 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 14 13 0F 00 00 00 00 00 FF FF 1F 00 0E 00 12=
 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 01 00 00
>>
>> Handle 0x0010, DMI type 17, 27 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 11 1B 10 00 0D 00 FE FF 40 00 40 00 00 08 0D=
 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 01 02 13 80 00 20 03 03 04 05 06
>> =A0 =A0 =A0 Strings:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 53 4F 44 49 4D 4D 20 31 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "SODIMM 1"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 42 61 6E 6B 20 30 38 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Bank 08"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 30 30 30 30 30 30 30 30 30 30 30 30 30 30 43=
 45
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "00000000000000CE"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 43 45 30 30 30 30 30 30 30 30 30 30 30 30 30=
 30
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 30 32 30 39 31 35 38 32 42 34 41 37 34 36 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "CE0000000000000002091582B4A746"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 55 6E 6B 6E 6F 77 6E 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Unknown"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 4D 34 20 37 30 54 35 36 36 33 45 48 33 2D 43=
 46
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 37 20 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "M4 70T5663EH3-CF7 "
>>
>> Handle 0x0011, DMI type 20, 19 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 14 13 11 00 00 00 20 00 FF FF 3F 00 10 00 12=
 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 01 00 00
>>
>> Handle 0x0012, DMI type 19, 15 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 13 0F 12 00 00 00 00 00 FF FF 3F 00 0D 00 02
>>
>> Handle 0x0013, DMI type 127, 4 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 7F 04 13 00
>>
>>
>> As per the man page of dmidecode, type 11 is for OEM strings.
>> So, the concerned part of the output is:
>>
>> Handle 0x0008, DMI type 11, 5 bytes
>> =A0 =A0 =A0 Header and Data:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 0B 05 08 00 04
>> =A0 =A0 =A0 Strings:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 24 48 50 24 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "$HP$"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 4C 4F 43 23 41 43 4A 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "LOC#ACJ"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 41 42 53 20 37 30 2F 37 31 20 37 39 20 37 41=
 20
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 37 42 20 37 43 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ABS 70/71 79 7A 7B 7C"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 43 4E 42 31 20 30 31 31 30 30 30 30 30 31 34=
 31
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 32 31 30 30 30 30 00
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "CNB1 01100000141210000"
>>
>> So, as you can see, the sscanf()'s from the find_mute_led_gpio() will ne=
ver work.
>>
>> Logged a bug on kernel bugzilla:
>> http://bugzilla.kernel.org/show_bug.cgi?id=3D14878
>>
>> BTW, the version in 2.6.32 is also faulty.
>> This line:
>> http://lxr.linux.no/#linux+v2.6.32/sound/pci/hda/patch_sigmatel.c#L5482
>>
>> will actually work *only* when the string *doesn't* match - which is why=
 it worked
>> in my case since I don't have the 'HP_Mute_LED*' string(s). The return v=
alue of strcmp()
>> is 0 when strings match - non-zero otherwise. So, this if() block will o=
nly work when
>> the strings don't match.
>
> Maybe it depends on the BIOS version.
> The latest one (or possible the upcoming one) should have these DMI
> entries.
>

I have the latest bios version installed - F.17 - as can be seen from
the DMI type 0 output.

Here is the link to all the bioses available for my system:
http://h10025.www1.hp.com/ewfrf/wc/previousVersions?softwareitem=3Dob-74591=
-1&lc=3Den&dlc=3Den&cc=3Din&lang=3Den&os=3D2093&product=3D3962763

How can it be guaranteed that the new BIOS WILL have these strings?

As noted in the bug report on kernel bugzilla, even my cousin's laptop
(Pavilion dv9500t CTO) shows similar dmi strings. That is an old model
(>1yr old).

Does that mean that you don't plan to support older models? Because
this code surely doesn't work on the older models as I have reported.

Moreover, it's not always possible to update the bios since the tools
are available only on windows.
Also, what about asking the average Joe to update the bios?
I don't think he'd even understand what a bios is - chances of him
blowing it up are pretty high.

Kunal

>
> Takashi
>
