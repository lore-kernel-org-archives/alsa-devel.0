From: Shaju Abraham <shaju@multitech.co.in>
Subject: Use less number of BDs in i810
Date: Wed, 07 Aug 2002 12:54:23 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D50CB27.43CC7EA9@multitech.co.in>
References: <Pine.LNX.4.44.0208051300450.12882-100000@sasami.anime.net> <3D4F9330.3070100@boosthardware.com> <20020806144804.A20615@thot.informatik.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi all,
         I suppose that present implementation of i810 driver uses 32 BDs.  Can
u pls direct me how to reduce this number to say only 16 or 8 BDs.

Also, now if the number of frags I am getting is 8, size of each frag I am
getting is 4456 bytes.  I have two questions regarding this.

1.         How can I force the fragment size to be  abt 1k or 2k bytes?

2.         Is it strange that this number is not a multiple of 512 bytes?  ( I
am getting physize of 35648 bytes.  not 32K ? )

Thanx in advance,
Shaju Abraham



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
