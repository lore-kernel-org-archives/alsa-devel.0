From: "Tais M. Hansen" <tais.hansen@osd.dk>
Subject: Re: Re: [Alsa-user] Upgrade problems -addendum
Date: Fri, 24 Jan 2003 22:24:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301242224.47436.tais.hansen@osd.dk>
References: <200301221234.33054.tais.hansen@osd.dk> <200301241740.13498.tais.hansen@osd.dk> <s5hvg0eo4r0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvg0eo4r0.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 24 January 2003 18:08, Takashi Iwai wrote:
> sorry, i need the output of "lspci -nv".

$ lspci -s 00:11.5 -nv
00:11.5 Class 0401: 1106:3059 (rev 40)
        Subsystem: 1462:4720
        Flags: medium devsel, IRQ 9
        I/O ports at e800 [size=3D256]
        Capabilities: [c0] Power Management version 2


> > > now comes the patch of the week:
> > > idx_detect=3D1 : like test7.  perhaps not perfect.
> > No sound, so you're right.
> hmm, it should produce some sounds.

I just gave it another try with aplay. Bad idea; froze the system. Someth=
ing's=20
really wrong with the test8-patch.


> > > idx_detect=3D2 : use the interrupt pointer only.  the resolution wi=
ll be
> > >                in the size of periods.  this should work.
> > Maybe. But it didn't. Seems to go a little too fast playing. No sound=
 at
> > all.
> no sound?
> on all applications?

Well, I'd like to try, but now that my system froze on 1 and 3, I wouldn'=
t=20
dare. :)


> then it can be another bug in the different place, which was got in
> during the last rewrite...

Sounds possible. If only I had more insight on audio hardware programming=
 I'd=20
might be able to be more helpful.

- --=20
Regards,
Tais M. Hansen
OSD

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQIVAwUBPjGvHoIvLOJqwYc4AQLkeBAAmC5cKCyCd7D3HoCfNSvd7DbtmppUtHV2
/6axRVxaJG+BTJ4fRiyZGzDJYywhvmgIpy6AlM81hNMwSWTXtx9AbyB7GKtBepTW
qRUl/dB2E7oKmWvWNCL4h+wdyFeQqIqs5NG7QaOXtUaeQAJaacqmLrY22kmyx9ek
37hUBuWoJcX/VpGfvojhbOvoIspnMszgBiFOINHXE3cKi2y7YNyJp2LhDbeDVjhu
Oy/oL4OIAAgB7OTFGFvlT2/w3zSiYs2ctuz5Rt9yHeMSZ4tb4nInI3epSlpWxZQr
fCkTmcjD3bea30OMkjlK7B6AkNudPIG/qXIhl1gZrhYFBctCISDdJLxtR/P21U3C
J7J6JiPhdTfBSgiglQBcngtWHL873ZiWHnmdrD5b+9n0ocylzKO92kEXIhUB1q52
aXtl5KRojnsPx7jnB6x7EYIc5A7DJMKkVdxXQT2cUxGhvSwkV3C1kGnwVm4V0s6S
to22WbFpah3b8Ywfk+CInZGOc/zPDc61gLpf/Oo7Hv3zsCry4rd6JFM366I/jDlW
8s52bA4JKM1ch0kOB5IhC7iwVUOXYutwqDDJH5eq5WISWviU1WEuJefcxSmu7Hpt
RqUEwEq+WQKHSWSpN9h/68EBpqkIiRXoFTfzSedKh34XYpYkr4IXtosorrIPh5VP
RNsVE8j6cDI=3D
=3DBSFL
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
