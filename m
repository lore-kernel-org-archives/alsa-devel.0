From: "=?ISO-8859-1?Q?Anders_R=F8nningen?=" <andersronningen@gmail.com>
Subject: Re: [PATCH] hda: STAC927x invalid association value
Date: Mon, 25 Feb 2008 07:15:42 +0100
Message-ID: <194b8d500802242215s69aaf49ejf68cd1035da98798@mail.gmail.com>
References: <47BCA495.5050201@embeddedalley.com> <s5hfxvmss9c.wl%tiwai@suse.de>
	<47BD9621.5040101@gmail.com> <s5hpruqs4th.wl%tiwai@suse.de>
	<47C09E64.9060503@gmail.com>
	<1203916311.3853.5.camel@localhost.localdomain>
Reply-To: anders.ronningen@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by alsa0.perex.cz (Postfix) with ESMTP id 2442F2454E
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 07:15:43 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so1495412wag.8
	for <alsa-devel@alsa-project.org>; Sun, 24 Feb 2008 22:15:42 -0800 (PST)
In-Reply-To: <1203916311.3853.5.camel@localhost.localdomain>
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
To: Jiang zhe <zhe.jiang@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Matthew Ranostay <mranostay@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

Yes. In 1.0.16, Master and PCM adjust Left HP, while Master, Front and PCM
adjust Right HP. This means that with Front at 100%, I can adjust Master and
PCM and have equal level in Left/Right HP

--
Anders

On Mon, Feb 25, 2008 at 6:11 AM, Jiang zhe <zhe.jiang@intel.com> wrote:

> On Sun, 2008-02-24 at 06:29 +0800, Anders R=F8nningen wrote:
> > I finally got around to compiling the latest source.
> >
> > [   14.160000] ALSA
> > /mnt/storage/source/alsa/mercurial/alsa-driver/pci/hda/hda_codec.c:2994:
> > autoconfig: line_outs=3D1 (0xd/0x0/0x0/0x0/0x0)
> > [   14.160000] ALSA
> > /mnt/storage/source/alsa/mercurial/alsa-driver/pci/hda/hda_codec.c:2998:
> > speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
> > [   14.160000] ALSA
> > /mnt/storage/source/alsa/mercurial/alsa-driver/pci/hda/hda_codec.c:3002:
> > hp_outs=3D2 (0xa/0xf/0x0/0x0/0x0)
> > [   14.160000] ALSA
> > /mnt/storage/source/alsa/mercurial/alsa-driver/pci/hda/hda_codec.c:3003:
> > mono: mono_out=3D0x0
> > [   14.160000] ALSA
> > /mnt/storage/source/alsa/mercurial/alsa-driver/pci/hda/hda_codec.c:3011:
> > inputs: mic=3D0xc, fmic=3D0xe, line=3D0x0, fline=3D0x0, cd=3D0x0, aux=
=3D0x0
> > [   14.160000] ALSA
> >
> /mnt/storage/source/alsa/mercurial/alsa-driver/pci/hda/../../alsa-kernel/=
pci/hda/patch_sigmatel.c:2287:
> > dac_nids=3D3 (0x2/0x5/0x3/0x0/0x0)
> >
> > Now I have sound on both HP and Internal speakers, but levelcontrol is
> > not ok.
> >
> > Internal Speakers: PCM and Front adjust the level, Master does nothing
> > Left HP Jack: PCM and Front adjust the level, Master does nothing
> > Right HP Jack: PCM adjusts level, Master and Front does nothing.
> >
> The Right HP Jack should be adjusted by "Surround".
> Because there are three jacks on the front panel,
> they can work on 6-channel model.
>
> Were you able to adjust "Right HP Jack" through "Front" in alsa-1.0.16?
>
> Thanks!
>
> > - Anders
>
>
>
>


-- =

Mvh,
Anders
