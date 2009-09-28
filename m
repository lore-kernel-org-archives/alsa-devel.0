From: Pascal Terjan <pterjan@mandriva.com>
Subject: Re: [PATCH 1/3] [ALSA] Add quirk for Sony Vaio
	VGN-SZ650N
Date: Mon, 28 Sep 2009 13:06:12 +0200
Message-ID: <1254135972.6095.18.camel@plop>
References: <1254130993-8235-1-git-send-email-pterjan@mandriva.com>
	<1254130993-8235-2-git-send-email-pterjan@mandriva.com>
	<s5hzl8f2ya7.wl%tiwai@suse.de> <1254132225.6095.16.camel@plop>
	<s5htyyn2wwg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ryu.zarb.org (ryu.zarb.org [212.85.158.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 26A4F10384C
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Sep 2009 13:06:16 +0200 (CEST)
In-Reply-To: <s5htyyn2wwg.wl%tiwai@suse.de>
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

Le lundi 28 septembre 2009 =E0 12:20 +0200, Takashi Iwai a =E9crit :
> At Mon, 28 Sep 2009 12:03:45 +0200,
> Pascal Terjan wrote:
> > =

> > Le lundi 28 septembre 2009 =E0 11:50 +0200, Takashi Iwai a =E9crit :
> > > At Mon, 28 Sep 2009 11:43:11 +0200,
> > > Pascal Terjan wrote:
> > > > =

> > > > From
> > > > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/195605/comment=
s/25
> > > > =

> > > > Signed-off-by: Pascal Terjan <pterjan@mandriva.com>
> > > =

> > > Thanks for the patch.
> > > I think we can merge all three using SND_PCI_QUIRK_MASK(), e.g.
> > > SND_PCI_QUIRK_MASK(0x104d, 0xff00, 0x9000, "Sony VAIO", STAC_9872_VAI=
O)
> > > =

> > > Or, a bit safer like
> > > SND_PCI_QUIRK_MASK(0x104d, 0xfff0, 0x9000, "Sony VAIO", STAC_9872_VAI=
O)
> > > SND_PCI_QUIRK_MASK(0x104d, 0xfff0, 0x9010, "Sony VAIO", STAC_9872_VAI=
O)
> > > =

> > > Could you check whether it's OK?
> > =

> > I think so, but I can't be sure of how Sony distributed the ids
> > =

> > SZ61 was reported to need model=3Dvaio to have headphones working but I
> > could not find the ids anyway
> > =

> > Some commenter also reported FZ11S needed model=3Dvaio without giving a=
ny
> > info and without id
> > =

> > Given that other model seem to need it too I think that the mask would
> > make sense
> =

> Yep.
> =

> > > Also, please make sure that this change is really needed for the
> > > latest alsa-driver.  The recent version probes the BIOS setup, and
> > > it should work as is unless BIOS is broken.  The quirk entries like
> > > the above override the BIOS setup, thus should be used only when
> > > really needed.
> > =

> > Unfortunately we only have this for a paying customer using 2.6.29 on
> > stable version, and who is happy with adding model=3Dvaio. I found that
> > other had reported on launchpad, but I don't have the hardware myself to
> > test with kernel after July commits
> =

> Is the sound driver also based on 2.6.29 kernel, or built externally
> from the later version of alsa-driver?  The HD-audio driver on 2.6.29
> requires model=3Dvaio explicitly while the later version of alsa-driver
> should work without model option as long as BIOS is correct.

They are using 2.6.29 audio

> So, I'm a bit worried about adding the quirks blindly.

Yes better to not add them then, hopefuly they will work
