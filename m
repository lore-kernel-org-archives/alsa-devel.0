From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Subject: Hoontech STDSP24 - why is AC97 only mono?
Date: Mon, 8 Jul 2002 16:23:39 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207081621530.21289-100000@pc40.e18.physik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

With alsa-driver 0.9.0rc2 everything works with my soundcard, except for
the input to the AC97 mixer. I can set the output volumes independently
(changing the balance), but the music comes out only mono, either via the
digital link from the professional mixer or directly as PCM via hw:0,2. Is
this normal? What should I find in /proc/asound/card0 to explain this?

Another feature of ALSA is that I now have 6 AC97 devices (instead of 1
under M$), and there is a very obvious difference in sound quality between
hw:0,2,0 and the other five, in the sense that the first one is barely
usable. So, I can use the other under Linux, giving me a much better sound
experience :-))

Can someone comment on these issues?

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Oh, it's good to be a geek.
http://thinkgeek.com/sf
