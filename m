From: =?ISO-8859-2?Q?Sz=E9kelyi_Szabolcs?= <cc@mail.3d.hu>
Subject: virtual network-soundcard
Date: Wed, 15 Nov 2006 00:45:30 +0100
Message-ID: <455A551A.4060004@mail.3d.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dear developers,

I'm working on a (free) audio-over-IP solution. To be transparent to
existing ALSA-aware applications, I found that it would be useful to
write a low-level driver for ALSA that looks like a sound card for
programs, which makes integrating them info the IP world a(n almost)
zero-effort work.

I'd like to hear your thoughts about this idea and also get some
pointers to the way to go. Is writing a virtual "sound" card driver
necessary or can a PCM plugin do the trick (I don't think so, because it
needs to generate interrupts when a synchronizing frame (representing
time) arrives on the wire)?

Please Cc me, I'm off-list.

Thanks & bye,
- --
cc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFWlUaGJRwVVqzMkMRAuGJAJ9w4Nf4puzdq+IXUrF+1Yafi30PQQCgpWsx
cDrngX739SKY7dSd6UM6xSQ=
=fW70
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
