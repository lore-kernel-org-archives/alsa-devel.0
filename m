From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Register cache different from the real register
 values
Date: Sun, 23 Oct 2011 16:37:54 +0200
Message-ID: <20111023143754.GB23045@opensource.wolfsonmicro.com>
References: <CALq1K=+fT5dtKY7JZSOn01FpdZ7yhHhCWigjWVVuUxcucShx8w@mail.gmail.com>
	<20111023135118.GA17387@sirena.org.uk>
	<CALq1K=Lg=JGzGeuK04hVsC9iME=Q8Exv0N5nfcKWuYWFN4as5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DBC812472D
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Oct 2011 16:37:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CALq1K=Lg=JGzGeuK04hVsC9iME=Q8Exv0N5nfcKWuYWFN4as5g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 23, 2011 at 04:14:07PM +0200, Leon Romanovsky wrote:
> On Sun, Oct 23, 2011 at 15:51, Mark Brown

> > Post your code for review and we
> > might be able to spot something.

> Our code is located at
> http://gitorious.org/~marvin24/ac100/marvin24s-kernel/blobs/chromeos-ac10=
0-2.6.38/sound/soc/codecs/alc5632.c

Please post for upstream, it's much easier to review and ideally we
could even get the driver merged.

> > =A0At a guess you're doing cache_only and
> > something's going wrong there
> I also tried to add codec->cache_sync =3D 1 to the _probe function, but
> without luck.
> http://gitorious.org/~marvin24/ac100/marvin24s-kernel/blobs/chromeos-ac10=
0-2.6.38/sound/soc/codecs/alc5632.c#line998

You should only set cache_sync if you dirty the cache and then you need
to call cache_sync() at some point to actually sync the cache.

> > the register defaults are wrong or the

> Our style is a little different, because it is a port from the
> android, we will be change it later, before merging into the mainline
> to be more convenient.
> http://gitorious.org/~marvin24/ac100/marvin24s-kernel/blobs/chromeos-ac10=
0-2.6.38/sound/soc/codecs/alc5632.c#line1023

Android is using the same kernel - there's no differences introduced by
Android here.  If you're seeing differences they're driver quality
issues (probably caused by not being mainline).  =


Looking briefly at the code that android_init() function is just broken
and should be removed, any missing control should be implemented in the
driver.  The fill_cache() function looks suspect also - in general all
the code peering directly into the register cache data structure smells
bad.  You should have register defaults hard coded into the driver which
reflect the chip defaults so when we reset we know that's where the chip
is at.

Another thing to check is that the registers in the chip aren't
volatile, if the chip can change register values underneath the driver
then obviously things might get confused.  Multiple copies of the same
control are a common culprit.
