From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: building jack
Date: Sun, 20 Apr 2003 17:23:44 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030420172344.2d10e4af.mista.tapas@gmx.net>
References: <20030420151813.GA20213@nubol.int.oskuro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030420151813.GA20213@nubol.int.oskuro.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 20 Apr 2003 17:18:13 +0200
Jordi Mallach <jordi@debian.org> wrote:

> Hello,
> 
> I've tried to build the jack plugin for alsa-lib, but I can't. Both in
> CVS and 0.9.2, jack.h appears to be missing and the compile fails.
> 
> gcc -DHAVE_CONFIG_H -I. -I. -I../../../include -I../../../include
> -I../../../src/pcm -O2 -Wall -W -pipe -g -MT pcm_jack.lo -MD -MP -MF
> .deps/pcm_jack.Tpo -c pcm_jack.c  -fPIC -DPIC -o pcm_jack.lo
> pcm_jack.c:36:23: jack/jack.h: No such file or directory
> pcm_jack.c:68: syntax error before "jack_port_t" pcm_jack.c:68:
> warning: no semicolon at end of struct or union pcm_jack.c:69:
> warning: type defaults to `int' in declaration of `client'
> pcm_jack.c:69: warning: data definition has no type or storage
> class[...]

You are missing the jack header files.

install the jackd-dev package. If you compiled from source, make sure,
the jack headers are in a standard location (though i suppose the
./configure script for jack should care for that)..

Florian Schmidt

-- 
mista.tapas@gmx.net
sound clips - http://www.arted.biz/mista.tapas


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
