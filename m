From: christophe barbe <christophe@cattlegrid.net>
Subject: intel8x0 ACPI suspend/resume bug
Date: Tue, 28 Jun 2005 11:06:39 -0400
Message-ID: <20050628150638.GB6677@cattlegrid.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi,

On my IBM X40, the sound outputs become crappy after a suspend/resume
cycle. I am convinced that it's a gain value that goes wrong (but I
could be wrong) as most of the time one side is not outputing sound
anymore (only statics) but I can sometimes get this channel back by
lowering its volume (so I think it's a kind of hardware protection=20
that cuts the channel off if the gain is too high).

Anyway I wrote every details in my bug report:
   https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D917
and I would really appreciate if someone could help me hunt this bug. I
tried everything that came to my mind and don't know what to try now.

NOTE: The most recent alsa driver I tried is
alsa-driver-1.0.9rc4a.tar.bz2.

Thanks,
Christophe

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
