From: Alex Murray <murray.alex@gmail.com>
Subject: Re: [PATCH - hda 1/1] ALSA: hda - Add PCI quirk for
	17" MacBook Pro 5, 2 model (July 2009) to use existing mb5 model
Date: Thu, 21 Jan 2010 23:07:20 +1030
Message-ID: <6e7aaa1d1001210437g5bad7982p28ad2c424bf0aed5@mail.gmail.com>
References: <4b583eaa.0d0bca0a.753e.37fc@mx.google.com>
	<s5h8wbracy1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f173.google.com (mail-px0-f173.google.com
	[209.85.216.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 15077243DC
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 13:37:36 +0100 (CET)
Received: by pxi3 with SMTP id 3so4281721pxi.16
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 04:37:35 -0800 (PST)
In-Reply-To: <s5h8wbracy1.wl%tiwai@suse.de>
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

Patch was supplied here:
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/337314/comments/=
148
so no I can't personally confirm it works...

I agree it definitely looks odd - especially compared to the existing
entries... okay I'll see if I can get some more info then and will
repost if I can defintiely confirm it.



2010/1/21 Takashi Iwai <tiwai@suse.de>:
> At Thu, 21 Jan 2010 22:16:26 +1030,
> murray.alex@gmail.com wrote:
>>
>> From: Alex Murray <murray.alex@gmail.com>
>>
>>
>> Signed-off-by: Alex Murray <murray.alex@gmail.com>
>> ---
>> =A0pci/hda/patch_realtek.c | =A0 =A01 +
>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/pci/hda/patch_realtek.c b/pci/hda/patch_realtek.c
>> index 7e0ea37..d044db9 100644
>> --- a/pci/hda/patch_realtek.c
>> +++ b/pci/hda/patch_realtek.c
>> @@ -9223,6 +9223,7 @@ static struct snd_pci_quirk alc882_ssid_cfg_tbl[] =
=3D {
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 SND_PCI_QUIRK(0x106b, 0x4000, "MacbookPro 5,1", ALC885_MB5),
>> =A0 =A0 =A0 SND_PCI_QUIRK(0x106b, 0x4600, "MacbookPro 5,2", ALC885_MB5),
>> + =A0 =A0 SND_PCI_QUIRK(0x10ec, 0x0885, "MacbookPro 5,2", ALC885_MB5),
>
> Thanks for the patch.
> But I wonder whether this entry is really correct. =A0The value looks
> like the codec vendor id. =A0There you need a PCI SSID.
> Did you confirm that your patch really works?
>
>
> Takashi
>
