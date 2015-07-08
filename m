From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH] regmap: Use different lockdep class for each regmap init call
Date: Wed, 8 Jul 2015 11:32:42 +0800
Message-ID: <CANMq1KAD95JWkP6MbVck2bSZwHpz09CRYfZmUi4N0RBrF6zK-Q@mail.gmail.com>
References: <1435725839-33173-1-git-send-email-drinkcat@chromium.org>
	<20150707121348.GD2887@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150707121348.GD2887@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Arjan van de Ven <arjan@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 7, 2015 at 8:13 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jul 01, 2015 at 12:43:59PM +0800, Nicolas Boichat wrote:
>
>> (this also applies to all other regmap_init functions...). We do not want to
>> document the lock_key/name parameters, so we could either leave it like that,
>> or move all the documentation to regmap.h, in front of the respective macros.
>
> That seems reasonable.

Which one? Leave as-is? Or move the documentation to regmap.h?

Thanks.
