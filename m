From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [alsa-cvslog] alsa-kernel: snd-emu10k1: Add
	support for	EMU1212m card.
Date: Tue, 11 Jul 2006 18:28:48 -0400
Message-ID: <1152656929.21909.100.camel@mindpipe>
References: <ALOGGER1152655949.31@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <ALOGGER1152655949.31@alsa-project.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-07-12 at 00:12 +0200, James Courtier-Dutton wrote:
> +const static unsigned char emu1212m_netlist1[] = {
> +0xFF, 0xFF, 0xFF, 0xFF, 0x55, 0x99, 0xAA, 0x66,
> +0x0C, 0x00, 0x01, 0x80, 0x00, 0x00, 0x00, 0xE0,
> +0x0C, 0x80, 0x06, 0x80, 0x00, 0x00, 0x00, 0xD0,

[ etc ]

You're going to bloat everyone's emu10k1 driver with this gigantic
structure?  Can't you use the firmware loading interface?  The kernel
guys will flip when they see this.

Lee



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
