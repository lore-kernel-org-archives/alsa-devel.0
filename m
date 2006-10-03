From: Remy Bruno <remy.bruno@trinnov.com>
Subject: RME 9632
Date: Tue, 3 Oct 2006 12:37:12 +0200
Message-ID: <20061003103712.GA12508@trinnov.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
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

Hello,

I'm having a strange problem with an RME HDSP 9632 card I recently bought. I've
contacted RME, but would like to know if somebody here is having the same
problem, or if there is a known issue about this (and if possible, a
workaround).

Start of the story: a couple of monthes ago (let's say about one year, but I'm
not sure of the time-scale), I got a RME HDSP 9632. Alsa driver was working
perfectly, I got the 12 I/O (16 with the additionnal add-on cards), the mixer
matrix worked as expected (mixer params = src,dest,32768 with src=dest+16 for
sending playback channels to audio outputs). After an hardware problem with the
card (I plugged the analog add-on card while it was running, which burned the
card!), I had to get a new one. I didn't manage to get this new card work, so I
suspected a specific problem with this new card. More recently (one week ago),
I needed to use an RME9632, so I got a new one, and I'm having about the same
problem than with the 2nd one:
- card does not work in master. Everything is as if it ran at 24kHz (sound
  plays slowly), even if the card pretends to run at the desired sample rate
  (say 44.1 or 48kHz). So master mode is unusable.
  Master worked with the 1st card.
- in slave, it seems to be more or less OK, but the matrix behavior is
  extremely weird. For sending playback channels 9,10,11,12 on outputs
  9,10,11,12 (SPDIF & analog), I need to put the value 32768 in the following
  coefficients: (62, 4), (1, 6), (24, 6), (15, 7)
  With the first (now dead) card, I used the normal following matrix
  coefficients: (24,8) (25,9), (26, 10), (27, 11)

Any idea?

Thanks

Remy


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
