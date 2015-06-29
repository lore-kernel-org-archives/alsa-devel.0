From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] regmap: add configurable lock class key for lockdep
Date: Mon, 29 Jun 2015 08:36:01 -0700
Message-ID: <559165E1.105@linux.intel.com>
References: <558C1824.8020204@metafoo.de> <20150625153325.GR14071@sirena.org.uk> <558C229D.4090409@metafoo.de> <20150625160817.GT14071@sirena.org.uk> <CANMq1KA2C1ZYUd_s_R5DWn-Hy_XZZQ_aaR47VLpPsNvcvxEQ9w@mail.gmail.com> <CANMq1KBcWw9jsGkrK0dYzOWGZAZYmHdo6gvvpQwt_ftq+avqVg@mail.gmail.com> <5591414D.6080802@metafoo.de> <CANMq1KAmV7f2f8zhL+VVdpL3AeQKe8RB5nigmZDwrn=JbWGh9Q@mail.gmail.com> <20150629142215.GE11162@sirena.org.uk> <559157A8.2050206@linux.intel.com> <20150629153256.GF11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150629153256.GF11162@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolas Boichat <drinkcat@chromium.org>, Lars-Peter Clausen <lars@metafoo.de>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 6/29/2015 8:32 AM, Mark Brown wrote:
> On Mon, Jun 29, 2015 at 07:35:20AM -0700, Arjan van de Ven wrote:
>
>> lockdep assumes that there is a known lock hierarchy, at least known
>> to the developer.
>
>> seems like for regmap there isn't
>
> It's not that there's no heirachy of locks, it's that lockdep is unable
> to understand what's going on since it's making simplifying assumptions
> that just aren't true.  If I remember the problem correctly it's
> grouping all locks allocated in the same place into one class which
> doesn't work at all for scenarios where you've got a generic interface
> providing services to many devices which may be stacked on top of each
> other.

but the stacking *IS* a lock hierarchy.

it just seems that the hierarchy is implied rather than explicit.


>> (I would be interested to know how you avoid ABBA deadlocks btw,
>> can you have 2 devices, one with a hierarchy one way, and another
>> with the hierarchy the other way?)
>
> I'm not sure I fully understand what you mean here, sorry - do you mean
> in terms of classes or individual devices?  The relationships between
> devices are all device and system defined, individual regmaps should be
> treated as separate classes.  From this perspective it's basically
> eqivalent to asking how the mutex code avoids misuse of mutexes.

well what I meant is inividual devices/ranges

like device A is on devmap A but then ends up using devmap B underneath
(e.g. the lock nesting case)

what prevents there from being a device B that is on devmap B but that
uses devmap A underneath


>
