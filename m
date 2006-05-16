From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [RFC] alsa integer control ranges
Date: Tue, 16 May 2006 10:53:05 -0400
Message-ID: <1147791186.13948.109.camel@mindpipe>
References: <1147780945.29795.110.camel@johannes>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id E7964238
	for <alsa-devel@alsa-project.org>; Tue, 16 May 2006 16:53:10 +0200 (MEST)
In-Reply-To: <1147780945.29795.110.camel@johannes>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: ALSA development <alsa-devel@alsa-project.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Benjamin Berg <benjamin@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-05-16 at 14:02 +0200, Johannes Berg wrote:
> Apparently all alsa userspace programs including alsamixer suck. Hence,
> this patch is required to make them work properly. Why is it so hard to
> do these additions/subtractions in the program or maybe even in the alsa
> library? The alsa libraries already think they know better and mess up
> all kinds of things.
> 
> What are your opinions on this? Should this be required? And if so, why
> do we even have the value.integer.min when we can't use it anyway? 
> 
> The code this patch applies against is in
> http://johannes.sipsolutions.net/snd-aoa.git/ but that isn't all too
> relevant, the patch serves just as an illustration of what is wrong
> here.
> 

Ummm... what problem is this patch fixing?

Lee



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
