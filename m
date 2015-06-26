From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [RFC PATCH 1/2] regmap: add configurable lock
	class key for lockdep
Date: Fri, 26 Jun 2015 11:16:24 +0800
Message-ID: <CANMq1KA2C1ZYUd_s_R5DWn-Hy_XZZQ_aaR47VLpPsNvcvxEQ9w@mail.gmail.com>
References: <1435224904-35517-1-git-send-email-drinkcat@chromium.org>
 <558C0067.2000401@linux.intel.com> <558C1824.8020204@metafoo.de>
 <20150625153325.GR14071@sirena.org.uk>
 <558C229D.4090409@metafoo.de>
 <20150625160817.GT14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 2160D260719
 for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2015 05:16:26 +0200 (CEST)
Received: by oigx81 with SMTP id x81so66701605oig.1
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 20:16:24 -0700 (PDT)
In-Reply-To: <20150625160817.GT14071@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Anatol Pomozov <anatol.pomozov@gmail.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Antti Palosaari <crope@iki.fi>, Bard Liao <bardliao@realtek.com>, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 26, 2015 at 12:08 AM, Mark Brown <broonie@kernel.org> wrote:
[...]
>> >As far as I can tell we're likely to end up needing a key per regmap or
>> >something similar.
>
>> Since the number of lockdep classes itself is also limited we should avoid
>> creating extra lockdep classes when we can. I think the approach which
>> having the option of specifying a lockdep class in the regmap config will be
>> ok. The only case it can't handle if we nest instances with the same config,
>> but I don't really see valid use scases for that at the moment.
>
> Oh, ffs.  This just keeps getting better.  I hadn't been aware of that
> limitation.  We still have the problem that this needs to be something
> users can understand rather than something that's just "define something
> here in one of your drivers if you're running into problems with
> spurious warnings" here.  That's always been the biggest problem here
> (once we got past the "what is this supposed to do in the first place?"
> issues).

I found that V4L2 uses separate lockdep classes for each of their
v4l2_ctrl. This was introduced in 6cd247ef22e "[media] v4l2-ctrls:
eliminate lockdep false alarms for struct v4l2_ctrl_handler.lock"
(https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=6cd247ef22e),
so we could possibly take that approach.

On my system, I have:
# cat /proc/lockdep_stats
 lock-classes:                         1241 [max: 8191]
 direct dependencies:                  7364 [max: 32768]
 indirect dependencies:               27686
 all direct dependencies:            158097
 dependency chains:                   10011 [max: 65536]
 dependency chain hlocks:             38887 [max: 327680]
 in-hardirq chains:                      92
 in-softirq chains:                     372
 in-process chains:                    9547
 stack-trace entries:                107703 [max: 524288]

So, at least on that platform, there is some room to grow...

I'm just afraid that implementing this may require creating a bunch of
macros to wrap all regmap_init_[i2c/spi/...] functions, as the lockdep
classes need to be statically allocated... Unless we find a different
solution than what V4L2 does.
