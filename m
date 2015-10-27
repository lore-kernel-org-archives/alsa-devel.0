From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: wm9713: convert to regmap
Date: Tue, 27 Oct 2015 09:10:09 +0000
Message-ID: <20151027091009.GJ10520@ck-lbox>
References: <1445722627-28854-1-git-send-email-robert.jarzmik@free.fr>
 <20151026110257.GH10520@ck-lbox> <8737wxldns.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E542260418
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 10:27:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <8737wxldns.fsf@belgarion.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 26, 2015 at 06:53:27PM +0100, Robert Jarzmik wrote:
> Charles Keepax <ckeepax@opensource.wolfsonmicro.com> writes:
> 
> > On Sat, Oct 24, 2015 at 11:37:07PM +0200, Robert Jarzmik wrote:
> >> Convert the Wolfson WM9713 to regmap API. This will leverage all the
> >> regmap functions (debug, registers update, etc ...).
> >> 
> >> As a bonus, this will pave the path to gpio chip introduction, and
> >> devicetree support.
> >> 
> >> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> >> ---
> > I am assuming we don't want to be doing a cache_sync just after we
> > have marked the regmap as cache only.
> Ah, this denotes my lack of understanding of regmap cache behavior.
> Basically what I want at this point is that :
>  1) All previous writes should hit the cache (cache coherency barrier)
>  2) All subsequent writes should not go into the cache (uncached writes)
>     => especially the next writes in wm9713_soc_suspend()

Cache only means that writes will only go into the cache. Cache
sync writes the current state of the cache out to the hardware.
Normally you would put the cache into cache only during suspend
this allows controls etc. to still function but the writes go to
the cache and thus the user doesn't need to worry if the codec is
active or not. Then on resume you would turn cache only off such
that writes will go to the hardware again and do a cache sync (you
will need a call to mark the cache as dirty at some point as well),
this will bring the hardware up to date with the writes that
happened whilst it was suspended.

Doing an update_bits that bypasses the cache can be difficult.
You can use regcache_cache_bypass to effectively turn the cache
off, but you need to synchronise it with everything else to
ensure that no writes you want to hit the cache happen whilst it
is disabled. Also you can use multi_write_bypassed to do a bunch
of writes atomically that don't hit the cache, but those are
whole writes rather than update_bits.

> > Also as you have already marked the regmap as cache only these
> > writes won't go to the hardware.
> Ah, exactly the opposite of what I wanted :(
> 
> Would you have an example driver I can inspire myself from. If not, I'll dig in
> more in the regmap cache API.

wm8962 for example shows fairly typical use of these APIs.

Thanks,
Charles
