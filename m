From: Robert Joop <rj@rainbow.in-berlin.de>
Subject: help needed for my AD1816A based soundcard
Date: Sat, 30 Mar 2002 00:04:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020329230421.GD707@rainbow.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

alsa's ad1816a driver doesn't find my card.
i've ISAPNP turned on.
the card is a Highscreen Sound-Boostar 32 Wave 3D, it doesn't seem to
have an entry in card-ad1816a.c.
the entries in snd_ad1816a_pnpids[] look rather esoteric and i haven't
found any documentation on adding an entry.
how do i collect the necessary information?
is it sufficient just adding an entry to the array?

the card has an AD1816A and two DSP chips on it.

(btw, with kernel 2.2.x's sb driver the card worked, but 2.4.18's sb it
hangs the computer.
and kernel 2.4.18's ad1816 driver doesn't detect the card either.)

rj
