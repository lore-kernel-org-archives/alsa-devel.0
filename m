From: Ionica Bizau <bizauionica@yahoo.com>
Subject: Re: External sound card issue
Date: Mon, 27 Jan 2014 04:20:55 -0800 (PST)
Message-ID: <1390825255.17630.YahooMailNeo@web162302.mail.bf1.yahoo.com>
References: <CAEiHY5j=K874m_Jk7ws4eOqts855oSHqY0HUrp_A5WwxFoDr=Q@mail.gmail.com>	<52DD1A66.9050909@ladisch.de>	<CAN8cciYR_9Le-tX-CLBjfnYQ1+CuexKzxpxberVkkV6jR_c50A@mail.gmail.com>	<1390398693.24097.YahooMailNeo@web162304.mail.bf1.yahoo.com>	<52E54D7B.3040408@ladisch.de>	<1390765545.16173.YahooMailNeo@web162301.mail.bf1.yahoo.com>
 <s5ha9ehkdk5.wl%tiwai@suse.de>
 <1390824843.46971.YahooMailNeo@web162301.mail.bf1.yahoo.com>
 <1390824903.41806.YahooMailNeo@web162305.mail.bf1.yahoo.com>
 <1390824955.17611.YahooMailNeo@web162303.mail.bf1.yahoo.com>
Reply-To: Ionica Bizau <bizauionica@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm3-vm0.bullet.mail.bf1.yahoo.com
 (nm3-vm0.bullet.mail.bf1.yahoo.com [98.139.212.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 66BEC261B1E
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 13:20:56 +0100 (CET)
In-Reply-To: <1390824955.17611.YahooMailNeo@web162303.mail.bf1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "superquad.vortex2@gmail.com" <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "clemens@ladisch.de" <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Somebody recommended me to run this:

=A0=A0=A0 arecord -f cd -D hw:1,1 | tee recording.wav | aplay

This records the sounds from piano and outputs them to headphones but with =
a delay of 1, 2 seconds.

Do you have any idea about how can be fixed this delay...?




On , Ionica Bizau <bizauionica@yahoo.com> wrote:
 =

I think I will return it to shop.

What external sound card do you recommend me to buy?




On , Ionica Bizau <bizauionica@yahoo.com> wrote:
 =

I still get the Broken pipe error...

ionicabizau@laptop:~$ modprobe snd-usb-audio ignore_ctl_error=3D1
ionicabizau@laptop:~$ alsamixer
cannot load mixer controls: Broken pipe




On , Ionica Bizau <bizauionica@yahoo.com> wrote:
 =

When I run the first command:

$ rmmod snd-usb-audio
rmmod: ERROR:
 Module snd_usb_audio is in use






On Monday, January 27, 2014 10:57 AM, Takashi Iwai <tiwai@suse.de> wrote:
 =

At Sun, 26 Jan 2014 11:45:45 -0800 (PST),
Ionica Bizau wrote:
> =

> I will try them. Is this a bug in the hardware device or in the Linux
 driver?

It's a hardware bug.

> If this is in the Linux driver, can this be fixed?

We have tons of workarounds in the driver for such broken devices.
This will be just yet another one.


Takashi


> =

> Cheers
> =

> =

> =

> On Sunday, January 26, 2014 8:01 PM, Clemens Ladisch <clemens@ladisch.de>=
 wrote:
>=A0 =

> Ionica Bizau wrote:
> > $ amixer -c1 cget name=3D'PCM Capture Source'
> >
 numid=3D7,iface=3DMIXER,name=3D'PCM Capture Source'
> >=A0=A0 ;
 type=3DENUMERATED,access=3Drw------,values=3D1,items=3D2
> >=A0=A0 ; Item #0 'Unit 22'
> >=A0=A0 ; Item #1 'Unit 22'
> > amixer: Control hw:1 element read error: Broken pipe
> =

> The device's firmware does not allow reading this mixer control for some
> reason; this is probably a bug.
> =

> Please try the following commands:
> =A0 rmmod snd-usb-audio
> =A0 modprobe snd-usb-audio ignore_ctl_error=3D1
> =

> This makes the driver ignore errors, but cannot prevent the errors from
> happening in the first place.=A0 Please check if you get the desired
> effect when you write this control.
> =

> =

> Regards,
> =

> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

> =
