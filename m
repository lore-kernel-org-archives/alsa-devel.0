From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: linux-next: Tree for Oct 12 (sound/soc/codecs/wm1250-ev1)
Date: Wed, 12 Oct 2011 17:46:01 -0700
Message-ID: <4E9634C9.3020404@xenotime.net>
References: <20111012175425.a2e3e6e6a92265e433aeca25@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20111012175425.a2e3e6e6a92265e433aeca25@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 10/11/2011 11:54 PM, Stephen Rothwell wrote:
> Hi all,
> 
> The linux-next tree is now available from
> git://github.com/sfrothwell/linux-next.git as a temporary measure while
> the kernel.org servers are unavailable.
> 
> It may also turn up on git.kernel.org (depending on the mirroring).  The
> patch is still absent, however.


When no GPIO kconfig options are enabled:
(not GPIOLIB, not GENERIC_GPIO):

sound/soc/codecs/wm1250-ev1.c:32:14: error: array type has incomplete element type
sound/soc/codecs/wm1250-ev1.c:126:18: warning: type defaults to 'int' in type name
sound/soc/codecs/wm1250-ev1.c:126:18: warning: type defaults to 'int' in type name
sound/soc/codecs/wm1250-ev1.c:126:18: error: negative width in bit-field '<anonymous>'
sound/soc/codecs/wm1250-ev1.c:134:42: warning: type defaults to 'int' in type name
sound/soc/codecs/wm1250-ev1.c:134:42: warning: type defaults to 'int' in type name
sound/soc/codecs/wm1250-ev1.c:134:42: error: negative width in bit-field '<anonymous>'
sound/soc/codecs/wm1250-ev1.c:155:34: warning: type defaults to 'int' in type name
sound/soc/codecs/wm1250-ev1.c:155:34: warning: type defaults to 'int' in type name
sound/soc/codecs/wm1250-ev1.c:155:34: error: negative width in bit-field '<anonymous>'


This was on an i386 build, but that shouldn't matter.

-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
