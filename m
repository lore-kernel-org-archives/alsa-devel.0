From: "Stephen Warren" <SWarren@nvidia.com>
Subject: RE: New azx driver: Problems in snd_mixer_load
Date: Thu, 9 Dec 2004 12:44:39 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0033AE11F@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> From: Takashi Iwai [mailto:tiwai@suse.de]=20
>=20
> At Thu, 9 Dec 2004 10:20:04 -0800,
> Stephen Warren wrote:
> >=20
> > ...
> > On top of this, I added the latest CVS version of the azx=20
> > driver into the kernel.
> >=20
> > Now, when I run alsamixer, I get the following error=20
> > message right at startup:
> >=20
> > =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > root@localhost# alsamixer
> > ALSA lib simple.c:950:(simple_add1) helem (MIXER,'Capture=20
> Source',0,0,0)
> > appears twice or more
> > alsamixer: function snd_mixer_load failed: Invalid argument
> > =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>=20
> Could you show the content of /etc/asound.state after "alscatl store"?
> Also, try to build with --with-debug=3Ddetect
> (i.e. CONFIG_SND_DEBUG_DETECT=3Dy).  This will give some more=20
> verbose info.

The content of asound.state is below. I'll rebuild the kernel without
any of the ALSA drivers, and build everything from CVS to see if it's
any better...

state.HDA {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Capture Switch'
		value.0 false
		value.1 false
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 30'
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.3 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 'Input 0'
		comment.item.1 Line
		comment.item.2 Mic
		comment.item.3 'Input 3'
		comment.item.4 'Input 4'
		comment.item.5 Mic
		comment.item.6 CD
		comment.item.7 'Input 7'
		comment.item.8 'Input 8'
		iface MIXER
		name 'Capture Source'
		value 'Input 0'
	}
}

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html
=20



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
