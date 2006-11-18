From: Nicolas Boullis <nboullis@debian.org>
Subject: Where is /usr/share/alsa/cards/?
Date: Sat, 18 Nov 2006 22:07:37 +0100
Message-ID: <20061118210734.GE9190@home>
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

Hi,

I'm working on a driver for some hardware MPEG decompression boards, 
with an ALSA driver for the audio part of the chip. For a good support 
with most applications, I need a special configuration for this driver, 
that would be in /usr/share/alsa/cards/EM8300.conf.

Unfortunately, this location varies with the distros. I heard that it 
was somewhere in /etc for RedHat and Fedora. Moreover, alsa-lib maight 
be installed by some user in their home directory.

That's why I'd like to know if there is some programmatic way to find 
out where I should install my configuration. Any idea?

If there is none, I guess I could default to installing in 
/usr/share/alsa/cards and let the user specify another location through 
my ./configure script if needed.


Cheers,

Nicolas

PS: I'm not subscribed so please reply to me directly (M-F-T header set 
accordingly).

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
