From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: Re: au88x0_synth
Date: Mon, 6 Jun 2005 16:35:08 +0200
Message-ID: <200506061635.12201.alien999999999@users.sourceforge.net>
References: <423CCDAC.80401@netvigator.com> <200506061049.40902.alien999999999@users.sourceforge.net> <42A42D80.2020505@netvigator.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7315305.oukQpB6nWO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42A42D80.2020505@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Raymond <rayau@netvigator.com>
List-Id: alsa-devel@alsa-project.org

--nextPart7315305.oukQpB6nWO
Content-Type: multipart/mixed;
  boundary="Boundary-01=_c8FpCgCmq78YjIG"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_c8FpCgCmq78YjIG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op maandag 6 juni 2005 13:03, schreef Raymond:
> What do you mean when you say "the equalizer sliders look odd" ?

i'll show you: see png file, notice that the first 2 peaks are stereo, and =
the=20
last 2 peaks are mono... ???

> Would you post the settings of the equalizer from "/data/path/mixer" or
> /etc/asound.state ?

I must also say that when restoring, i always get one warning: something wi=
th=20
bad value for... somethingorother

/etc/asound.state:
state.au8810 {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'EQ Enable'
		value false
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ0 31Hz'
		value.0 16375
		value.1 16375
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ1 63Hz'
		value.0 16392
		value.1 16392
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ2 125Hz'
		value.0 16375
		value.1 16375
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ3 250Hz'
		value.0 16022
		value.1 16022
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ4 500Hz'
		value.0 16022
		value.1 16022
	}
	control.7 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ5 1KHz'
		value.0 16022
		value.1 16022
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ6 2KHz'
		value.0 16022
		value.1 16022
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ7 4KHz'
		value.0 16022
		value.1 16022
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ8 8KHz'
		value.0 16022
		value.1 16022
	}
	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ9 16KHz'
		value.0 16022
		value.1 16022
	}
	control.12 {
		comment.access read
		comment.type INTEGER
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ Peaks'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 0
		value.18 0
		value.19 0
	}
	control.13 {
		comment.access 'read write'
		comment.type IEC958
		iface PCM
		name 'IEC958 Playback Default'
		value=20
'00820000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000'
	}
	control.14 {
		comment.access read
		comment.type IEC958
		iface PCM
		name 'IEC958 Playback Con Mask'
		value=20
ffffff0f0000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000
	}
	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.16 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Master Playback Volume'
		value.0 24
		value.1 24
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Mono Playback Switch'
		value true
	}
	control.18 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Master Mono Playback Volume'
		value 24
	}
	control.19 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PC Speaker Playback Switch'
		value false
	}
	control.20 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 0
	}
	control.21 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Phone Playback Switch'
		value false
	}
	control.22 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Phone Playback Volume'
		value 0
	}
	control.23 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.24 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 0
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Boost (+20dB)'
		value false
	}
	control.26 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Playback Switch'
		value true
	}
	control.27 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 24
		value.1 24
	}
	control.28 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'CD Playback Switch'
		value true
	}
	control.29 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 24
		value.1 24
	}
	control.30 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Video Playback Switch'
		value false
	}
	control.31 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Video Playback Volume'
		value.0 0
		value.1 0
	}
	control.32 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Aux Playback Switch'
		value false
	}
	control.33 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 0
		value.1 0
	}
	control.34 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		value true
	}
	control.35 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 24
		value.1 24
	}
	control.36 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic
		comment.item.1 CD
		comment.item.2 Video
		comment.item.3 Aux
		comment.item.4 Line
		comment.item.5 Mix
		comment.item.6 'Mix Mono'
		comment.item.7 Phone
		iface MIXER
		name 'Capture Source'
		value.0 Line
		value.1 Line
	}
	control.37 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Capture Switch'
		value true
	}
	control.38 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		value.0 12
		value.1 12
	}
	control.39 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mix
		comment.item.1 Mic
		iface MIXER
		name 'Mono Output Select'
		value Mix
	}
	control.40 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic1
		comment.item.1 Mic2
		iface MIXER
		name 'Mic Select'
		value Mic1
	}
}

--Boundary-01=_c8FpCgCmq78YjIG
Content-Type: image/png;
  name="au88x0-eq.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="au88x0-eq.png"

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
njRFER5PyOMJOp3mzk7vmPP0tpy2WrW410ubO10d09JUvz+8e/fiiopch8Oyd+9nGRnavHlWIeLn
Bi+c8S8ui3v9rM2i41evoxHWrbtl//6l+/cvzc213HZb9tNPly9cmBnzn1L9/yZ27OvlyErO/ZE4
Ky1NratzPfHEQrNZFUKMOc9xXS9Z7nR1HJKVpX3rW/lDn7s9e8oKC9NHeayOff2szKLjV68jAAAG
UWy2mqTfqN9/wu+PczaGxbLcYrktdWX0uUZmzYaOzJOOzJOOqc7SUrGQ3G6RYIi3pSIubq6RWbOh
I/OkI/OkY6qzTDZbzbJlWdXVxV1dvu7uQPQiu13bubN09WpnTo6ludkd94Zycy1PPLEo+hvlO3cu
XrMm76OPrvv9TXGH6HTeUV+/MXqbo+TedVeuzxfu6PAm6vDCC1/74IOrIzbtzVwjs4Z1zCivXyRW
Z1/NMfubB7KXZd6oLmjpCqR3B9Nu5poCO4ub7srq9EVMHf6Er++9UHr0gxtFknQcJau8PKu6urij
wzv0y51Ra9bkPfzwraqqXrw4UFZmf+SR+Z98csNu1+66K7etbaCqqvD8eXf0Nf9JPGaitxnzIQsW
ZD766Pzubv+NG/7ofejp8Y+ZO0rWQw8VVVUVeDyhzk6fPkt/H6LXuN3Bp55avHq18/LlwXA4Es09
ffpjn+/EhDrqZ6j/kLhZvb03PxeJckd/zCxbllVWZm9ru5lltZri3v5Usny+sP42484z+jh58MG5
1675KipykvKY0T824s5zcDA0odxRsurrXatXO1escBw71h1zD4fm3N3tT0XHNWvyNm681e+P/XqP
vt3jCSar4913527ceOvIr33910V05oFAOG6u/jGjmkzKjh2LX3utde/ecv0t2u2axWI6cKD53Xc7
MjJM1dXF3/3uAofDIoRYscKxY0dpRUWOEKKoKGP79lKXyy6EeOONC6NvQrvdHL3N0XMbG8/V1ZWp
quJy2WtrS8vK7DG5QzZsmKtpyoYNc598clF+ftp0ZUWVWK335GVa1NCBi7e9e73YpER2FDe9dqVs
7/x/D8s1BSxquLF9ad28z1QRcVl7aouayqw9QogVtus7ipoqsq7dzM27oCnhDXkXniz6PN8yKIR4
YM4cs6pKMk9VFbt2lf72t6179pTFTOPkyb7GxvNPPrlICNHbG1i82KYowm7X1qzJE0Lcd1+Bqirb
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
YII=

--Boundary-01=_c8FpCgCmq78YjIG--

--nextPart7315305.oukQpB6nWO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCpF8guBWKXETrtdcRAj4aAJ9NXUBlokxNgOvXQyX4rLugh00AFgCgu0OA
sANpDLO5mIAVsQgax0wpipE=
=1jwL
-----END PGP SIGNATURE-----

--nextPart7315305.oukQpB6nWO--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
