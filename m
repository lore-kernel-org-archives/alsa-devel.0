From: Marc =?iso-8859-1?q?Lavall=E9e?= <marc@hacklava.net>
Subject: Fwd: Chaintech AV-710: only 6 outputs
Date: Sun, 27 Feb 2005 21:00:55 -0500
Message-ID: <200502272100.55214.marc@hacklava.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

I sent the following message to the alsa-users list, but nobody replied (ye=
t).=20
I suppose there's not much to fix in the ice1724 driver to fully support th=
e=20
Chaintech AV-710. Since I don't know the ALSA API, where should I start?=20
(appart from RTFM?) Thanks for your help!

=2D---------  Message transmis  ----------

Subject: Chaintech AV-710: only 6 outputs
Date: 26 F=E9vrier 2005 00:00
=46rom: Marc Lavall=E9e <marc@hacklava.net>
To: alsa-user@lists.sourceforge.net

I have a Chaintech AV-710. I'd like to use all its 8 outputs, but only 6 are
working. There's nothing in alsamixer for the last 2 outputs, and
"speaker-test -c 8" segfault on speaker 7... In qjackctl, output 7 and 8 are
showing, but nothing comes out if I connect alsaplayer to those outputs. Wh=
at
could be wrong? I use kernel 2.6.10 with ALSA 1.0.8. I don't understand very
well the  architecture of ALSA, so any useful information would be
appreciated.
=2D-
Marc

=2D------------------------------------------------------


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
