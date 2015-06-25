From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC PATCH 1/2] regmap: add configurable lock class key for lockdep
Date: Thu, 25 Jun 2015 17:59:51 +0200
Message-ID: <558C2577.2040404@metafoo.de>
References: <1435224904-35517-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435224904-35517-1-git-send-email-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Arjan van de Ven <arjan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

[...]
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index 116655d..09aaaf5 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -135,6 +135,12 @@ typedef void (*regmap_unlock)(void *);
>    * @lock_arg:	  this field is passed as the only argument of lock/unlock
>    *		  functions (ignored in case regular lock/unlock functions
>    *		  are not overridden).
> + * @lock_class_key: Custom lock class key for lockdep validator. Use that to
> + *                  silence false lockdep nested locking warning, when this
> + *                  regmap needs to access another regmap during read/write
> + *                  operations (directly in read/write functions, or
> + *                  indirectly, e.g. through bus accesses).

The recommendation when to use this is the wrong way around. The presented 
criteria is true for all devices since the bus master might be using regmap 
to implements its IO. Any regmap instance that might be used from within 
another regmap instance needs a custom lock class. This includes bus masters 
as well as resource providers like clock chips or regulators.
