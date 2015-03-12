From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] sound:pci:Change return type of function,
	shift_bits	in xonar_dg.c to avoid overflow
Date: Thu, 12 Mar 2015 08:49:39 +0100
Message-ID: <55014513.4030201@ladisch.de>
References: <1426134946-21167-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id C248F2656F6
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 08:49:44 +0100 (CET)
In-Reply-To: <1426134946-21167-1-git-send-email-xerofoify@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Nicholas Krause wrote:
> This changes the return type of the function,shift_bits to unsigned
> long in order to avoid overflowing issues with this function when
> called as found when running sparse on the kernel source tree.

sparse is just a tool to help finding problems.  The goal is not to do
something to shut it up, but the remove the actual problem.

In this case, if the return type of shift_bits() were a problem, you
would have just moved the problem to its caller where the value is
then returned as unsigned int anyway.

Stop spamming us with patches for code that you do not understand.


Regards,
Clemens

> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  sound/pci/oxygen/xonar_dg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/pci/oxygen/xonar_dg.c b/sound/pci/oxygen/xonar_dg.c
> index 4cf3200..2337a76 100644
> --- a/sound/pci/oxygen/xonar_dg.c
> +++ b/sound/pci/oxygen/xonar_dg.c
> @@ -238,7 +238,7 @@ void set_cs4245_adc_params(struct oxygen *chip,
>  	cs4245_write_spi(chip, CS4245_MCLK_FREQ);
>  }
>
> -static inline unsigned int shift_bits(unsigned int value,
> +static inline unsigned long shift_bits(unsigned int value,
>  				      unsigned int shift_from,
>  				      unsigned int shift_to,
>  				      unsigned int mask)
