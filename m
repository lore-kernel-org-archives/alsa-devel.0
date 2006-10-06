From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [PATCH] RFC - add prealloc_max proc file
Date: Fri, 06 Oct 2006 11:15:04 +0200
Message-ID: <1160126104.8856.272696626@webmail.messagingengine.com>
References: <Pine.LNX.4.61.0610061026300.8573@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4DAF316F
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Oct 2006 11:15:05 +0200 (MEST)
Received: from frontend3.internal (frontend3.internal [10.202.2.152])
	by frontend1.messagingengine.com (Postfix) with ESMTP id AD309DB0271
	for <alsa-devel@alsa-project.org>; Fri,  6 Oct 2006 05:15:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0610061026300.8573@tm8103.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> I would like to propose to add prealloc_max proc file to give a 
> hint, what's the maximum allowed DMA buffer size in bytes:

You mean, users are not supposed to do a binary search with
the prealloc file?  ;-)

> ...

Looks good.


BTW: Shouldn't all(?) these proc files eventually go to sysfs?


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
