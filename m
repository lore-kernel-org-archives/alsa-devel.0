From: Daniel Mack <zonque@gmail.com>
Subject: Re: Alsa Support for Korg Pandora Mini, Vox ToneLab ST
Date: Sun, 15 May 2011 22:43:37 +0200
Message-ID: <BANLkTik5LMFp-W2q9yhadPdJwswYXUbDgA@mail.gmail.com>
References: <BANLkTikGDzzhXQLTpsHvqqJ=b30JgkumJQ@mail.gmail.com>
	<BANLkTinXgstKju=8-Ow7o542-zZxvKZdTQ@mail.gmail.com>
	<loom.20110514T184918-282@post.gmane.org>
	<BANLkTi=uT5xEJ1xtOqXFqPAH6ghRcJhEhg@mail.gmail.com>
	<BANLkTimWe6OJjRLjNFKKSKyPuSjuZcBLgQ@mail.gmail.com>
	<BANLkTin7JRp6wZeX049Atqn+zmZdkQ1vGQ@mail.gmail.com>
	<BANLkTinFu=NLm+8dkM8h_KLMT=PtrutjYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AF09910387E
	for <alsa-devel@alsa-project.org>;
	Sun, 15 May 2011 22:43:38 +0200 (CEST)
Received: by pvf33 with SMTP id 33so2191134pvf.38
	for <alsa-devel@alsa-project.org>; Sun, 15 May 2011 13:43:37 -0700 (PDT)
In-Reply-To: <BANLkTinFu=NLm+8dkM8h_KLMT=PtrutjYg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric_Jaume?= <frederic.jaume@gmail.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Sun, May 15, 2011 at 7:54 PM, Grant Diffey <gdiffey@gmail.com> wrote:
> So I reverted=A0 7b6717e and... Nope. still no midi ports.
>
>
> Kernel messages are:
>
> [=A0 131.484053] usb 3-1: new high speed USB device using ehci_hcd and ad=
dress
> 3
> [=A0 131.617753] usb 3-1: config 1 interface 3 altsetting 0 bulk endpoint=
 0x7
> has invalid maxpacket 8
> [=A0 131.617760] usb 3-1: config 1 interface 3 altsetting 0 bulk endpoint=
 0x87
> has invalid maxpacket 8
> [=A0 131.618750] usb 3-1: New USB device found, idVendor=3D0763, idProduc=
t=3D2080
> [=A0 131.618754] usb 3-1: New USB device strings: Mfr=3D1, Product=3D2,
> SerialNumber=3D0
> [=A0 131.618756] usb 3-1: Product: Fast Track Ultra
> [=A0 131.618758] usb 3-1: Manufacturer: M-Audio
> [=A0 132.767312] usbcore: registered new interface driver snd-usb-audio
>
> And amidi -l reports
>
> nevyn@cetacea:~/linux$ amidi -l
> Dir Device=A0=A0=A0 Name
>
> the hack mentioned earlier of setting the quirk STANDARD_MIDI_INTERFACE t=
hat
> clemens suggested does work but I'm not sure it's the "right" answer to t=
he
> problem.

For the Fasttrack, this shouldn't be necessary, no. Can you send the
full output of "lsusb -v", please? The sniplet you posted in your
orignial message only contained the interface.

For the Korg Pandora interface though, a quirk is certainly needed, as
the interface is marked as vendor specific (0xff).


Daniel
