From: Vincent Lejeune <vljn@ovi.com>
Subject: Re: ASUS Phoebus (CMI8888) HDA Support
Date: Mon, 4 Aug 2014 11:30:31 -0700
Message-ID: <1407177031.13342.YahooMailNeo@web161506.mail.bf1.yahoo.com>
References: <1407099944.1470.YahooMailNeo@web161503.mail.bf1.yahoo.com>
 <s5h1tswwl3e.wl%tiwai@suse.de>
Reply-To: Vincent Lejeune <vljn@ovi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm36-vm2.bullet.mail.bf1.yahoo.com
 (nm36-vm2.bullet.mail.bf1.yahoo.com [72.30.238.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 798DD26598F
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 20:30:33 +0200 (CEST)
In-Reply-To: <s5h1tswwl3e.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks, it almost works now !

Actually it requires the AZX_DCAPS_NO_MSI (otherwise dma doesnt work) and A=
ZX_DCAPS_POSFIX_LPIB (otherwise sound is stuttered) and no snoop.
There is still an issue with the sound volume : it's very low, I have to pu=
t my speakers to 100% of their power to actually hear something. Otherwise =
sound is ok, no more crakling as with single_cmd mode.

Dmesg also complains about a db Mismatch, I suspect it's related to the iss=
ue. If I remove the patching ops in snd_hda_codec_build_controls the error =
goes away but there is no more sound and the digital output control disappe=
ar too. I dont know which patch is applied (cmedia ?).


[=A0=A0=A0 2.483128] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0=
002)
[=A0=A0=A0 2.483238] snd_hda_intel 0000:01:00.1: Handle VGA-switcheroo audi=
o client
[=A0=A0=A0 2.483282] snd_hda_intel 0000:01:00.1: irq 50 for MSI/MSI-X
[=A0=A0=A0 2.483454] snd_hda_intel 0000:02:00.0: enabling device (0000 -> 0=
002)
[=A0=A0=A0 2.483494] snd_hda_intel 0000:02:00.0: Disabling MSI
[=A0=A0=A0 2.489701] snd_hda_intel 0000:01:00.1: no codecs initialized
[=A0=A0=A0 2.511016] sound hdaudioC1D1: autoconfig: line_outs=3D4 (0xc/0xe/=
0xd/0xf/0x0) type:line
[=A0=A0=A0 2.511018] sound hdaudioC1D1:=A0=A0=A0 speaker_outs=3D0 (0x0/0x0/=
0x0/0x0/0x0)
[=A0=A0=A0 2.511019] sound hdaudioC1D1:=A0=A0=A0 hp_outs=3D1 (0x10/0x0/0x0/=
0x0/0x0)
[=A0=A0=A0 2.511020] sound hdaudioC1D1:=A0=A0=A0 mono: mono_out=3D0x0
[=A0=A0=A0 2.511021] sound hdaudioC1D1:=A0=A0=A0 dig-out=3D0x14/0x0
[=A0=A0=A0 2.511021] sound hdaudioC1D1:=A0=A0=A0 inputs:
[=A0=A0=A0 2.511022] sound hdaudioC1D1:=A0=A0=A0=A0=A0 Mic=3D0x12
[=A0=A0=A0 2.511023] sound hdaudioC1D1:=A0=A0=A0=A0=A0 Line=3D0x15
[=A0=A0=A0 2.511024] sound hdaudioC1D1:=A0=A0=A0=A0=A0 Aux=3D0x13
[=A0=A0=A0 2.523844] ALSA sound/pci/hda/hda_codec.c:2792 hda_codec: Mismatc=
hing dB step for vmaster slave (-100!=3D1000)

Regards,
Vincent



Le Lundi 4 ao=FBt 2014 13h28, Takashi Iwai <tiwai@suse.de> a =E9crit :
 =


>
>
>At Sun, 3 Aug 2014 14:05:44 -0700,
>Vincent Lejeune wrote:
>> =

>> Hi,
>> =

>> I just found this thread http://thread.gmane.org/gmane.linux.alsa.devel/=
116096 =

>> I'm trying to find what can make the CMI8888 not work in non single_cmd =
mode and it looks more and more like a DMA issue.
>> I don't have an "iommu mode" option in my bios like Geoffrey McRae, it l=
ooks like an AMD only option, and using bigger page size/alignement constra=
int didnt solve the issue.
>> However I added some code to dump the content of the rirb buffer in the =
update_rirb() function and I copied it below.
>> =

>> The first command seems to be correctly handled the second time it is se=
nd to the hardware. As the AZX_DCAPS_*DELAY_RIRB doesnt change anything, I'=
m starting to think
>> that the corb engine may require some delay to be processed.
>> Is there a way to spy the dma transfer request from the device point of =
view ? I'd like to know when the cmi8888 request a dma read from the corb b=
uffer and when it requests a dma write to the rirb buffer
>> to determine if it parses the corb buffer correctly or not.
>
>Well, if the CORB RP is updated, it essentially means that the CORB
>has been updated.=A0 Did you already try snoop=3Dfalse option?
>Also,=A0 AZX_DCAPS_RIRB_PRE_DELAY might be worth to try.
>
>> In addition the first value returned is very odd : 13f68888. The pci id =
of the phoebus is 13f6:5011.
>> What does the 100f0001 cmd mean ? hda-decode-verb tells me the verb is "=
0x0"...
>
>This is the codec IDs, which is often different from the PCI IDs.
>
>
>thanks,
>
>Takashi
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@alsa-project.org
>http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
>
