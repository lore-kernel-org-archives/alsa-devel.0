From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: can't build snd-sbawe with linux 2.5.64
Date: Sun, 9 Mar 2003 16:45:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030309154547.GA13678@rhlx01.fht-esslingen.de>
References: <E18quXj-00054v-00@sc8-sf-list2.sourceforge.net>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E18quXj-00054v-00@sc8-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Bob Ham <rah@bash.sh>
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, Mar 06, 2003 at 04:31:11AM -0800, alsa-devel-request@lists.sourceforge.net wrote:
> Message: 4
> From: Bob Ham <rah@bash.sh>
> To: alsa-devel@alsa-project.org
> Organization: 
> Date: 05 Mar 2003 22:52:42 +0000
> Subject: [Alsa-devel] can't build snd-sbawe with linux 2.5.64
> 
> 
> --=-HNWmD5omWsIoTMwcs8h/
> Content-Type: text/plain
> Content-Transfer-Encoding: 7bit
> 
> Hi,
> 
> I'm sorry to report that I've been unable to get alsa to build the
> snd-sbawe driver with 2.5.64.  Both the kernel's version and 0.9.0rc8
> fail.  I've attached the output of both build attempts.
Jut wanted to mention that I also cannot build ALSA on 2.5.64.
Changing Makefile.conf.in to have
INCLUDE         = -I$(TOPDIR)/include @EXTRA_INCLUDES@ -I$(CONFIG_SND_KERNELDIR)/include -I$(CONFIG_SND_KERNELDIR)/include/asm/mach-default
works for the irq_vectors.h problem (and it might even be a semi-complete
fix, given the various postings floating around).
But then I'm greeted with a failure to include <linux/modversions.h>.
That's because 2.5.x doesn't have <linux/modversions.h> any more.
It only has <config/modversions.h> left.

In short, building on 2.5.x is a mess and should be fixed ;)

I'd try to fix it, but then I suck at autoconf stuff etc. and really don't
know how to adapt it to the new modules handling, so I choose to shut up
for now.

Any idea?

Oh well, back to oooldish kernel modules, then...

-- 
Help prevent Information Technology Fascism! - before it's too late...
http://www.againsttcpa.com


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
