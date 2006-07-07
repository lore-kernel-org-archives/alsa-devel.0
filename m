From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: snd-aoa: g5 tas codec problems
Date: Fri, 07 Jul 2006 18:56:25 +1000
Message-ID: <1152262585.9862.61.camel@localhost.localdomain>
References: <1152258426.9862.44.camel@localhost.localdomain>
	<1152262148.15068.30.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 63B4C245
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 10:56:32 +0200 (MEST)
In-Reply-To: <1152262148.15068.30.camel@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-07-07 at 10:49 +0200, Johannes Berg wrote:
> On Fri, 2006-07-07 at 17:47 +1000, Benjamin Herrenschmidt wrote:
> > Also, we should try
> > (if not already the case) to cache our clock/i2s state so that
> > subsequent prepare() don't try to change things that are already ok. 
> 
> I do that, the function reads the dws and sfr registers and exits early
> if they match.

Ok. Be careful that I've removed the initial init of TAS thinking we
always get to clock restart to do it in prepare()... might need to be
put back.

Ben.



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
