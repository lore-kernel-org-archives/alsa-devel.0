From: Thomas Witzel <witzel.thomas@comcast.net>
Subject: Re: Programming the unknow P16v chip on the Audigy2
Date: Tue, 1 Jun 2004 15:15:28 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406011515.34504.witzel.thomas@comcast.net>
References: <40B789D7.8060704@superbug.demon.co.uk>
Reply-To: witzel.thomas@comcast.net
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40B789D7.8060704@superbug.demon.co.uk>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 28 May 2004 01:49 pm, James Courtier-Dutton wrote:
> Basically, one writes the register address to PTR, and then read or
> write to DATA.
>
> On the Audigy2 there is a similar setup for 0x20 and 0x24. I suspect
> that this is used to program the p16v chip.
I guess that is correct.=20
> Had anyone looked into those registers, and tried to guess what they do ?
With virtually no information this would be difficult. It seems like that=20
playback over the P16V would be an easier goal than getting the inputs
to work, but I have no idea how to make a PCM extension for the P16V.
The routing diagram shown on the kX webpage indicates that there should be=
=20
direct playback not using the 10k2 at all. They have made a special effects=
=20
module which allows input coming through the P16V to be routed into the 10k=
2,
but normally there doesn't seem to be a connection.

												Thomas

=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAvOPkErlRqeo9RVURAtmxAJ4tgZDpge2ccMwlbXiwuEuTMewzvQCfdYJo
cg5An6CWYX9ari21NEVgGug=3D
=3D+WsE
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
