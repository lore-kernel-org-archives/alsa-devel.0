From: Matt Porter <mporter@embeddedalley.com>
Subject: Re: [PATCH] hda: add sigmatel dig mic support and
	refactor 9227
Date: Wed, 25 Oct 2006 17:41:23 -0400
Message-ID: <20061025214123.GD545@matthew-porters-computer.local>
References: <20061025202110.GA351@matthew-porters-computer.local>
	<1161809636.18211.65.camel@razman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from oh.embeddedalley.com (cpe-088197.static.wadsnet.net
	[65.114.88.197])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 932411A9
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Oct 2006 23:41:27 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <1161809636.18211.65.camel@razman>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Tobin Davis <tdavis@dsl-only.net>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 25, 2006 at 01:53:56PM -0700, Tobin Davis wrote:
> Couple of things, which version is this against?  I tried patching
> against the tip and all areas were rejected.
 
Hrm, interesting. I pulled and update my hg tree. I'll take a look.

> Also, the original 9227 and 927x code was written specifically for Intel
> D965 board support.  The information I had was from the Stac 9227
> developers reference and several systems I was working with at the time
> (I was a contractor at Intel).  From what I can tell, your patch removes

Actually, the core code wasn't written specifically for the D965
support. I wrote and submitted support for the 927x code against
the sigmatel reference codec board before these patches for D965
got in. The 927x support was committed 23 Jan 2006, 9227/8/9 codec
support via the 927x patch path was committed 06 July 2006. Those
are the portions I authored. It looks like the D965/9227 specific
support showed up on 22 Aug 2006. All according to the hg logs.

> the 3stack configuration and replaces it with the ref config, which
> could break the 3-stack systems.  Has this patch been tested on these
> systems?

This patch does no such thing. The reason i say "refactor" is that
it properly separates 927x and 9227 codecs. They are different. The
Intel patch just hacked in D965 support for the 9227 using the
927x path. If you look closely, this patch moves all of those 9227-based
D965 systems over to the 9227 table leaving the 927x table with just
the reference board.  This is needed because the pin widgets on the
9227 and 927x differ in some ways including the digital mic pin
widget nids.

-Matt

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
