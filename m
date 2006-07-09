From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: OSS driver removal, 2nd round (v2)
Date: Sun, 09 Jul 2006 11:18:19 -0400
Message-ID: <1152458300.28129.45.camel__28755.1220426851$1152524915$gmane$org@mindpipe>
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 43D5A23E
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Jul 2006 11:46:43 +0200 (MEST)
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by gate.perex.cz (Perex's E-mail Delivery System) with SMTP id
	6E10699920 for <alsa-devel@alsa-project.org>;
	Sun,  9 Jul 2006 17:17:57 +0200 (MEST)
In-Reply-To: <p737j2potzr.fsf@verdi.suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-07-08 at 01:50 +0200, Andi Kleen wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> > 
> > Q: What about the OSS emulation in ALSA?
> > A: The OSS emulation in ALSA is not affected by my patches
> >    (and it's not in any way scheduled for removal).
> 
> I again object to removing the old ICH sound driver.
> It does the same as the Alsa driver in much less code and is ideal
> for generic monolithic kernels

It doesn't do the same thing - software mixing is impossible with OSS.

Lee



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
