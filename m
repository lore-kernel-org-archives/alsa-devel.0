From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: soc-cache: Add support for
 standard register caching
Date: Sat, 23 Oct 2010 19:24:14 +0100
Message-ID: <1287858254.9010.7.camel@dplaptop>
References: <1287757702-9573-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1287757702-9573-3-git-send-email-dp@opensource.wolfsonmicro.com>
	<20101022160351.GE16521@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7BD3B244B4
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Oct 2010 20:24:17 +0200 (CEST)
In-Reply-To: <20101022160351.GE16521@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam@alsa-project.org, Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-10-22 at 09:03 -0700, Mark Brown wrote:
> On Fri, Oct 22, 2010 at 03:28:20PM +0100, Dimitris Papastamos wrote:
> 
> > +static int snd_soc_cache_default_sync(struct snd_soc_codec *codec)
> > +{
> > +       const u8 *cache;
> > +       struct snd_soc_codec_driver *codec_drv;
> > +       unsigned int val;
> > 
> > +	codec_drv = codec->driver;
> > +	for (n = 0; n < codec_drv->reg_cache_size; ++n) {
> 
> Please use i as an array index unless using something meaningful.
> 
> > +                       if (!memcmp(&val, cache, codec_drv->reg_word_size))
> > +                               continue;
> 
> This memcmp() looks very suspicious - we're copying from an unsigned int
> into a variable of another type.  That seems to have a bit of an
> endianness assumption, doesn't it?  It certainly needs comments
> explaining how it works; a similar thing applies to the other memcpy()
> and memcmp() operations in the code.

Consider the following example. (unsigned int is 4 bytes).

unsigned int old = 0xABCD, new = 0;
void *p;

On a little-endian system this will be stored in memory as DCBA with D
being at a lower address.  Now consider the following code.

p = &old;
memcpy(&new, p, sizeof (unsigned int));

Now the value of new will be 0xABCD (stored in memory as DCBA again).
This holds both on a little-endian system as well as a big-endian
system.

The only problem I see with the above code, is when
codec_drv->reg_word_size > sizeof (unsigned int) but that can't really
happen in practice.

Thanks,
Dimitrios
