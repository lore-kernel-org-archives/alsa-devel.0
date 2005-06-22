From: Tom Watson <sdc695@yahoo.com>
Subject: Speaker test "features" request
Date: Wed, 22 Jun 2005 04:26:17 -0700 (PDT)
Message-ID: <20050622112617.57823.qmail@web60825.mail.yahoo.com>
References: <20050622104624.B20CF12D0B@sc8-sf-spam2.sourceforge.net>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050622104624.B20CF12D0B@sc8-sf-spam2.sourceforge.net>
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
List-Id: alsa-devel@alsa-project.org

> Date: Wed, 22 Jun 2005 18:22:17 +0800
> From: Raymond <rayau@netvigator.com>

<<<deletia>>>
>=20
> I notice that there are female voice wav files in samples subdirectory.
>=20
> ls speaker-test/samples
> Front_Center.wav  Makefile     Noise.wav        Rear_Right.wav=20
> Side_Right.wav
> Front_Left.wav    Makefile.am  Rear_Center.wav  sample_map.csv
> Front_Right.wav   Makefile.in  Rear_Left.wav    Side_Left.wav
>=20
>=20
> Is there an option to use female voice instead of pink noise, sine wave=
 ?
>=20

As noted in the next message (removed) this isn't supported yet.  In doin=
g
many "more than 2 channel" tests I offer the following suggestions and
observations  for implementation of a voice channel identification:
1)  Everyone calls the channels by different names
2)  Many people don't speak English.
3)  If you are poking around waiting for the identifiers to come back to
    the channel you are working on is a $%^&*%$#@ pain.
4)  Just call the channels "one" "two" "three", etc...
5)  Put out an id map in text when the voice identifier starts that
    indicates the correspondence.
6)  Voice ALL the channels at the same time.  You could be feeding a mixe=
r
    board (or other similar instrument) and desire to get everything setu=
p.
    Most mixer boards have a "solo" feature which is helpful in this rega=
rd.
7)  (MCP Comment) Female voice is nice.  Takes the geek edge off of it al=
l.
8)  This is a really nice utility to have around.  It proves out the
    playback system.
9)  Perhaps we can get a "professional voice" to do this.  Fame and notor=
iety
    for the "Open source" voice.  Anyone have any contacts?


p.s.  None of this has anything to do with the error/bug report.  These a=
re
just general comments about a "future direction".

--=20
Tom Watson
tsw@johana.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
