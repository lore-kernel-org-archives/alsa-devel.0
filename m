From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC PATCH 1/2] regmap: add configurable lock
	class key for lockdep
Date: Thu, 25 Jun 2015 17:47:41 +0200
Message-ID: <558C229D.4090409@metafoo.de>
References: <1435224904-35517-1-git-send-email-drinkcat@chromium.org>
 <558C0067.2000401@linux.intel.com> <558C1824.8020204@metafoo.de>
 <20150625153325.GR14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-248.synserver.de (smtp-out-248.synserver.de
 [212.40.185.248])
 by alsa0.perex.cz (Postfix) with ESMTP id E84C8260698
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 17:47:43 +0200 (CEST)
In-Reply-To: <20150625153325.GR14071@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Nicolas Boichat <drinkcat@chromium.org>, Anatol Pomozov <anatol.pomozov@gmail.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Antti Palosaari <crope@iki.fi>, Bard Liao <bardliao@realtek.com>, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@redhat.com>
List-Id: alsa-devel@alsa-project.org

On 06/25/2015 05:33 PM, Mark Brown wrote:
> On Thu, Jun 25, 2015 at 05:03:00PM +0200, Lars-Peter Clausen wrote:
>> On 06/25/2015 03:21 PM, Arjan van de Ven wrote:
>
>>> wouldn't it be better to use the mutex_lock_nested() and co to explicitly
>>> express your hierarchy?
>
>> That would require that the hierarchy is known in advance. The hierarchy
>> depends on the hardware topology. Different systems will have different
>> hierarchies where the relationship between locks can change and it will be
>> hard to find a hierarchy that works across all topologies.
>
> It depends on what you use as the key for the nested locking stuff.  If
> you assign a key per regmap (casting the pointer to an integer, using an
> IDR or something).  I don't know if that creates problems for the
> locking code, I'd not expect so but then I'd not have expected the
> problem in the first place.

The maximum number of subclasses is 8 per lockclass, so a IDR that 
increments which each created regmap instance wouldn't really work.

And while on the other hand we probably wont have a hierarchy deeper than 8 
nested regmap instances it is not trivial to figure out which instance is at 
which level.

>
> As far as I can tell we're likely to end up needing a key per regmap or
> something similar.
>

Since the number of lockdep classes itself is also limited we should avoid 
creating extra lockdep classes when we can. I think the approach which 
having the option of specifying a lockdep class in the regmap config will be 
ok. The only case it can't handle if we nest instances with the same config, 
but I don't really see valid use scases for that at the moment.
