From: Nicolas Pitre <nico@cam.org>
Subject: Re: Is there a way to support ALSA on ARM9 with Linux
 2.6.10?
Date: Fri, 03 Feb 2006 09:51:16 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602030948140.5397@localhost.localdomain>
References: <2fd842840602030258k6813e5a6t2e4ca79caf465630@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <2fd842840602030258k6813e5a6t2e4ca79caf465630@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kawshol sharma <kawshol@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 3 Feb 2006, Kawshol sharma wrote:

> HI
> 
> I hear a lot about ALSA is not supported for the ARM Linux. Is it true
> and why is that?

It is not true.

> I use 2.6.10 or Arm926 and wish to switch over to ALSA. The reason I
> get from the people that the ABI of ARM is not compatible to the ALSA.

That's a totally different problem for which ALSA is not the cause at 
all.  ALSA works perfectly fine when _both_ the kernel and user space 
use the same ABI.

> I do not understand what that means?

You probably have a mixed ABI environment.

> Is there a way to support ALSA on ARM9 with Linux 2.6.10?

Depends if you actually have an ALSA driver for your audio device.


Nicolas


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
