From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] fix AB-BA deadlock inversion at
	cs46xx_dsp_remove_scb
Date: Tue, 4 Jul 2006 11:58:59 +0200
Message-ID: <20060704095859.GA22458@elte.hu>
References: <200607041115.35997.duncan.sands@math.u-psud.fr>
	<1152005720.3109.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F3EB01A7
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Jul 2006 12:03:38 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <1152005720.3109.30.camel@laptopd505.fenrus.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, Duncan Sands <duncan.sands@math.u-psud.fr>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> which is an obvious AB-BA deadlock
> 
> fix is to just take the lock with _irqsafe
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
