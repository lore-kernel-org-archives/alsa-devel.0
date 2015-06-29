From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] regmap: add configurable lock class key for lockdep
Date: Mon, 29 Jun 2015 07:35:20 -0700
Message-ID: <559157A8.2050206@linux.intel.com>
References: <1435224904-35517-1-git-send-email-drinkcat@chromium.org> <558C0067.2000401@linux.intel.com> <558C1824.8020204@metafoo.de> <20150625153325.GR14071@sirena.org.uk> <558C229D.4090409@metafoo.de> <20150625160817.GT14071@sirena.org.uk> <CANMq1KA2C1ZYUd_s_R5DWn-Hy_XZZQ_aaR47VLpPsNvcvxEQ9w@mail.gmail.com> <CANMq1KBcWw9jsGkrK0dYzOWGZAZYmHdo6gvvpQwt_ftq+avqVg@mail.gmail.com> <5591414D.6080802@metafoo.de> <CANMq1KAmV7f2f8zhL+VVdpL3AeQKe8RB5nigmZDwrn=JbWGh9Q@mail.gmail.com> <20150629142215.GE11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150629142215.GE11162@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Nicolas Boichat <drinkcat@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 6/29/2015 7:22 AM, Mark Brown wrote:
> On Mon, Jun 29, 2015 at 10:03:09PM +0800, Nicolas Boichat wrote:
>
>> regmap instances are kalloc'ed, so they cannot contain the
>> lock_class_key, which needs to be statically allocated (in .data).
>> Another option would be to preallocate a bunch of lock_class_key in
>> regmap.c, and pick from that, but that's terribly hacky...
>
> Honestly this is all starting to sound like we're having to jump through
> too many hoops for lockep (and other APIs are too from the sounds of it)
> so we should be looking at lockdep here.

lockdep assumes that there is a known lock hierarchy, at least known
to the developer.

seems like for regmap there isn't

(I would be interested to know how you avoid ABBA deadlocks btw,
can you have 2 devices, one with a hierarchy one way, and another
with the hierarchy the other way?)
