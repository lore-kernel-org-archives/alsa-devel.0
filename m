From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: alsa driver problem
Date: Mon, 15 Jan 2007 20:35:04 +0000
Message-ID: <1168893304.31173.9.camel@localhost.localdomain>
References: <00e101c73622$7e988060$0e96a8c0@Thomas>
	<1168611833.10120.36.camel@localhost.localdomain>
	<009201c7383f$d1cfcc60$0a01000a@Thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <009201c7383f$d1cfcc60$0a01000a@Thomas>
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

On Mon, 2007-01-15 at 08:55 +0800, thomas.luo wrote:

>  i have apply this patch, but it is same. this is my code in the aplay.

Iirc, you need to rebuild your kernel and alsa-lib before the
optimisation issue goes away. If this doesn't help, then it looks like
your issue is caused by something else.

Liam



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
