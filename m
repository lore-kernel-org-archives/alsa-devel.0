From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: M-Audio Qattro USB
Date: Tue, 18 Jan 2005 07:16:04 +0100
Message-ID: <1106028964.41eca9a4b23a3@www3.webhosting.cx>
References: <200501172244.47086.info@michaelhoffer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www3.webhosting.cx (www3.webhosting.cx [207.44.248.26])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B8909268
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2005 07:16:11 +0100 (MET)
In-Reply-To: <200501172244.47086.info@michaelhoffer.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Michael Hoffer <info@michaelhoffer.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

It's possible the alsa drivers you are using had a broken implementation.

what is the ouput of:

cat /proc/asound/version



Quoting Michael Hoffer <info@michaelhoffer.de>:

> HI!
>
> I read the Install-Howto for snd-usb-audio on www.alsa-project.org. I u=
se
> Gentoo-Linux (kernel 2.6.9). I have the feeling that the .asoundrc file=
 had
> no effect on my system.
>
> When I tried to record with a samplerate of 96000 Hz
> audacity could not open the sounddevice. With 48000 Hz it worked
> fine in audacity.
>
> With arecord I get the following error message. It doesn't make a diffe=
rence
> if I use other sample rates or sample formates.
> arecord gives the following output:
>
> bash-2.05b$ arecord -D quattro -f S24_3LE -r 96000 -c 2 -d 10 test.raw
> Recording WAVE 'test.raw' : Signed 24 bit Little Endian in 3bytes, Rate=
 96000
> Hz, Stereo
> arecord: set_params:854: Sample format non available
>
> Thanks for your help!
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>


 --
 Patrick Shirkey - Boost Hardware Ltd.
 Http://www.boosthardware.com
 Http://www.djcj.org/ - The Linux Audio Users guide
 Http://www.djcj.org/gigs - Gigs Guide Korea
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 Being on stage with the band in front of crowds shouting, "Get off! No!
 We want normal music!", I think that was more like acting than anything
 I've ever done.

 Goldie, 8 Nov, 2002
 The Scotsman


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
