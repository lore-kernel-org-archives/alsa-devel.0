From: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
Subject: [possible bug] DMI OEM string doesn't match (was Re:
	[PATCH] Recognise and use subdevice 0x3061 found in some HP
	dv6 notebooks.)
Date: Sat, 26 Dec 2009 00:09:17 +0530
Message-ID: <200912260009.17337.kunal.gangakhedkar@gmail.com>
References: <200912140029.42677.kunal.gangakhedkar@gmail.com>
	<200912230002.47741.kunal.gangakhedkar@gmail.com>
	<200912241307.12332.kunal.gangakhedkar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.211.195])
	by alsa0.perex.cz (Postfix) with ESMTP id B9AE92457C
	for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2009 19:39:25 +0100 (CET)
Received: by ywh33 with SMTP id 33so8996691ywh.23
	for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2009 10:39:24 -0800 (PST)
In-Reply-To: <200912241307.12332.kunal.gangakhedkar@gmail.com>
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

On Thursday 24 Dec 2009 1:07:12 pm Kunal Gangakhedkar wrote:
> On Wednesday 23 Dec 2009 12:02:47 am Kunal Gangakhedkar wrote:
> > 
> > Sorry for the late reply - was busy with office work.
> > Just built the kernel from your git (sound-2.6.git) master 
> > (as of commit 07e23a669544942a9154b64c583bdef014f66a15).
> > 
> > This new driver didn't require 'model=hp-dv5' modparm - it did detect and 
> > use my card properly; so, my patch is not needed anymore, I guess :)
> > 
> > However, the hp_detect=1 problem still persists :(.
> > I had to use the "echo 'hp_detect=1' > /sys/class/sound/hwC0D0/hints" 
> > method to get the auto-muting to work. 
> > It's also true with enable_msi=1 modparm.
> > 
> > Anything more you want me to try?
> > 
> > Thanks,
> > Kunal
> > 
> 
> Also, "spec->gpio_led = 0x08" in patch_sigmatel.c seems to enable the 
> colour changing (orange/white) of the mute/unmute button.
> I got this info from ubuntu's lucid kernel which somehow 
> enabled the behaviour.
> But, it was missing from the sound-2.6.git master kernel that I built. 
> I'll do more digging to see why it isn't working in the git kernel.
> 
> This is the code that I copied from lucid kernel into linux-backports-modules 
> that enabled the led behaviour:
> 
> 	if ((codec->subsystem_id >> 16) == PCI_VENDOR_ID_HP) {
> 		const struct dmi_device *dev = NULL;
> 		while ((dev = dmi_find_device(DMI_DEV_TYPE_OEM_STRING,
> 					      NULL, dev))) {
> 			if (strcmp(dev->name, "HP_Mute_LED_1")) {
> 				switch (codec->vendor_id) {
> 				case 0x111d7608:
> 					spec->gpio_led = 0x01;
> 					break;
> 				case 0x111d7600:
> 				case 0x111d7601:
> 				case 0x111d7602:
> 				case 0x111d7603: /* <-- My codec STAC 92HD75B3X5 */
> 					spec->gpio_led = 0x08;
> 					break;
> 				}
> 				break;
> 			}
> 		}
> 	}
> 
> Thanks, 
> Kunal
> 

I did a bit of digging around - and the patch_sigmatel.c from sound-2.6.git 
seems to have problem in the find_mute_led_gpio() function.
My laptop doesn't seem to have the "HP_Mute_LED_*" OEM string 
in the DMI table.

The DMI table as dumped by "dmidecode --dump":
# dmidecode 2.9
SMBIOS 2.4 present.
20 structures occupying 1001 bytes.
Table at 0x000EB340.

Handle 0x0000, DMI type 0, 24 bytes
	Header and Data:
		00 18 00 00 01 02 00 00 03 0F 90 DA 01 3C 00 00
		14 00 87 05 0F 17 19 17
	Strings:
		48 65 77 6C 65 74 74 2D 50 61 63 6B 61 72 64 00
		"Hewlett-Packard"
		46 2E 31 37 00
		"F.17"
		30 38 2F 31 38 2F 32 30 30 39 00
		"08/18/2009"

Handle 0x0001, DMI type 1, 27 bytes
	Header and Data:
		01 1B 01 00 01 02 03 04 43 4E 46 39 31 37 30 53
		4B 38 00 23 8B B4 43 C7 06 05 06
	Strings:
		48 65 77 6C 65 74 74 2D 50 61 63 6B 61 72 64 00
		"Hewlett-Packard"
		48 50 20 50 61 76 69 6C 69 6F 6E 20 64 76 36 20
		4E 6F 74 65 62 6F 6F 6B 20 50 43 00
		"HP Pavilion dv6 Notebook PC"
		52 65 76 20 31 00
		"Rev 1"
		43 4E 46 39 31 37 30 53 4B 38 00
		"CNF9170SK8"
		56 42 36 32 34 50 41 23 41 43 4A 00
		"VB624PA#ACJ"
		31 30 33 43 5F 35 33 33 35 4B 56 00
		"103C_5335KV"

Handle 0x0002, DMI type 2, 16 bytes
	Header and Data:
		02 10 02 00 01 02 03 04 05 09 06 03 00 0A 00 00
	Strings:
		51 75 61 6E 74 61 00
		"Quanta"
		33 30 36 31 00
		"3061"
		31 39 2E 31 37 00
		"19.17"
		4E 6F 6E 65 00
		"None"
		42 61 73 65 20 42 6F 61 72 64 20 41 73 73 65 74
		20 54 61 67 00
		"Base Board Asset Tag"
		42 61 73 65 20 42 6F 61 72 64 20 43 68 61 73 73
		69 73 20 4C 6F 63 61 74 69 6F 6E 00
		"Base Board Chassis Location"

Handle 0x0003, DMI type 3, 22 bytes
	Header and Data:
		03 16 03 00 01 0A 02 03 04 03 03 03 03 12 01 00
		00 00 01 00 00 00
	Strings:
		51 75 61 6E 74 61 00
		"Quanta"
		4E 2F 41 00
		"N/A"
		4E 6F 6E 65 00
		"None"
		20 00
		" "

Handle 0x0004, DMI type 9, 13 bytes
	Header and Data:
		09 0D 04 00 01 A5 08 03 04 01 00 06 03
	Strings:
		50 43 49 20 45 78 70 72 65 73 73 20 53 6C 6F 74
		20 31 00
		"PCI Express Slot 1"

Handle 0x0005, DMI type 9, 13 bytes
	Header and Data:
		09 0D 05 00 01 A5 08 03 04 02 00 06 00
	Strings:
		50 43 49 20 45 78 70 72 65 73 73 20 53 6C 6F 74
		20 32 00
		"PCI Express Slot 2"

Handle 0x0006, DMI type 9, 13 bytes
	Header and Data:
		09 0D 06 00 01 A5 08 03 04 03 00 06 01
	Strings:
		50 43 49 20 45 78 70 72 65 73 73 20 53 6C 6F 74
		20 33 00
		"PCI Express Slot 3"

Handle 0x0007, DMI type 10, 6 bytes
	Header and Data:
		0A 06 07 00 83 01
	Strings:
		30 00
		"0"

Handle 0x0008, DMI type 11, 5 bytes
	Header and Data:
		0B 05 08 00 04
	Strings:
		24 48 50 24 00
		"$HP$"
		4C 4F 43 23 41 43 4A 00
		"LOC#ACJ"
		41 42 53 20 37 30 2F 37 31 20 37 39 20 37 41 20
		37 42 20 37 43 00
		"ABS 70/71 79 7A 7B 7C"
		43 4E 42 31 20 30 31 31 30 30 30 30 30 31 34 31
		32 31 30 30 30 30 00
		"CNB1 01100000141210000"

Handle 0x0009, DMI type 32, 20 bytes
	Header and Data:
		20 14 09 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00

Handle 0x000A, DMI type 4, 35 bytes
	Header and Data:
		04 23 0A 00 03 03 E9 02 31 0F 20 00 FF FB 8B 17
		01 8E 08 07 98 08 98 08 41 01 0B 00 0C 00 FF FF
		05 04 06
	Strings:
		41 4D 44 20 54 75 72 69 6F 6E 28 74 6D 29 20 58
		32 20 44 75 61 6C 2D 43 6F 72 65 20 4D 6F 62 69
		6C 65 20 52 4D 2D 37 34 00
		"AMD Turion(tm) X2 Dual-Core Mobile RM-74"
		41 4D 44 20 70 72 6F 63 65 73 73 6F 72 00
		"AMD processor"
		53 6F 63 6B 65 74 20 4D 32 2F 53 31 47 31 00
		"Socket M2/S1G1"
		46 46 46 46 00
		"FFFF"
		4E 6F 74 53 75 70 70 6F 72 74 00
		"NotSupport"
		46 46 46 46 00
		"FFFF"

Handle 0x000B, DMI type 7, 19 bytes
	Header and Data:
		07 13 0B 00 01 80 01 00 01 00 01 20 00 20 00 00
		05 05 04
	Strings:
		4C 31 20 43 61 63 68 65 00
		"L1 Cache"

Handle 0x000C, DMI type 7, 19 bytes
	Header and Data:
		07 13 0C 00 01 81 01 10 80 10 80 20 00 20 00 00
		05 05 08
	Strings:
		4C 32 20 43 61 63 68 65 00
		"L2 Cache"

Handle 0x000D, DMI type 16, 15 bytes
	Header and Data:
		10 0F 0D 00 03 03 03 00 00 80 00 FE FF 02 00

Handle 0x000E, DMI type 17, 27 bytes
	Header and Data:
		11 1B 0E 00 0D 00 FE FF 40 00 40 00 00 08 0D 00
		01 02 13 80 00 20 03 03 04 05 06
	Strings:
		53 4F 44 49 4D 4D 20 30 00
		"SODIMM 0"
		42 61 6E 6B 20 30 30 00
		"Bank 00"
		30 30 30 30 30 30 30 30 30 30 30 30 30 30 43 45
		00
		"00000000000000CE"
		43 45 30 30 30 30 30 30 30 30 30 30 30 30 30 30
		30 32 30 39 31 35 38 32 42 34 41 37 46 44 00
		"CE0000000000000002091582B4A7FD"
		55 6E 6B 6E 6F 77 6E 00
		"Unknown"
		4D 34 20 37 30 54 35 36 36 33 45 48 33 2D 43 46
		37 20 00
		"M4 70T5663EH3-CF7 "

Handle 0x000F, DMI type 20, 19 bytes
	Header and Data:
		14 13 0F 00 00 00 00 00 FF FF 1F 00 0E 00 12 00
		01 00 00

Handle 0x0010, DMI type 17, 27 bytes
	Header and Data:
		11 1B 10 00 0D 00 FE FF 40 00 40 00 00 08 0D 00
		01 02 13 80 00 20 03 03 04 05 06
	Strings:
		53 4F 44 49 4D 4D 20 31 00
		"SODIMM 1"
		42 61 6E 6B 20 30 38 00
		"Bank 08"
		30 30 30 30 30 30 30 30 30 30 30 30 30 30 43 45
		00
		"00000000000000CE"
		43 45 30 30 30 30 30 30 30 30 30 30 30 30 30 30
		30 32 30 39 31 35 38 32 42 34 41 37 34 36 00
		"CE0000000000000002091582B4A746"
		55 6E 6B 6E 6F 77 6E 00
		"Unknown"
		4D 34 20 37 30 54 35 36 36 33 45 48 33 2D 43 46
		37 20 00
		"M4 70T5663EH3-CF7 "

Handle 0x0011, DMI type 20, 19 bytes
	Header and Data:
		14 13 11 00 00 00 20 00 FF FF 3F 00 10 00 12 00
		01 00 00

Handle 0x0012, DMI type 19, 15 bytes
	Header and Data:
		13 0F 12 00 00 00 00 00 FF FF 3F 00 0D 00 02

Handle 0x0013, DMI type 127, 4 bytes
	Header and Data:
		7F 04 13 00


As per the man page of dmidecode, type 11 is for OEM strings.
So, the concerned part of the output is:

Handle 0x0008, DMI type 11, 5 bytes
	Header and Data:
		0B 05 08 00 04
	Strings:
		24 48 50 24 00
		"$HP$"
		4C 4F 43 23 41 43 4A 00
		"LOC#ACJ"
		41 42 53 20 37 30 2F 37 31 20 37 39 20 37 41 20
		37 42 20 37 43 00
		"ABS 70/71 79 7A 7B 7C"
		43 4E 42 31 20 30 31 31 30 30 30 30 30 31 34 31
		32 31 30 30 30 30 00
		"CNB1 01100000141210000"

So, as you can see, the sscanf()'s from the find_mute_led_gpio() will never work.

Logged a bug on kernel bugzilla:
http://bugzilla.kernel.org/show_bug.cgi?id=14878

BTW, the version in 2.6.32 is also faulty.
This line: 
http://lxr.linux.no/#linux+v2.6.32/sound/pci/hda/patch_sigmatel.c#L5482

will actually work *only* when the string *doesn't* match - which is why it worked 
in my case since I don't have the 'HP_Mute_LED*' string(s). The return value of strcmp()
is 0 when strings match - non-zero otherwise. So, this if() block will only work when
the strings don't match.

Thanks, 
Kunal
