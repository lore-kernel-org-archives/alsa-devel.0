From: "Hicks, Jamey" <Jamey.Hicks@compaq.com>
Subject: RE: UDA1341TS (iPAQ H3X00) sound driver for ALSA
Date: Fri, 12 Apr 2002 13:39:30 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a9766p$ja1$2@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@cam.org>, Kasparek Tomas <xkaspa06@stud.fee.vutbr.cz>, alsa-devel@lists.sourceforge.net, Linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Friday, April 12, 2002 1:36 PM
> To: Hicks, Jamey
> Cc: Nicolas Pitre; Kasparek Tomas; alsa-devel@lists.sourceforge.net;
> Linux-arm-kernel@lists.arm.linux.org.uk
> Subject: Re: UDA1341TS (iPAQ H3X00) sound driver for ALSA
>=20
>=20
> On Wed, Apr 10, 2002 at 09:55:43AM -0400, Hicks, Jamey wrote:
> > > -----Original Message-----
> > > From: Nicolas Pitre [mailto:nico@cam.org]
> > >=20
> > > No.  Please pick a relevant name.  H3600 is not the only=20
> > > device with an UDA1341 out there.
> >=20
> > The alsa driver mentioned is iPAQ specific.  It would be useful to
> > restructure it in the way the other SA11x0/UDA134x driver=20
> is structured.
>=20
> I agree with Nico.  Nico is objecting to it being called=20
> *h3600* when it
> is for all iPAQs, ie, H3600, H3100, H3800.
>=20

If that is the case, I am open to suggestions for the name should be, =
bearing in mind that not all iPAQ devices from Compaq are handheld =
devices.  h3xxx seems like a good choice at the moment, but I have a =
feeling we'll be sharing some of the same drivers with h4xxx in the near =
future.

Jamey
