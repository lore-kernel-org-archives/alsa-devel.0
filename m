From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC PATCH 1/2] regmap: add configurable lock
	class key for lockdep
Date: Thu, 25 Jun 2015 17:03:00 +0200
Message-ID: <558C1824.8020204@metafoo.de>
References: <1435224904-35517-1-git-send-email-drinkcat@chromium.org>
 <558C0067.2000401@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-248.synserver.de (smtp-out-248.synserver.de
 [212.40.185.248])
 by alsa0.perex.cz (Postfix) with ESMTP id 1614C260577
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 17:03:05 +0200 (CEST)
In-Reply-To: <558C0067.2000401@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arjan van de Ven <arjan@linux.intel.com>, Nicolas Boichat <drinkcat@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Antti Palosaari <crope@iki.fi>, Bard Liao <bardliao@realtek.com>, Ingo Molnar <mingo@redhat.com>
List-Id: alsa-devel@alsa-project.org

On 06/25/2015 03:21 PM, Arjan van de Ven wrote:
> On 6/25/2015 2:35 AM, Nicolas Boichat wrote:
>> From: Antti Palosaari <crope@iki.fi>
>>
>> Lockdep validator complains about recursive locking and deadlock
>> when two different regmap instances are called in a nested order.
>> That happens anytime a regmap read/write call needs to access
>> another regmap.
>>
>> This is because, for performance reason, lockdep groups all locks
>> initialized by the same mutex_init() in the same lock class.
>> Therefore all regmap mutexes are in the same lock class, leading
>> to lockdep "nested locking" warnings if a regmap accesses another
>> regmap. However, depending on the specifics of the driver, this
>> can be perfectly safe (e.g. if there is a clear hierarchy between
>> a "master" regmap that uses another "slave" regmap). In these
>> cases, the warning is false and should be silenced.
>>
>> As a solution, add configuration option to pass custom lock class
>> key for lockdep validator, to be used in the regmap that needs to
>> access another regmap. This removes the need for uglier workarounds
>> in drivers, just to silence this warning (e.g. add custom mutex
>> lock/unlock functions).
>
> wouldn't it be better to use the mutex_lock_nested() and co to explicitly
> express your hierarchy?

That would require that the hierarchy is known in advance. The hierarchy 
depends on the hardware topology. Different systems will have different 
hierarchies where the relationship between locks can change and it will be 
hard to find a hierarchy that works across all topologies.

A simple hierarchy would be to say one lockdep subclass is bus masters and 
one lockdep subclass are bus slaves. E.g. the SPI bus controller gets the 
master subclass and the device on the SPI bus gets the slave subclass.

The problem is that a device that is a bus master on one bus that uses 
regmap can be a slave on a different bus that uses regmap. And this can be 
nested arbitrarily deep.

E.g. the rt5677, for which Nicolas is trying to solve the problem is, slave 
device on a I2C bus, but also has an internal bus, which is used to access 
the DSP, for which it is the master.

- Lars
