From: Ionica Bizau <bizauionica@yahoo.com>
Subject: Re: External sound card issue
Date: Sun, 26 Jan 2014 11:45:45 -0800 (PST)
Message-ID: <1390765545.16173.YahooMailNeo@web162301.mail.bf1.yahoo.com>
References: <CAEiHY5j=K874m_Jk7ws4eOqts855oSHqY0HUrp_A5WwxFoDr=Q@mail.gmail.com>	<52DD1A66.9050909@ladisch.de>
 <CAN8cciYR_9Le-tX-CLBjfnYQ1+CuexKzxpxberVkkV6jR_c50A@mail.gmail.com>
 <1390398693.24097.YahooMailNeo@web162304.mail.bf1.yahoo.com>
 <52E54D7B.3040408@ladisch.de>
Reply-To: Ionica Bizau <bizauionica@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm43.bullet.mail.ne1.yahoo.com (nm43.bullet.mail.ne1.yahoo.com
 [98.138.120.50]) by alsa0.perex.cz (Postfix) with SMTP id 4FAE4261A0E
 for <alsa-devel@alsa-project.org>; Sun, 26 Jan 2014 20:48:29 +0100 (CET)
In-Reply-To: <52E54D7B.3040408@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I will try them. Is this a bug in the hardware device or in the Linux drive=
r?
If this is in the Linux driver, can this be fixed?

Cheers



On Sunday, January 26, 2014 8:01 PM, Clemens Ladisch <clemens@ladisch.de> w=
rote:
 =

Ionica Bizau wrote:
> $ amixer -c1 cget name=3D'PCM Capture Source'
> numid=3D7,iface=3DMIXER,name=3D'PCM Capture Source'
>=A0  ; type=3DENUMERATED,access=3Drw------,values=3D1,items=3D2
>=A0  ; Item #0 'Unit 22'
>=A0  ; Item #1 'Unit 22'
> amixer: Control hw:1 element read error: Broken pipe

The device's firmware does not allow reading this mixer control for some
reason; this is probably a bug.

Please try the following commands:
=A0 rmmod snd-usb-audio
=A0 modprobe snd-usb-audio ignore_ctl_error=3D1

This makes the driver ignore errors, but cannot prevent the errors from
happening in the first place.=A0 Please check if you get the desired
effect when you write this control.


Regards,

Clemens
