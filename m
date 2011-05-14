From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: Alsa Support for Korg Pandora Mini, Vox ToneLab ST
Date: Sun, 15 May 2011 03:13:58 +1000
Message-ID: <BANLkTi=uT5xEJ1xtOqXFqPAH6ghRcJhEhg@mail.gmail.com>
References: <BANLkTikGDzzhXQLTpsHvqqJ=b30JgkumJQ@mail.gmail.com>
	<BANLkTinXgstKju=8-Ow7o542-zZxvKZdTQ@mail.gmail.com>
	<loom.20110514T184918-282@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F0D7E1037F5
	for <alsa-devel@alsa-project.org>;
	Sat, 14 May 2011 19:13:58 +0200 (CEST)
Received: by ewy6 with SMTP id 6so1005905ewy.38
	for <alsa-devel@alsa-project.org>; Sat, 14 May 2011 10:13:58 -0700 (PDT)
In-Reply-To: <loom.20110514T184918-282@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Jaume?= <frederic.jaume@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

HI everyone

Is this possibly related to the usb midi regression felix and members of
this list were discussing a while ago with the fast track ultra which is
another usb composite device?

Grant

2011/5/15 Fr=E9d=E9ric Jaume <frederic.jaume@gmail.com>

> Daniel Mack <zonque <at> gmail.com> writes:
>
> >
> > Hi Pawel,
> >
> > sorry for the long delay.
> >
> > On Tue, Apr 19, 2011 at 9:39 AM, Pawel Siemienski
> > <pawel.siemienski <at> gmail.com> wrote:
> > > I am Ubuntu Studio user and I use also ALSA for driving my audio for
> > > recording etc...
> > > I have tested two devices with ALSA:
> > > 1. Vox Tonelab ST - works with ALSA out of the box as USB audio
> interface
> > > with no need of modifications, provides complete functionalities need=
ed
> for
> > > recording and playing audio
> > > 2. Korg Pandora Mini - is detected as audio interface, but when
> selecting it
> > > information that no controls are available is displayed, this device
> can not
> > > work as audio interface in fact with Alsa.
> >
> > The "Korg Pandora Mini" is no audio interface, according to both your
> > lsusb dump and the Korg website. The device is described as
> > "Ultra-compact pocket-size multi-effect designed for both guitar and
> > bass "[1] and exposes only a MIDI interface on USB, presumably for
> > controlling internal parameters, dumping the configuration etc. It
> > specifically not an USB audio interface, and hence it can not be used
> > in a way that you wanted to.
> >
> > HTH,
> > Daniel
> >
> > [1] http://www.korg.com/pandoramini
> >
>
> Hello,
>
> I own a Korg Pandora PX5D, which is the one released before the Pandora
> Mini. It
> has a USB audio interface that works out of the box with Alsa, which is
> great!
> But it's a composite device and also has USB Midi (it contains a drum
> machine
> that can be triggered via midi, and I think the windows patch editor uses
> midi
> to communicate with the device too), unfortunately it is not recognized by
> Alsa
> (hence no midi or patch editor). From what I read on Korg forums, the
> Windows
> driver for USB-Midi is the same as for other Korg devices which are
> supported
> under Linux, so maybe it can work with Alsa too ? I'd be happy to help by
> sending logs or other infos.
>
> Fred.
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
