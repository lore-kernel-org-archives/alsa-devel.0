From: =?UTF-8?Q?Nicolas_Ma=C3=AEtre?= <nimai@skynet.be>
Subject: Re: Fwd: Request for HW auto-recognition: HP Pavilion
 dv7 with STAC92xx
Date: Mon, 17 Dec 2012 15:02:19 +0100
Message-ID: <CACd4Q008FETHS04bWpgmGBzrkgi5wS895sKympBWCynUCJ_VQQ@mail.gmail.com>
References: <CACd4Q01r1Oa=ds0+eskdkvnMJytuLRj5FPYyNjbdnx5WNWWZvQ@mail.gmail.com>
 <CACd4Q01r58JL3hD49mtT97+7Jkdpr8Sgfni88wHfsE79_dTP6A@mail.gmail.com>
 <s5hr4mrpqek.wl%tiwai@suse.de>
 <CACd4Q03Vy4DBVVM5gyo9NF+aOaBAPoKig8hG7SahMdNhq=smjQ@mail.gmail.com>
 <CAN8cciZjR5jo0DUpd_iLZ-00bb-5rveBEK9LezBf-79=QT_oMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
 [209.85.212.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 618572625CC
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2012 15:02:40 +0100 (CET)
Received: by mail-wi0-f175.google.com with SMTP id hm11so1990053wib.2
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2012 06:02:40 -0800 (PST)
In-Reply-To: <CAN8cciZjR5jo0DUpd_iLZ-00bb-5rveBEK9LezBf-79=QT_oMw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 17, 2012 at 3:55 AM, Raymond Yau
<superquad.vortex2@gmail.com> wrote:
>
> Trying remove PCI quirk and use auto to find out node 0x0f is the internal
> speaker
>
> - SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1659,
> - "HP", STAC_92HD83XXX_HP_cNB11_INTQUAD),

Not sure of what you expect of me, but anyway I've tried a kernel
without the quirk and here's the result:

original kernel, model=dv7-4000:
0x0a 0x03a12050
0x0b 0x0321201f
0x0c 0x40f000f0
0x0d 0x90170110
0x0e 0x40f000f0
0x0f 0x40f000f0
0x10 0x90170110
0x11 0xd5a30140
0x1f 0x40f000f0
0x20 0x40f000f0
1

kernel without quirk, model=auto:
0x0a 0x40f000f0
0x0b 0x0221101f
0x0c 0x02a11020
0x0d 0x40f000f0
0x0e 0x40f000f0
0x0f 0x92170110
0x10 0x40f000f0
0x11 0xd5a30130
0x1f 0x40f000f0
0x20 0x40f000f0
1

And I can see that 0x0f is the internal speaker (at least in hda-jack-retask)
The sound is only output on the 2 rear speakers (no front nor subwoofer).
So what now?


--
nimai
