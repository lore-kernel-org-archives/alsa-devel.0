From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB fix
Date: Tue, 11 Mar 2003 15:50:40 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0303111528540.29925-100000@studcom.urz.uni-halle.de>
References: <20030311114251.GA17514@nubol.int.oskuro.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20030311114251.GA17514@nubol.int.oskuro.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jordi Mallach <jordi@debian.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jordi Mallach wrote:
> any comment on the last "stacatto" bug I reported after the big
> report?

I couldn't reproduce it on my machine (current CVS instead of 0.9.0beta8,
2.4.18 instead of 2.4.2, Roland Sound Canvas connected with USB instead of
SB MIDI port).

I have noticed that calling SNDCTL_SEQ_RESET (as well as close()ing the
handle to /dev/music) sends "all notes off", "controller reset" and
pitch-bend messages to all channels on all ports, but that should result
in a delay of at most 40ms before the first note, and not in a timing
problem at a later note.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
