From: =?ISO-8859-1?Q?S=F8ren?= Wedel Nielsen <swn@herlevkollegiet.dk>
Subject: Re: envy24control and gtk2
Date: 25 Mar 2003 20:51:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048621867.3482.23.camel@v304.herlevkollegiet.dk>
References: <1048462242.1151.40.camel@v304.herlevkollegiet.dk>
	 <s5hbrzzpcpn.wl@alsa2.suse.de>
	 <1048621263.26669.34.camel@cmn37.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1048621263.26669.34.camel@cmn37.Stanford.EDU>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

tir, 2003-03-25 kl. 20:41 skrev Fernando Pablo Lopez-Lezcano:
> > > I have upgraded the envy24control program to use gtk2.
> > > To make the layout work I have changed it from fixed to hbox/vbox, =
but I
> > > have tried not to change the structure og the gui-file envy24contro=
l.c.
> > > It will also work with gtk1.
> > >=20
> > > http://www.heko.dk/~swn/envy24control/envy24control-hboxvbox-230303=
.patch
> >=20
> > thanks, i applied this to cvs.
> >=20
> > > To get it to use gtk2 I have changed the build configuration files.
> > >=20
> > > http://www.heko.dk/~swn/envy24control/envy24control-gtk2-230303.pat=
ch
> >=20
> > this is not yet - i suppose many users still stick with gtk1.2.
> > would it be better to put the patch on cvs?
>=20
> Is this an option or mandatory? Will the program still build on gtk1.2?
> Otherwise (for example) users of redhat 7.2 will not be able to compile
> envy24control...
>=20
> -- Fernando

For now the program will compile with gtk1 unless you apply the second
patch yourself. I will try to make it use gtk2 as default and fall back
to gtk1 if gtk2 is not present.

S=C3=B8ren



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
