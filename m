From: Sebastian Kuzminsky <seb.kuzminsky@gmail.com>
Subject: Should dmix really work this way?
Date: Thu, 6 Oct 2005 21:29:18 -0600
Message-ID: <7f55de720510062029i3ef469r8a98686fa63773d@mail.gmail.com>
Reply-To: Sebastian Kuzminsky <seb.kuzminsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

It seems like there's one dmix "context" per system, not per playback devic=
e.

If I run "aplay -D plug:dmix:0 zero.wav", it comes out the speakers
for card 0, as expected.  If I kill that and then run "aplay -D
plug:dmix:1 one.wav", it comes out the speakers for card 1, as
expected.  But if I leave that running and run the first command
again, zero.wav comes out card 1 (mixed together with one.wav).

If I play via dmix to card 0 first, then try to dmix something else to
card 1, the second sound comes out card 0 too.  Which ever dmix starts
first determines where all the subsequent dmix sounds go.

Is this how it's supposed to work, or am I just being a retard and
doing something wrong?

I'm using ALSA 1.0.9 with Debian Etch/Sid, FWIW.


--
Sebastian Kuzminsky


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
