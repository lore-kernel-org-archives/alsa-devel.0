From: Manuel Jander <manuel.jander@gmail.com>
Subject: Re: au88x0 Init before create components
Date: Wed, 26 Apr 2006 20:24:45 +0200
Message-ID: <1146075886.13706.8.camel@localhost.localdomain>
References: <200604261414.52173.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200604261414.52173.gineera@aspect135.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

This is my current and hopefuly "for ever" email address.
(hmm, hopefuly no spammer gets this one: _manuel_._jander_|@_gmail|.|
com) (remove _ and | characters).
My address at embedded.cl no longer exists. A am very pleased about that
someone is posting patches to the au88x0 drivers :)

By the way I'm living in Erlangen now, far close to the ALSA guys in
N=FCrnberg.

Best Regards,
Manuel Jander

On Wed, 2006-04-26 at 14:14 +0100, Alan Horstmann wrote:
> Patch as suggested by Raymond in one of his copious bug-track notes.
>=20
> Change the order in vortex_probe to init the card details before creati=
ng the=20
> components, meaning for example that card->shortname is available when=20
> registering the midi port.
>=20
> I have also added extra to card->shortname, and a line to overwrite the=
 midi=20
> name following snd_mpu401_uart_new, for consideration.
>=20
> Do I have the correct address to cc mjander?
>=20
> au88x0-init-before-comps-et-al.patch
>=20
> Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job ea=
sier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642
