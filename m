From: Martin Langer <martin-langer@gmx.de>
Subject: full-duplex - is it possible with rme32?
Date: Thu, 2 May 2002 23:44:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020502214400.GA2888@localhost>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


Hi,

the RME Digi 32 in half-duplex is working so far, but I don't see a solution
for a full-duplex support, because this card is working with one buffer for
recording and playing.

A driver should write the playing data and read the recording data in one
cycle at the same address. There is no way to separate play/rec. It's just
working in a synchronized way: first get the rec-data and then overwrite it
with play-data, cycle for cycle,...

Can I manage it with alsa? I don't think so, but I'm new here and not so
familiar with alsa.

Any Ideas? Is there another module, which works similar?
Or: Sorry, that's not full-alsa-duplex!


thanks,
martin


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
