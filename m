From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: rt5677: Avoid recursive locking in
 the DEADLOCK detector
Date: Fri, 05 Jun 2015 12:53:27 +0200
Message-ID: <55717FA7.8030005@metafoo.de>
References: <1433346797-1908-1-git-send-email-oder_chiou@realtek.com>
 <20150603164453.GP14071@sirena.org.uk>
 <CANMq1KCFwFppzAx5NiotP_0uy93Ga436PYEbhhA6iM0JCXWtaA@mail.gmail.com>
 <20150605103144.GS14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-163.synserver.de (smtp-out-163.synserver.de
 [212.40.185.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 993F526145B
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 12:53:35 +0200 (CEST)
In-Reply-To: <20150605103144.GS14071@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Nicolas Boichat <drinkcat@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, john.lin@realtek.com, Antti Palosaari <crope@iki.fi>, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 06/05/2015 12:31 PM, Mark Brown wrote:
> On Fri, Jun 05, 2015 at 08:53:54AM +0800, Nicolas Boichat wrote:
>
>>> Could you be more specific about the deadlock you're seeing?  This isn't
>>> really enough to understand either what the problem is or why this fixes
>>> it.  Converting all the per-regmap mutexes into a single global mutex
>>> isn't an immediately obvious step.
>
>> We originally reported the issue to Realtek:
>
> Any analysis needs to be in the changelog for the commit and...
>
>> I suggested reworking the register read/write calls in rt5677.c to
>> direct them to the correct regmap earlier on (rt5677->regmap or
>> rt5677->regmap_physical), before locks are acquired. But the patch
>> above also fixes the issue (that is, it removes the warning).
>
> ...the above sounds like there's a bug in the locking anyway which this
> is just a bodge for?

It's the same issue Antti reported a while ago. The issue is that lockdep 
for performance reasons does not look at each lock separately, but only at 
lock classes. By default all locks initialized by the same mutex_init() call 
end up in the same lock class. When one lock of a lock class is locked while 
already holding a lock from the same lock class lockdep complains about a 
potential deadlock because to lockdep those look like the same lock. For 
most locks this is OK since they do not recursively lock locks from the same 
lock class.

Now the issue here is that we have nested regmap instances, meaning one 
regmap instances uses another instance in its read/write implementation. 
This will lead to nested locking of the mutex of the regmap struct. Since 
both mutexes are in the same lock class lockdep generates a warning. Rather 
than silencing the warning with some per driver hacks the correct way to fix 
this is to allow to properly annotate the locks as being different locks.

I think Antti submitted some patches to attend to fix this, but there were 
still issues with the patches and they never got merged.

- Lars
