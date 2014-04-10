From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] ASoC: core: Fix Sparse incompatible types warning
Date: Thu, 10 Apr 2014 04:01:50 +0100
Message-ID: <20140410030150.GC18016@ZenIV.linux.org.uk>
References: <1397028108-10976-1-git-send-email-k.kozlowski@samsung.com>
 <5345279F.6070005@metafoo.de>
 <1397041934.11424.2.camel@AMDC1943>
 <53452F67.3060400@metafoo.de>
 <20140409202520.GQ6518@sirena.org.uk>
 <5345AD8B.5050306@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5345AD8B.5050306@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 09, 2014 at 10:28:59PM +0200, Lars-Peter Clausen wrote:

> I had a look at the sparse code and the problem is that it sets the
> default return type of sizeof according to the type of the host it
> was compiled on (either unsigned int or unsigned long). It can be
> overwritten by switches like -m32, but of course wont work when
> cross compiling. So if your host system is 64bit, but your target
> system is 32bit you'll get that warning.

Not that simple.  First of all, you *need* to tell sparse what target
to expect; size_t is the least of your troubles - sizeof(long) has
far more widespread impact.  If you don't get -m64 or -m32 in CFLAGS
(and on quite a few cross-builds you get it, simply because the target
is biarch and gcc itself needs to know what to generate), you need
to set it in CHECKFLAGS, along with other target-specific things.
Example:
arch/ia64/Makefile:21:CHECKFLAGS        += -m64 -D__ia64=1 -D__ia64__=1 -D_LP64 -D__LP64__

With the defaults being what they are (since commit 7aa79f "Adding default for
m64/m32 handle"), we probably need explicit -m32 in CHECKFLAGS for a bunch
of 32bit targets.  Defaults are iffy, BTW - it's not even "do as host does",
it's "64bit if the host is amd64, 32bit otherwise" ;-/

Again, CHECKFLAGS need to be set; that's normally done in arch/*/Makefile.
