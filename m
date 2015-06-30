From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [RFC PATCH 1/2] regmap: add configurable lock class
 key for lockdep
Date: Tue, 30 Jun 2015 13:02:10 +0200
Message-ID: <55927732.4060207@metafoo.de>
References: <558C1824.8020204@metafoo.de> <20150625153325.GR14071@sirena.org.uk> <558C229D.4090409@metafoo.de> <20150625160817.GT14071@sirena.org.uk> <CANMq1KA2C1ZYUd_s_R5DWn-Hy_XZZQ_aaR47VLpPsNvcvxEQ9w@mail.gmail.com> <CANMq1KBcWw9jsGkrK0dYzOWGZAZYmHdo6gvvpQwt_ftq+avqVg@mail.gmail.com> <5591414D.6080802@metafoo.de> <CANMq1KAmV7f2f8zhL+VVdpL3AeQKe8RB5nigmZDwrn=JbWGh9Q@mail.gmail.com> <559153A3.1000006@metafoo.de> <20150629153411.GG11162@sirena.org.uk> <20150630045655.GA38694@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150630045655.GA38694@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Antti Palosaari <crope@iki.fi>, Bard Liao <bardliao@realtek.com>, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@redhat.com>
List-Id: alsa-devel@alsa-project.org

On 06/30/2015 06:56 AM, Nicolas Boichat wrote:
> On Mon, Jun 29, 2015 at 04:34:11PM +0100, Mark Brown wrote:
>> On Mon, Jun 29, 2015 at 04:18:11PM +0200, Lars-Peter Clausen wrote:
>>> Leaves us pretty much with only two options. Either add a lock key pointer
>>> to regmap_config which needs to be manually initialized. Or wrap all
>>> regmap_init() variants to create a static lock key. I'd slightly prefer the
>>> later. We can avoid most of the boiler-plate code by using some helper
>>> macros to generate the wrappers.
>>
>> It's better to keep the bodges in the core, yes.
>
> Partial attempt below. Of course all other _init functions will need to be
> converted as well. I'd like to get feedback before I do the rest of the work.

Looks good to me.

> The macro part is quite repetitive and I don't think it can be simplified.

How about something like

#ifdef CONFIG_LOCKDEP

#define regmap_lockdep_wrapper(fn, ...)				\
(								\
	({							\
		static struct lock_class_key _key;		\
		fn(__VA_ARGS__,	&_key,				\
			KBUILD_BASENAME ":"			\
			__stringify(__LINE__) ":"		\
			"(" #config ")->_lock");		\
	})							\
)

#else
#define regmap_lockdep_wrapper(fn, ...) fn(__VA_ARGS__, NULL, NULL)
#endif

#define regmap_init_i2c(i2c, config) \
	regmap_lockdep_wrapper(__regmap_init_i2c, i2c, config)
...
	
