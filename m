From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] regmap: add configurable lock class key for lockdep
Date: Thu, 25 Jun 2015 06:21:43 -0700
Message-ID: <558C0067.2000401@linux.intel.com>
References: <1435224904-35517-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435224904-35517-1-git-send-email-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 6/25/2015 2:35 AM, Nicolas Boichat wrote:
> From: Antti Palosaari <crope@iki.fi>
>
> Lockdep validator complains about recursive locking and deadlock
> when two different regmap instances are called in a nested order.
> That happens anytime a regmap read/write call needs to access
> another regmap.
>
> This is because, for performance reason, lockdep groups all locks
> initialized by the same mutex_init() in the same lock class.
> Therefore all regmap mutexes are in the same lock class, leading
> to lockdep "nested locking" warnings if a regmap accesses another
> regmap. However, depending on the specifics of the driver, this
> can be perfectly safe (e.g. if there is a clear hierarchy between
> a "master" regmap that uses another "slave" regmap). In these
> cases, the warning is false and should be silenced.
>
> As a solution, add configuration option to pass custom lock class
> key for lockdep validator, to be used in the regmap that needs to
> access another regmap. This removes the need for uglier workarounds
> in drivers, just to silence this warning (e.g. add custom mutex
> lock/unlock functions).

wouldn't it be better to use the mutex_lock_nested() and co to explicitly express your hierarchy?
