From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Date: Tue, 4 Apr 2006 21:59:12 -0400
Message-ID: <200604042159.12479.dtor_core__10528.0520664111$1144202526$gmane$org@ameritech.net>
References: <44238489.8090402@keyaccess.nl> <d120d5000604041428h65931eb6qffe1af04d91e7f31@mail.gmail.com> <20060404214522.GA20390@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp106.sbc.mail.re2.yahoo.com (smtp106.sbc.mail.re2.yahoo.com [68.142.229.99])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 9A1FF183
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 03:59:15 +0200 (MEST)
In-Reply-To: <20060404214522.GA20390@suse.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Greg KH <gregkh@suse.de>
Cc: rene.herman@keyaccess.nl, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Tuesday 04 April 2006 17:45, Greg KH wrote:
> > But why do we do that? probe() failing is driver's problem. The device
> > is still there and should still be presented in sysfs. I don't think
> > that we should stop if probe() fails - maybe next driver manages to
> > bind itself.
>=20
> The device is still there.
>=20
> Ah, I see what you are saying now. =A0Yeah, we should still add the
> default attributes for the bus and create the bus link even if some
> random driver had problems.=20

Not only that, but device will be killed as well - if bus_add_device()
fails device_add() branches into BusError which leads to kobject_del().

=2D-=20
Dmitry


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
