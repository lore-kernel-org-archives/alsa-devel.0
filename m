From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 4/4] ASoC: firmware core: Add core support
 to	create and destroy firmware components.
Date: Tue, 20 Nov 2012 12:03:25 +0000
Message-ID: <50AB718D.10207@ti.com>
References: <1353348765-6238-1-git-send-email-lrg@ti.com>
 <1353348765-6238-4-git-send-email-lrg@ti.com> <s5hr4npqvlh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 207CE2615DF
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 13:03:28 +0100 (CET)
In-Reply-To: <s5hr4npqvlh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 19/11/12 18:46, Takashi Iwai wrote:

> I find the idea is great.  Looking through the patch, a few things
> came to my mind:
>
> - Endianness and alignment
> - Forward-compatibility
> - Avoid the bitfield usages
>
> About endianness: the firmware is usually provided as
> endian-independent.  That is, the driver is supposed to convert to CPU
> endianness properly, or check and reject the invalid firmware, at
> least.
>

Yeah, that's something we don't convert atm, but we do check with a u32 magic 
number in each header (and will reject that object if the header is missing or 
incorrect).

I think we are good with the magic number check atm and I can add some 
explicit endianess conversion when we have more users. Atm, the only users 
will be ARM based.

Thanks

Liam
