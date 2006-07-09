From: Eliot Blennerhassett <linux@blennerhassett.gen.nz>
Subject: Re: build failures in asihpi (was: ALSA 1.0.12rc1
	release)
Date: Mon, 10 Jul 2006 10:21:35 +1200
Message-ID: <200607101021.35954.linux@blennerhassett.gen.nz>
References: <Pine.LNX.4.61.0606231231370.10283@tm8103-a.perex-int.cz>
	<200607022100.58844.linux@blennerhassett.gen.nz>
	<20060702123404.GI5158@neu.nirvana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060702123404.GI5158@neu.nirvana>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net, ALSA development <alsa-devel@alsa-project.org>, ATrpms development list <atrpms-devel@ATrpms.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 03 Jul 2006 00:34, Axel Thimm wrote:
> On Sun, Jul 02, 2006 at 09:00:58PM +1200, Eliot Blennerhassett wrote:
> > On Sun, 02 Jul 2006 11:17, Axel Thimm wrote:
> > > I'm having troubles compiling this on x86_64 distributions (from
> > > 2.6.10 to 2.6.17 based kernels). The build fails on asihpi...
> >
> > Currently asihpi does not support x86_64.     Sorry.
> >
> > The Kconfig for asihpi does say:
> > depends on SND && X86 && !X86_64
> > (hmm, perhaps the ordinary make system doesn't know about this)
>
> You mean asihpi uses some next generation Kconfig?

No, just ordinary Kconfig.

> So how do I turn asihpi off?

AFAIK the "depends on SND && X86 && !X86_64"  should result in asihpi not 
being built on x86_64.   Have you figured out why this doesn't work?

CS5535 driver in alsa-kernel has the same depends - does it work (i.e. driver 
is not built)?

I'm not sure what the problem with asihpi is, but the short term answer is to 
fix the Kconfig or other part of build system to force it not to be built for 
X86_64.

-- Eliot






-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
