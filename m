From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: omap34xx mixer elements
Date: Mon, 3 Aug 2009 12:03:31 +0300
Message-ID: <200908031203.31786.peter.ujfalusi@nokia.com>
References: <b3ccc1bb0907270742u50f9e837i3122d5c2bf943eaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FF772467D
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Aug 2009 11:03:40 +0200 (CEST)
In-Reply-To: <b3ccc1bb0907270742u50f9e837i3122d5c2bf943eaa@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
Cc: ext Venkam Bala krishna <venkam.bala@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Monday 27 July 2009 17:42:51 ext Venkam Bala krishna wrote:
> Hi all
>
> Thanks in advance,
>
> I am newbie to alsa
> Currently working on porting android to omap34xx
>
> Right now porting alsa.
>
> This is a general question.
>
> Please check the below log and specify any suggestions,  why is it not
> listing any  of my capture devices.
> What should be done to recognise my capture devices?

to list the capture devices:
arecord -l


> Do i have to do it in kernel level or user level?(since my amixer is
> listing all my elements, given below the log is my amixer output for
> verification).

The mixer controls on the twl4030 codec, which relates to the capture are:

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
> amixer output
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> numid=3D18,iface=3DMIXER,name=3D'Analog Capture Volume'
> numid=3D23,iface=3DMIXER,name=3D'Analog Left Capture Route'
> numid=3D22,iface=3DMIXER,name=3D'Analog Right Capture Route'

Note, that the 'Analog Left Capture Route' 'Analog Right Capture Route' has =

been changed since from mux to mix.

> numid=3D25,iface=3DMIXER,name=3D'TX1 Capture Route'
> numid=3D16,iface=3DMIXER,name=3D'TX1 Digital Capture Volume'
> numid=3D24,iface=3DMIXER,name=3D'TX2 Capture Route'
> numid=3D17,iface=3DMIXER,name=3D'TX2 Digital Capture Volume'
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

In order to make the capture working you need to configure the capture rout=
ing =

correctly. This is board dependent. Check the HW documentation for which in=
put =

are in use and configure the codec accordingly.

-- =

P=E9ter
