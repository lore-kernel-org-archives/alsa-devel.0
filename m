From: Uros Bizjak <uros@kss-loka.si>
Subject: [CFT][patch] OPL3 stuff
Date: Wed, 14 Aug 2002 17:23:06 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.05.10208141702260.2786-101000@pulsar.kss-loka.si>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="46228283-1161252105-1029338586=:2786"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
Cc: cladisch@users.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--46228283-1161252105-1029338586=:2786
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello!

  This patch is a rework of OPL3 chip detection (again...):

	- detects OPL3-L
	- detects OPL4 with by-the-book procedure. FM registers can not be
read in OPL4 mode (look at page 8 of OPL4 documentation)
	- changes messages to "OPLx ..."
	- enhances reported chip names with precise model types
	- removes WIP from OSS sequencer work

	Mostly trivial stuff, but OPL3-L and OPL4 detection is untested as
I don't have the hardware. Could anybody test it?

	BTW: If somebody is interested, "Lost and found" Yamaha OPL3x
documents could be found at 
http://www.fee.vutbr.cz/~arnost/opl/lost+found/

	OPL4 documents can be found at:
	http://www.kss-loka.si/~uros/opl4.pdf (application manual)
	http://www.kss-loka.si/~uros/ymf278b.pdf

	Uros.

--46228283-1161252105-1029338586=:2786
Content-Type: APPLICATION/octet-stream; name="opl3.diff.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.05.10208141723060.2786@pulsar.kss-loka.si>
Content-Description: 
Content-Disposition: attachment; filename="opl3.diff.gz"

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
z+J/ABiqiUr1GgAA
--46228283-1161252105-1029338586=:2786--


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
