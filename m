From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 2/3] ASoC: dapm - Use card mutex for DAPM
 ops instead of codec mutex.
Date: Mon, 05 Mar 2012 14:48:02 +0000
Message-ID: <1330958882.4370.15.camel@odin>
References: <1330711872-27436-1-git-send-email-lrg@ti.com>
	<1330711872-27436-2-git-send-email-lrg@ti.com>
	<20120304140939.GH3083@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog126.obsmtp.com (na3sys009aog126.obsmtp.com
	[74.125.149.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 77DE41042C2
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 15:48:17 +0100 (CET)
Received: by mail-wi0-f179.google.com with SMTP id x18so1839596wia.24
	for <alsa-devel@alsa-project.org>; Mon, 05 Mar 2012 06:48:04 -0800 (PST)
In-Reply-To: <20120304140939.GH3083@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2012-03-04 at 14:09 +0000, Mark Brown wrote:
> On Fri, Mar 02, 2012 at 06:11:11PM +0000, Liam Girdwood wrote:
> 
> Thanks for looking at this stuff, it's needed attention for a long time
> but it's never been a practical problem and it's always depressed me too
> much every time I've thought about looking at it myself.
> 
> > This patch updates the DAPM operations that use the codec mutex to
> > now use the card mutex PCM subclass for all DAPM ops.
> 
> Hrm, this makes "PCM" look misnamed...  should we have a DAPM context,
> or perhaps even just a separate lock for DAPM?  If we can have a
> separate lock that'd be good, it's usually much simpler (at least for
> me) to reason about multiple locks interacting than nesting on the same
> lock but it's not always reasonable to split the locks, like with the
> PCM stuff calling back into itself.

A separate DAPM mutex and subclass (for init and PCM ops) would be
required here but I'm fine with that too. 

I do also need the card mutex changes for Dynamic PCM though since we
need to lock the card PCM operations for Dynamic PCM devices.

> 
> It looks like we're also missing a lock in snd_soc_dapm_sync() here, we
> need to lock that as well as the updaters otherwise we might change the
> lists underneath the DAPM run which doesn't work so well.  I might've
> missed that, though (and currently we're not exactly 100% on taking that
> lock when we should).  That's why snd_soc_jack_report() has the CODEC
> mutex for example.
> 

Yeah, we are missing one or two - looking through that now. Some of the
DAPM init functions also need locking here too.

> We'll also need to make sure the locking for the register I/O is sorted,
> it's OK for the devices using regmap as that locks for us but currently
> anything using the ASoC level cache relies on the CODEC mutex being held
> for register I/O.  This isn't quite so risky as it was when we had the
> advanced caches since the data structure is just a plain array but
> writes may still go AWOL and that'd be a nightmare to debug.  I'm
> worrying that right now something is relying on the fact that DAPM takes
> the CODEC mutex to protect it.  But probably it's OK to fix that up
> separately I think, we've got plenty of problems there and either
> killing all the ASoC level caches or adding a new lock at the cache
> level seem like the way to go both of which are basically orthogonal to
> what's going on here.

Agree, adding a new cache lock is best here, but regmap is better. It
may be possible to use snd_soc_update_bits_locked() for DAPM codec
access though instead of adding a new lock.

Fwiw, looking at mutex holders in soc/codecs/ gives us :-

grep -rn "mutex_lock(" sound/soc/codecs/
sound/soc/codecs/tlv320dac33.c:252:	mutex_lock(&dac33->mutex);
sound/soc/codecs/tlv320dac33.c:379:	mutex_lock(&dac33->mutex);
sound/soc/codecs/tlv320dac33.c:743:	mutex_lock(&dac33->mutex);
sound/soc/codecs/tlv320dac33.c:914:	mutex_lock(&dac33->mutex);
sound/soc/codecs/tlv320aic3x.c:162:	mutex_lock(&widget->codec->mutex);
sound/soc/codecs/wm8903.c:464:	mutex_lock(&codec->mutex);
sound/soc/codecs/wm8994.c:725:	mutex_lock(&wm8994->accdet_lock);
sound/soc/codecs/wm8994.c:743:	mutex_lock(&wm8994->accdet_lock);
sound/soc/codecs/wm8994.c:3186:				mutex_lock(&codec->mutex);
sound/soc/codecs/wm8994.c:3230:	mutex_lock(&wm8994->accdet_lock);
sound/soc/codecs/wm8994.c:3266:			mutex_lock(&codec->mutex);
sound/soc/codecs/wm8994.c:3279:			mutex_lock(&codec->mutex);
sound/soc/codecs/wm8994.c:3405:	mutex_lock(&wm8994->accdet_lock);
sound/soc/codecs/tpa6130a2.c:133:	mutex_lock(&data->mutex);
sound/soc/codecs/tpa6130a2.c:199:	mutex_lock(&data->mutex);
sound/soc/codecs/tpa6130a2.c:232:	mutex_lock(&data->mutex);
sound/soc/codecs/wm8731.c:139:	mutex_lock(&codec->mutex);
sound/soc/codecs/wl1273.c:53:	mutex_lock(&core->lock);
sound/soc/codecs/wl1273.c:151:	mutex_lock(&core->lock);
sound/soc/codecs/wm8962.c:1581:	mutex_lock(&codec->mutex);
sound/soc/codecs/max98095.c:1903:	mutex_lock(&codec->mutex);
sound/soc/codecs/max98095.c:2057:	mutex_lock(&codec->mutex);
sound/soc/codecs/wm8958-dsp2.c:870:		mutex_lock(&codec->mutex);
sound/soc/codecs/wm8958-dsp2.c:882:		mutex_lock(&codec->mutex);
sound/soc/codecs/wm8958-dsp2.c:903:	mutex_lock(&codec->mutex);
sound/soc/codecs/twl6040.c:686:	mutex_lock(&priv->mutex);

Some of which initially look like private mutexs.

Liam
