From: Andi Kleen <ak@suse.de>
Subject: Re: OSS driver removal, 2nd round (v2)
Date: 08 Jul 2006 01:50:00 +0200
Message-ID: <p737j2potzr.fsf__30262.4302720234$1152432886$gmane$org@verdi.suse.de>
References: <20060707231716.GE26941@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3AE7626A
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Jul 2006 10:14:07 +0200 (MEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	7887F998EB for <alsa-devel@alsa-project.org>;
	Sat,  8 Jul 2006 01:51:14 +0200 (MEST)
In-Reply-To: <20060707231716.GE26941@stusta.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Adrian Bunk <bunk@stusta.de>
Cc: alsa-devel@alsa-project.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, perex@suse.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Adrian Bunk <bunk@stusta.de> writes:
> 
> Q: What about the OSS emulation in ALSA?
> A: The OSS emulation in ALSA is not affected by my patches
>    (and it's not in any way scheduled for removal).

I again object to removing the old ICH sound driver.
It does the same as the Alsa driver in much less code and is ideal
for generic monolithic kernels

-Andi


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
