From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Calls from a custom dynamic shared library call
 the wrong version of alsa functions in libasound
Date: Thu, 11 Aug 2005 10:09:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0508111003190.8803@tm8103.perex-int.cz>
References: <42FAB657.2070307@thehoytfamily.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42FAB657.2070307@thehoytfamily.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Linux Coder <linux@thehoytfamily.com>
Cc: Alsa Developers <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 10 Aug 2005, Linux Coder wrote:

> g++ -fPIC -gstabs+ -O0 -Wall alibtest.cpp
> g++ -shared -Wl,-soname,libalibtest.so.1 -o libalibtest.so.1.0.1 alibtest.o
> -lc

Try add -lasound here, otherwise the linker won't add the necessary 
versions to external symbols.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
