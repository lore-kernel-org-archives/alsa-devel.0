From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [RFC] alsa integer control ranges
Date: Tue, 16 May 2006 18:04:39 -0400
Message-ID: <1147817080.13948.160.camel__9588.93369320339$1147817407$gmane$org@mindpipe>
References: <1147780945.29795.110.camel@johannes>
	 <1147816857.6753.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 7B4AE23A
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 00:04:42 +0200 (MEST)
In-Reply-To: <1147816857.6753.1.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, ALSA development <alsa-devel@alsa-project.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Benjamin Berg <benjamin@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-05-17 at 08:00 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2006-05-16 at 14:02 +0200, Johannes Berg wrote:
> > Apparently all alsa userspace programs including alsamixer suck. Hence,
> > this patch is required to make them work properly. Why is it so hard to
> > do these additions/subtractions in the program or maybe even in the alsa
> > library? The alsa libraries already think they know better and mess up
> > all kinds of things.
> 
> alsamixer works for me with negative ranges... but all other apps don't
> and there are various bugs, I blame apps converted from OSS....

kmix is the worst by far, someone really needs to fix it.  It has so
many bugs that it's unusable for debugging ALSA, we have to tell people
to use alsamixer.

Lee



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
