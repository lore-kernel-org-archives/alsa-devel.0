From: Eliot Blennerhassett <linux@blennerhassett.gen.nz>
Subject: Re: build failures in asihpi (was: ALSA 1.0.12rc1
	release)
Date: Sun, 2 Jul 2006 21:00:58 +1200
Message-ID: <200607022100.58844.linux@blennerhassett.gen.nz>
References: <Pine.LNX.4.61.0606231231370.10283@tm8103-a.perex-int.cz>
	<20060701231759.GQ24584@neu.nirvana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060701231759.GQ24584@neu.nirvana>
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
To: alsa-devel@lists.sourceforge.net, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 02 Jul 2006 11:17, Axel Thimm wrote:
> Hi,
>
> I'm having troubles compiling this on x86_64 distributions (from
> 2.6.10 to 2.6.17 based kernels). The build fails on asihpi...

Currently asihpi does not support x86_64.     Sorry.

The Kconfig for asihpi does say:
depends on SND && X86 && !X86_64
(hmm, perhaps the ordinary make system doesn't know about this)

Our next HPI release will be the first to support 64 bit, and we expect ALSA 
support will follow shortly after that.

-- Eliot Blennerhassett
AudioScience Inc.


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
