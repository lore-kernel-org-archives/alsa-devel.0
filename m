From: =?ISO-8859-1?Q?Andr=E9e_=27Glaucous=27?= <glakke1@gmail.com>
Subject: Re: HDMI LPCM (7.1) with AMD/FGLRX
Date: Tue, 9 Aug 2011 12:39:01 +0200
Message-ID: <CAD=fgeL1zYF+geFoX3y7Kbz2rNdL60uKxKoZPcE=XOB4aihP8w@mail.gmail.com>
References: <CAD=fgeJpR6xJbHxmp3EfWa1SOn_dx6ibQ4ffBTdf492UYrR06w@mail.gmail.com>
	<s5haabk9xud.wl%tiwai@suse.de>
	<CAD=fgeLDRisd8V88NL7L8Vfty95kCqaWUDM6onxSPNbd2udwRw@mail.gmail.com>
	<s5hk4aogrhu.wl%tiwai@suse.de>
	<CAD=fgeJrbWs9faGKf_wah7qOLV3juDHSDNtTnhy3XQ2u2WzM4w@mail.gmail.com>
	<s5hmxfkf505.wl%tiwai@suse.de>
	<CAD=fge+x+wPPROTsnOSkwUM+PXKLajYxLczZFhmRqksd25oKJA@mail.gmail.com>
	<s5h39hceyqw.wl%tiwai@suse.de>
	<CAD=fge+v1C9mNU8Bq06HTsY-qmXB76UZkXP3kPyvefrzXEQp8g@mail.gmail.com>
	<CAD=fgeKsQAFTD3m41p7o6AAm9H53On=O4ZOkioCk+CJJQ99RTA@mail.gmail.com>
	<s5h4o1ryrug.wl%tiwai@suse.de>
	<CAD=fgeJiB9njYmawo44R8eW96nyxv99G=QptkvP2zO3P+7oBWg@mail.gmail.com>
	<s5hhb5qew8g.wl%tiwai@suse.de>
	<CAD=fge+K_UE3pSPm4dUm1T4MCBS3Ja_=tNOqGGCxocKR=YuoHQ@mail.gmail.com>
	<s5hd3geeuto.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CA3431037FF
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 12:39:01 +0200 (CEST)
Received: by vxh2 with SMTP id 2so3958034vxh.38
	for <alsa-devel@alsa-project.org>; Tue, 09 Aug 2011 03:39:01 -0700 (PDT)
In-Reply-To: <s5hd3geeuto.wl%tiwai@suse.de>
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

Do you think it might be possible to get in touch with the ATI/AMD
developers, and get implementation details?
I can't imagine that they don't want LPCM to work with ALSA.

On 9 August 2011 12:35, Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 9 Aug 2011 12:31:03 +0200,
> Andr=E9e 'Glaucous' wrote:
> >
> > I run
> > speaker-test -D hw:1,3 -c 8
> > Now it actually worked a bit. The speaker-test runs as it should, but
> > everytime it tries output to "none-two-channel" channel (LFE, Rear Left,
> > Rear Right.. etc),
> > it doesn't output anything. And I can see on the receiver that the (2
> > channel PCM stream, but should say 7.1 Multichannel) is lost every time
> > except for Front Left/Right channel.
>
> Then some information is missing.  ATI seems to have implemented LPCM
> in a vendor-specific way.
>
>
> Takashi
>
> >
> > On 9 August 2011 12:05, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > At Tue, 9 Aug 2011 11:37:37 +0200,
> > > Andr=E9e 'Glaucous' wrote:
> > > >
> > > > Current kernel message (using alsa-kernel, I'll clone and build your
> git
> > > > soon, got some internet problems at the moment):
> > > > [  147.334343] XXX HDMI pin_sense =3D 0x7fffffff
> > > > [  147.565059] XXX HDMI pin_sense =3D 0x7fffffff
> > > > [  153.248894] XXX HDMI pin_sense =3D 0xffffffff
> > > > [  153.250443] XXX HDMI pin_sense =3D 0xffffffff
> > > > [  189.475073] XXX HDMI pin_sense =3D 0x7fffffff
> > > > [  189.698017] XXX HDMI pin_sense =3D 0x7fffffff
> > > > [  196.664565] XXX HDMI pin_sense =3D 0xffffffff
> > > > [  196.666079] XXX HDMI pin_sense =3D 0xffffffff
> > > >
> > > > It recognizes when I take the cable in and out, or toggles display
> output
> > > > (0xffffffff when connected).
> > >
> > > OK, it's good to know.  It means that the pin-sense reports only the
> > > pin-detection but nothing else unlike other codecs.  So, it's
> > > basically bad to use generic HDMI parser for this codec.
> > >
> > > And, when you wrote "I still can't run speaker-test with more than 2
> > > channels", do you mean that you got an error?  How did you run?
> > > With the patch, the driver should take up to 8 channels.  If not,
> > > something was wrong -- either the patch wrongly applied or the patch
> > > wasn't enough.
> > >
> > >
> > > Takashi
> > >
> >
>
