From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] ASoC: fsl_ssi: Fix irq_of_parse_and_map() return value
 check
Date: Wed, 16 Oct 2013 18:57:53 -0700
Message-ID: <525F4421.3090404@roeck-us.net>
References: <1380773722-1295-1-git-send-email-linux@roeck-us.net> <20131003155816.GU27287@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131003155816.GU27287@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 10/03/2013 08:58 AM, Mark Brown wrote:
> On Wed, Oct 02, 2013 at 09:15:22PM -0700, Guenter Roeck wrote:
>> irq_of_parse_and_map() returns 0 on error, not NO_IRQ.
>
> Applied, thanks.
>
Hi Mark,

do you plan to send this patch upstream anytime soon ?

It fixes an xtensa build problem, so it would be great if it could find its way into 3.13.

Thanks,
Guenter
