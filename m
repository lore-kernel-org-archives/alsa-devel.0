From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Problems with Hercules DJ Console and the
	usb-audio driver
Date: Wed, 14 Sep 2005 22:48:15 -0400
Message-ID: <1126752495.13893.120.camel@mindpipe>
References: <20050913140934.GA24953@nittionio.nu>
	 <Pine.HPX.4.33n.0509131756100.3875-100000@studcom.urz.uni-halle.de>
	 <20050914132346.GA18354@nittionio.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050914132346.GA18354@nittionio.nu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel Svensson <nano@nittionio.nu>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-09-14 at 15:23 +0200, Daniel Svensson wrote:
> On Tue, Sep 13, 2005 at 05:58:07PM +0200, Clemens Ladisch wrote:
> > What is the output of "amixer contents"?
> See the first mail in this thread.
> 
> > 28 = ENOSPC.  Please disable bandwidth checking in the kernel
> > configuration.  (This is a bug of your distribution unless you
> > compiled the kernel yourself.)
> 
> I use kernel 2.6.12-1-686, supplied by Debian. I'll forward your mail to
> the maintainer. Disabling CONFIG_USB_BANDWIDTH did the trick.

Make sure you report this to the Debian maintainers.  Enabling
CONFIG_USB_BANDWIDTH by default is a bug.

Lee



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
