From: =?ISO-8859-1?Q?Anders_R=F8nningen?= <andersronningen@gmail.com>
Subject: Re: Problem with DELL XPS M1530
Date: Tue, 19 Feb 2008 19:25:24 +0100
Message-ID: <47BB1F14.4050804@gmail.com>
References: <47BB02A4.8080907@gmail.com> <s5hfxvouckf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 4244F24614
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 19:25:29 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so742695nfd.32
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 10:25:28 -0800 (PST)
In-Reply-To: <s5hfxvouckf.wl%tiwai@suse.de>
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

Hi Takashi.

Some dmesg output:

[   14.192000] ALSA =

/mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:2994: =

autoconfig: line_outs=3D1 (0xf/0x0/0x0/0x0/0x0)
[   14.192000] ALSA =

/mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:2998:  =
  =

speaker_outs=3D1 (0xd/0x0/0x0/0x0/0x0)
[   14.192000] ALSA =

/mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:3002:  =
  =

hp_outs=3D1 (0xa/0xf/0x0/0x0/0x0)
[   14.192000] ALSA =

/mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:3003:  =
  =

mono: mono_out=3D0x0
[   14.192000] ALSA =

/mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:3011:  =
  =

inputs: mic=3D0xe, fmic=3D0x0, line=3D0x0, fline=3D0x0, cd=3D0x0, aux=3D0x0
[   14.196000] ALSA =

/mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/../../alsa-kernel/p=
ci/hda/patch_sigmatel.c:2224: =

dac_nids=3D2 (0x5/0x4/0x0/0x0/0x0)

Unmuted and adjusted Surround volume, but it made no difference.

- Anders


Takashi Iwai wrote:
> At Tue, 19 Feb 2008 17:24:04 +0100,
> Anders R=F8nningen wrote:
>   =

>> Hi. I am the mentioned user with this problem. Just thought I'd give you =

>> a little more info on this problem.
>>
>> What wishie described was correct, except it's the internal speakers and =

>> the /left/ hp-jack that stopped working, while the right one is still =

>> ok. Like he wrote, the reason we started this debugging was to get mic =

>> sound on my system. The thing I think is worth mentioning is that with =

>> alsa 1.0.14 on an out-of-the box Ubuntu Gutsy, both hp-jacks and the =

>> internal speakers worked for me. People in #alsa told me that the module =

>> was not loaded correctly, but whatever was loaded _almost_ worked well :=
-)
>>     =

>
> OK, please build the driver with --with-debug=3Dfull option and show the
> kernel messages such as "autoconfig: ..."  and "dac_nids...", etc.
> This contains the information that the pin configuration parser uses.
>
> Also, unmute and adjust "Surround" volume.
>
>
> Takashi
>   =
