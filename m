From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: alsa driver problem
Date: Fri, 12 Jan 2007 14:23:53 +0000
Message-ID: <1168611833.10120.36.camel@localhost.localdomain>
References: <00e101c73622$7e988060$0e96a8c0@Thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <00e101c73622$7e988060$0e96a8c0@Thomas>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "thomas.luo" <thomas.luo@ieee.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-01-12 at 16:06 +0800, thomas.luo wrote:

> 
> when i force the avail_min to 4096, the whole system work well.
> who can tell me any idea?

This may be related to a compiler optimisation bug for ARM that caused
PCM refinement to fail.

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=27363

More info can be found by searching the archives.

Liam


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
