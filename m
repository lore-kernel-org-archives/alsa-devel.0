From: Peter Oehry <peter.oehry@gmx.li>
Subject: Re: [usb-audio] M-Audio FastTrack Pro giving invalid
 sample rates
Date: Thu, 29 Nov 2007 00:01:59 +0100
Message-ID: <20071128230159.D35D494002@zeus.olymp.home>
References: <474CBC60.9090408@trn.iki.fi>
	<474D3605.5010800@supelec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 933CA24BA5
	for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2007 00:02:05 +0100 (CET)
In-Reply-To: <474D3605.5010800@supelec.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thibault Le Meur <Thibault.LeMeur@supelec.fr>, Lasse =?ISO-8859-1?B?S+Rya2vkaW5lbg==?= <tronic+8nhy@trn.iki.fi>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 28 Nov 2007 10:33:57 +0100
Thibault Le Meur <Thibault.LeMeur@supelec.fr> wrote:

> Lasse K=E4rkk=E4inen a =E9crit :
> > Resending because nobody reacted the last time. This is still broken
> > with 2.6.23.1, except for the fact that it doesn't seem to be possible
> > to adjust bConfigurationValue anymore (this is not exposed under sysfs
> > at least on my system), so I am stuck with configuration 1.
> >   =

> =

> Peter Oehry once proposed a fix for this device and I think it is not =

> applied to HG yet (but I may be wrong): see thread "snd-usb-audio - =

> Driver for M-Audio Fast Track Pro".
> The proposed patch is attached: I don't know if it would fix the issue =

> you're describing.
> =

> But one interesting comment may explain why it may have not been applied:
> <quote>
> =

> +=BB =BB =BB /*=B7This=B7function=B7has=B7to=B7be=B7available=B7by=B7the=
=B7usb=B7core=B7module.=B7
> +=BB =BB =BB =B7=B7=B7if=B7it=B7is=B7not=B7avialable=B7the=B7boot=B7quirk=
=B7has=B7to=B7be=B7left=B7out=B7and=B7the
> +=BB =BB =BB =B7=B7=B7configuration=B7has=B7to=B7be=B7set=B7by=B7udev=B7o=
r=B7hotplug=B7rules=B7*/
> +=BB =BB =BB err=3Dusb_driver_set_configuration(dev,2);
> =

> </quote>

At least this problem should be fixed, since the usb_driver_set_configurati=
on() function is available in a recent Kernel.

See also the discussion on linux-usb-devel list:
"Select Configuration of M-Audio USB Device"
and
"[PATCH] usbcore: help drivers to change device configs"


Peter Oehry
