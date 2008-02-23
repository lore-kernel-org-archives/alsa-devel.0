From: =?ISO-8859-1?Q?Anders_R=F8nningen?= <andersronningen@gmail.com>
Subject: Re: [PATCH] hda: STAC927x invalid association value
Date: Sat, 23 Feb 2008 23:29:56 +0100
Message-ID: <47C09E64.9060503@gmail.com>
References: <47BCA495.5050201@embeddedalley.com>	<s5hfxvmss9c.wl%tiwai@suse.de>	<47BD9621.5040101@gmail.com>
	<s5hpruqs4th.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 63762244A1
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 23:30:02 +0100 (CET)
Received: by gv-out-0910.google.com with SMTP id c6so553903gvd.24
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 14:30:01 -0800 (PST)
In-Reply-To: <s5hpruqs4th.wl%tiwai@suse.de>
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

I finally got around to compiling the latest source.

[   14.160000] ALSA =

/mnt/storage/source/alsa/mercurial/alsa-driver/pci/hda/hda_codec.c:2994: =

autoconfig: line_outs=3D1 (0xd/0x0/0x0/0x0/0x0)
[   14.160000] ALSA =

/mnt/storage/source/alsa/mercurial/alsa-driver/pci/hda/hda_codec.c:2998:    =

speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
[   14.160000] ALSA =

/mnt/storage/source/alsa/mercurial/alsa-driver/pci/hda/hda_codec.c:3002:    =

hp_outs=3D2 (0xa/0xf/0x0/0x0/0x0)
[   14.160000] ALSA =

/mnt/storage/source/alsa/mercurial/alsa-driver/pci/hda/hda_codec.c:3003:    =

mono: mono_out=3D0x0
[   14.160000] ALSA =

/mnt/storage/source/alsa/mercurial/alsa-driver/pci/hda/hda_codec.c:3011:    =

inputs: mic=3D0xc, fmic=3D0xe, line=3D0x0, fline=3D0x0, cd=3D0x0, aux=3D0x0
[   14.160000] ALSA =

/mnt/storage/source/alsa/mercurial/alsa-driver/pci/hda/../../alsa-kernel/pc=
i/hda/patch_sigmatel.c:2287: =

dac_nids=3D3 (0x2/0x5/0x3/0x0/0x0)

Now I have sound on both HP and Internal speakers, but levelcontrol is =

not ok.

Internal Speakers: PCM and Front adjust the level, Master does nothing
Left HP Jack: PCM and Front adjust the level, Master does nothing
Right HP Jack: PCM adjusts level, Master and Front does nothing.

- Anders

Takashi Iwai wrote:
> At Thu, 21 Feb 2008 16:17:53 +0100,
> Anders R=F8nningen wrote:
>   =

>> I tried with "alsa-driver-hg20080221", and now left HP and internal =

>> speakers are gone again.
>>     =

>
> Of course it doesn't work.  The daily snapshot was created before
> today's fix patches.  Use mercurial to get the latest sources.
>
>
> Takashi
>   =
