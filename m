From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Breakage in alsa-driver/include/adriver.h on CVS
Date: Thu, 3 Oct 2002 09:20:18 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210030920080.521-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0210021726190.12070-100000@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0210021726190.12070-100000@marabou.research.att.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Pavel Roskin <proski@gnu.org>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2 Oct 2002, Pavel Roskin wrote:

> Hello!
> 
> ALSA on CVS doesn't compile.  alsa-driver/include/adriver.h has several 
> problems:
> 
> /usr/local/src/alsa/alsa-driver/include/adriver.h:186: parse error before 
> `dir'
> /usr/local/src/alsa/alsa-driver/include/adriver.h:188: multiple storage 
> classes in declaration of `devfs_find_and_unregister'
> /usr/local/src/alsa/alsa-driver/include/adriver.h:188: warning: function 
> declaration isn't a prototype
> 
> I'm using devfs, and the first error can be fixed by adding this code
> above in the header:
> 
> #ifdef CONFIG_DEVFS_FS
> #include <linux/devfs_fs_kernel.h>
> #endif
> 
> "multiple storage classes" is apparently "extern" and "static" in the same 
> declaration.
> 
> "function declaration isn't a prototype" - there should not be any
> semicolon between `)' and `{'.
> 
> On the positive side, I appreciate the work on eliminating acconfig.h 

Fixed. Thanks for this report.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
