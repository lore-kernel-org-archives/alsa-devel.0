From: Wang Xingchao <wangxingchao2011@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Add DeviceID for Haswell HDA
Date: Wed, 13 Jun 2012 16:05:12 +0800
Message-ID: <CA+v+29gXpHoQSfq59jjXgOw-w5gvCJ9kRd13HOosDVcAqCb_7w@mail.gmail.com>
References: <1339554232-3410-1-git-send-email-xingchao.wang@intel.com>
	<s5hr4tjwvxz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EF98D24441
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2012 10:05:33 +0200 (CEST)
Received: by obbup19 with SMTP id up19so481019obb.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Jun 2012 01:05:32 -0700 (PDT)
In-Reply-To: <s5hr4tjwvxz.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, fengguang.wu@intel.com, Seth Heasley <seth.heasley@intel.com>, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

2012/6/13 Takashi Iwai <tiwai@suse.de>:
> At Wed, 13 Jun 2012 10:23:51 +0800,
> Wang Xingchao wrote:
>>
>> this patch add proper id for Haswell HDA Controller.
>>
>> Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
>
> Oh, now ID number decreases to 0xxx? :)

Id 0c0c is readout from "lspci" like below:
[amanda@amanda-fedora-16 ~]$ lspci

00:03.0 Audio device: Intel Corporation Device 0c0c (rev 01)

00:1b.0 Audio device: Intel Corporation Device 8c20 (rev 01)

>
> While we are on this: could you verify whether position_fix=3D4 (combo)
> options works for Haswell? =A0In this mode, LPIB is used for playback
> positioning while POS buffer is used for capture.
>
> Seth (Cc'ed) figured out that this mode works better than the default
> (usually POS buf both for playback and capture) on the recent Intel
> controller chips, so I guess it'd be applied to Haswell, too.
>

I'm afraid no better result to provide now. This patch is to fix codec
probe error at initialization. you can get details at this bug page:
Bug 829405 - [Intel 6.4 Bug] Shark Bay: sound related warnings/errors in dm=
esg
https://bugzilla.redhat.com/show_bug.cgi?id=3D829405

The other patch about HDMI device id could get correct device list by
"aplay -l", but there's still some problem to detect HDMI monitor, so
i cannot test audio on Haswell HDA now. But once the HDMI monitor
detection works, i will provide the test result of Seth's patch.

I think if someone has Haswell HDA plus normal ALC* codec, it could
help much to test the patch easily.

So Takashi you could reject this patch until i send out the updated
one with test result then.

thanks
--xingchao
>
> thanks,
>
> Takashi
>
>> ---
>> =A0sound/pci/hda/hda_intel.c | =A0 =A05 +++++
>> =A01 file changed, 5 insertions(+)
>>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 2b6392b..f530c40 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -151,6 +151,7 @@ MODULE_SUPPORTED_DEVICE("{{Intel, ICH6},"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"{Intel, CPT},"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"{Intel, PPT},"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"{Intel, LPT},"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"{Intel, HPT},"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"{Intel, PBG},"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"{Intel, SCH},"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"{ATI, SB450},"
>> @@ -3253,6 +3254,10 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) =3D {
>> =A0 =A0 =A0 { PCI_DEVICE(0x8086, 0x8c20),
>> =A0 =A0 =A0 =A0 .driver_data =3D AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
>> =A0 =A0 =A0 =A0 AZX_DCAPS_BUFSIZE},
>> + =A0 =A0 /* Haswell */
>> + =A0 =A0 { PCI_DEVICE(0x8086, 0x0c0c),
>> + =A0 =A0 =A0 .driver_data =3D AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
>> + =A0 =A0 =A0 AZX_DCAPS_BUFSIZE},
>> =A0 =A0 =A0 /* SCH */
>> =A0 =A0 =A0 { PCI_DEVICE(0x8086, 0x811b),
>> =A0 =A0 =A0 =A0 .driver_data =3D AZX_DRIVER_SCH | AZX_DCAPS_SCH_SNOOP |
>> --
>> 1.7.9.5
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
