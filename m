From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH] Driver core: Don't ignore error returns
 from probing
Date: Mon, 9 Oct 2006 13:10:12 +0200
Message-ID: <20061009131012.3ba21242__34037.7760622234$1160392562$gmane$org@gondolin.boeblingen.de.ibm.com>
References: <20061006131443.473c203c@gondolin.boeblingen.de.ibm.com>
	<Pine.LNX.4.44L0.0610061400180.1311-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E54FB171
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Oct 2006 13:10:25 +0200 (MEST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id k99BANtj016628
	for <alsa-devel@alsa-project.org>; Mon, 9 Oct 2006 11:10:23 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k99BCeoP2785510
	for <alsa-devel@alsa-project.org>; Mon, 9 Oct 2006 13:12:40 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k99B9bUl020431
	for <alsa-devel@alsa-project.org>; Mon, 9 Oct 2006 13:09:37 +0200
In-Reply-To: <Pine.LNX.4.44L0.0610061400180.1311-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>, Castet Matthieu <castet.matthieu@free.fr>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On Fri, 6 Oct 2006 14:12:49 -0400 (EDT),
Alan Stern <stern@rowland.harvard.edu> wrote:

> I'm still not sure why bus_attach_device() was split off from 
> bus_add_device() in the first place.  Was it just so that the 
> kobject_uevent() call could go in between?

I think yes. This was added in
http://marc.theaimsgroup.com/?l=linux-kernel&m=115092084915731&w=2

> This looks okay, but it would be better if bus_remove_device() did not
> directly call bus_delete_device().  Just add an extra call inside
> device_del(), so that everything remains symmetrical.
> 
> While I'm harping on style issues, you should also capitalize AttachError
> so that it matches the form of the other statement labels nearby.  And in
> bus_remove_device() you should put all the code inside the "if" block
> instead of returning when dev->bus isn't set, just as the neighboring
> subroutines do.

OK, new patch on the way.

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
