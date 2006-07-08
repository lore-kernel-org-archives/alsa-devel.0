From: Jeff Garzik <jeff@garzik.org>
Subject: Re: OSS driver removal, 2nd round (v2)
Date: Fri, 07 Jul 2006 21:30:47 -0400
Message-ID: <44AF0AC7.30204__595.468833535229$1152432964$gmane$org@garzik.org>
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1297E26D
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Jul 2006 10:14:31 +0200 (MEST)
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	A1AB39997C for <alsa-devel@alsa-project.org>;
	Sat,  8 Jul 2006 03:34:26 +0200 (MEST)
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
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Andi Kleen wrote:
> Adrian Bunk <bunk@stusta.de> writes:
>> Q: What about the OSS emulation in ALSA?
>> A: The OSS emulation in ALSA is not affected by my patches
>>    (and it's not in any way scheduled for removal).
> 
> I again object to removing the old ICH sound driver.
> It does the same as the Alsa driver in much less code and is ideal
> for generic monolithic kernels

Well, consensus seems to be with ALSA, OSS API is dated for modern uses, 
old ICH driver doesn't use the HD audio found on modern chips, and 
nobody is eagerly stepping forward to maintain the driver.

	Jeff





-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
