From: Graham Stoney <greyhams@optusnet.com.au>
Subject: Re: Problems building latest cvs snapshot
Date: Sun, 11 Aug 2002 13:27:07 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020811032707.GC4844@optusnet.com.au>
References: <20020811025240.GB4844@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20020811025240.GB4844@optusnet.com.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 11, 2002 at 12:52:40PM +1000, I wrote:
[ Foolishness deleted ]

I've just found the "Compilation from CVS Sources" instructions in INSTALL, 
which answered my previous question. I did _try_ to RTFM before asking, honest!

Anyway, next problem is an include file dependency problem: include/adriver.h
is looking for "isapnp.h", which doesn't exist. I suspect the problem is the
#if conditionals surrounding it. I'm building against a 2.2.19 kernel, which
has an isapnp.h, but linux/autoconf.h doesn't define CONFIG_ISAPNP_KERNEL.

Any ideas?

Thanks,
Graham


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
