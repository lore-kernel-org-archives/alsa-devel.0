From: "Sebastian H." <vand2@gmx.de>
Subject: Re: Alsamixer-Qt4 0.4.0 released
Date: Fri, 06 Aug 2010 16:34:50 +0200
Message-ID: <4C5C1D8A.2040906@gmx.de>
References: <4C595A52.7030401@gmx.de>	<AANLkTim=OvWfYgvRLvGgELg5AiJPYZk0snkEHSxxdcaC@mail.gmail.com>	<4C5AB324.2020006@gmx.de>
	<AANLkTimSVVvT2zvhKhcSPyOgf76q2ea61xtjEOd3Kp3t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id F3BCE103971
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 16:33:37 +0200 (CEST)
In-Reply-To: <AANLkTimSVVvT2zvhKhcSPyOgf76q2ea61xtjEOd3Kp3t@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> EQ Peaks is a  volatile control without write access  (i.e. you cannot use
> slider since you cannot modify the value ) which provide the peak of  10
> bands (31Hz, 63Hz, 125Hz, 250Hz, 500Hz, 1Kz, 2Kz, 4Kz, 8Kz , 16Kz) stereo
> channels of the au8830's hardware equalizer  ,  ( one stereo vu-meters at
> each band )
> 
> The values are ordered  by left channel of 10 bands followed by right
> channel of 10 bands
> 
> 
>  control.12 {
>         comment.access read
>         comment.type INTEGER
>         comment.count 20
>         comment.range '0 - 32767'
>         iface MIXER
>         name 'EQ Peaks'
>         value.0 1
>         value.1 1
>         value.2 0
>         value.3 0
>         value.4 1
>         value.5 1
>         value.6 1
>         value.7 1
>         value.8 0
>         value.9 0
>         value.10 1
>         value.11 1
>         value.12 0
>         value.13 0
>         value.14 0
>         value.15 0
>         value.16 1
>         value.17 1
>         value.18 0
>         value.19 0
>     }

Where do you get this listing from?
I greped through the alsa source but did not find it.
Is it an amixer output or so?

> EQ enable switch control the output of DSP pass through/bypass the equalizer
> ,
> so your application can based on the on/off state of the switch to
> start/stop a timer which  read the value from EQ peak control and display on
> 10 stereo vu-meters at regular time intervals
> 
> There are also 10  stereo volume controls to control gain/atten of 10 bands
> of the hardware equalizer
>

I see, thank you for the explanation!


> if your application are unable to display EQ peaks , it is better to skip
> this "EQ peaks" control with count =20 or simple mixer control with 20
> channels

For now I'll skip any element which is named "EQ peaks".
Would this be acceptable with regard to other cards?


> All the EQ controls appear on capture side is a bug of alsa-lib or the
> driver , either change the name of those  "EQ xx" controls to "EQ xx
> Playback" in the driver or add "EQ" to the definition of the controls name

There could be a workaround for this bug in the mixer but IMHO
it should better be fixed in the driver or alsa-lib.


I've enabled the Mercurial repository at sourceforge, it is at:

http://alsamixer-qt4.hg.sourceforge.net:8000/hgroot/alsamixer-qt4/alsamixer-qt4

Cloning and compiling should work like this:

hg clone
http://alsamixer-qt4.hg.sourceforge.net:8000/hgroot/alsamixer-qt4/alsamixer-qt4

cd alsamixer-qt4
mkdir build && cd build
cmake
make


The changes are in the repository if you want to give them a try.

Best,
Sebastian
