From: =?ISO-8859-1?Q?Anders_R=F8nningen?= <andersronningen@gmail.com>
Subject: Re: [PATCH] hda: STAC927x invalid association value
Date: Sun, 24 Feb 2008 11:44:01 +0100
Message-ID: <47C14A71.4020603@gmail.com>
References: <47BCA495.5050201@embeddedalley.com>	<s5hfxvmss9c.wl%tiwai@suse.de>	<47BD9621.5040101@gmail.com>	<s5hpruqs4th.wl%tiwai@suse.de>	<47C09E64.9060503@gmail.com>
	<s5hbq6666x9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id A01F61037EB
	for <alsa-devel@alsa-project.org>; Sun, 24 Feb 2008 11:44:07 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id w49so7813151pyg.36
	for <alsa-devel@alsa-project.org>; Sun, 24 Feb 2008 02:44:05 -0800 (PST)
In-Reply-To: <s5hbq6666x9.wl%tiwai@suse.de>
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
Cc: Jiang zhe <zhe.jiang@intel.com>, alsa-devel@alsa-project.org, Matthew Ranostay <mranostay@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

HG:
http://pastebin.ca/916114

1.0.16:
http://pastebin.ca/916117

This is a regression from 1.0.16. In 1.0.16 everything works nice, =

except that the volume changes almost seem exponential. With PCM and =

Front set to max, I can increase the Master slider from 0% up to about =

50% almost without hearing any change (or sound). From ~70% and up, the =

volume increases _very_ much with each step. Don't know if it's supposed =

to work that way.

--
Anders

Takashi Iwai wrote:
> At Sat, 23 Feb 2008 23:29:56 +0100,
> Anders R=F8nningen wrote:
>   =

>> I finally got around to compiling the latest source.
>>
>> [   14.160000] ALSA =

>> /mnt/storage/source/alsa/mercurial/alsa-driver/pci/hda/hda_codec.c:2994: =

>> autoconfig: line_outs=3D1 (0xd/0x0/0x0/0x0/0x0)
>> [   14.160000] ALSA =

>> /mnt/storage/source/alsa/mercurial/alsa-driver/pci/hda/hda_codec.c:2998:=
    =

>> speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
>> [   14.160000] ALSA =

>> /mnt/storage/source/alsa/mercurial/alsa-driver/pci/hda/hda_codec.c:3002:=
    =

>> hp_outs=3D2 (0xa/0xf/0x0/0x0/0x0)
>> [   14.160000] ALSA =

>> /mnt/storage/source/alsa/mercurial/alsa-driver/pci/hda/hda_codec.c:3003:=
    =

>> mono: mono_out=3D0x0
>> [   14.160000] ALSA =

>> /mnt/storage/source/alsa/mercurial/alsa-driver/pci/hda/hda_codec.c:3011:=
    =

>> inputs: mic=3D0xc, fmic=3D0xe, line=3D0x0, fline=3D0x0, cd=3D0x0, aux=3D=
0x0
>> [   14.160000] ALSA =

>> /mnt/storage/source/alsa/mercurial/alsa-driver/pci/hda/../../alsa-kernel=
/pci/hda/patch_sigmatel.c:2287: =

>> dac_nids=3D3 (0x2/0x5/0x3/0x0/0x0)
>>
>> Now I have sound on both HP and Internal speakers, but levelcontrol is =

>> not ok.
>>
>> Internal Speakers: PCM and Front adjust the level, Master does nothing
>> Left HP Jack: PCM and Front adjust the level, Master does nothing
>> Right HP Jack: PCM adjusts level, Master and Front does nothing.
>>     =

>
> I guess this is also same on 1.0.16?  Or is it a regression after
> 1.0.16?
>
> Could you take alsa-info.sh snapshot for each mixer state?  Then we
> can check the inconsistent mapping between mixer elements and the
> actual I/Os.
>
>
> thanks,
>
> Takashi
>   =
