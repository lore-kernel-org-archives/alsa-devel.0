From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: RME installation problems
Date: Wed, 12 Feb 2003 19:30:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030212183033.GD3093@finnendahl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Simon de Bakker <sim@z2.v2.nl>
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm trying to install a brandnew RME pci/multiface combination on a
Athlon computer with Debian/Woody. I have my own RME/pci combination
at home running well but on the new computer I get complaints on
modprobing the snd-hdsp that no cards are found.

snd-hammerfall-mem insmods without errors (reporting it allocated
memory for 1 card).

Using the older alsa driver which works on my machine at home didn't
help. The card is detected with lspci and uses irq 12 not sharing it
with something else.

I read on other lists that RME uses a different firmware now. Could
that be related to the problem or is the problem clearly related to a
wrong system configuration?

Please answer even if you can't hear those "I can't get ... running"
anymore as it is used in a rather big installation in Rotterdam two
weeks from now.

Let me know if you need any logs to track down the problem.

--
Orm


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
