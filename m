From: Olof Johansson <olof@lixom.net>
Subject: Re: [patch] ASoC: dapm: using freed pointer in dapm_kcontrol_add_widget()
Date: Wed, 31 Jul 2013 11:17:36 -0700
Message-ID: <CAOesGMgrztKFbLM4m3sr1cH=Od6FVy8p2BbEi_X=J_jDhyHBKw@mail.gmail.com>
References: <20130731085244.GB8210@elgon.mountain>
	<51F8D2B5.7060504@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <51F8D2B5.7060504@metafoo.de>
Sender: kernel-janitors-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, Jul 31, 2013 at 2:02 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 07/31/2013 10:52 AM, Dan Carpenter wrote:
>>
>> There is a typo here so we end up using the old freed pointer instead of
>> the newly allocated one.  (If the "n" is zero then the code works,
>> obviously).
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
>
> Thanks.
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>
> Olof, can you check whether this fixes the crash you see?

Nope.

There's also remaining issues with the code, that patch isn't enough.
The structure that is krealloced() has a list_head in it, but the list
isn't moved from the old head to the new one. There's no safe way to
do that using krealloc, since the old list_head is gone by then, so
it's probably easest to open-code with kzalloc/memcpy/kfree.

But even with that fixed, I still see the same issue. Boggle.

(Btw, I'm testing on top of commit 5106b92f80a2cd37c52cffed80b4f5acfb77ccfd).

-Olof
