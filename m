From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] alsa integer control ranges
Date: Wed, 17 May 2006 08:04:18 +1000
Message-ID: <1147817058.6753.7.camel__16724.8490885415$1147817135$gmane$org@localhost.localdomain>
References: <1147780945.29795.110.camel@johannes>
	 <Pine.LNX.4.61.0605161430220.9330@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DC50723A
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 00:04:23 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0605161430220.9330@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>, ALSA development <alsa-devel@alsa-project.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Benjamin Berg <benjamin@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-05-16 at 14:31 +0200, Jaroslav Kysela wrote:
> On Tue, 16 May 2006, Johannes Berg wrote:
> 
> > Apparently all alsa userspace programs including alsamixer suck. Hence,
> > this patch is required to make them work properly. Why is it so hard to
> > do these additions/subtractions in the program or maybe even in the alsa
> > library? The alsa libraries already think they know better and mess up
> > all kinds of things.
> 
> It's better to fix apps, if they are broken.

Problem is, they are currently all broken (pretty much) and thus unless
we want to release a driver that won't work with any current distros,
we'll have to whack the ranges :(

Ben.




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
