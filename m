From: "Clemens Ladisch" <clemens@ladisch.de>
Subject: Re: [PATCH][RFC] Sound, Xonar,
	CS43xx: Don't overrun static array
Date: Sat, 22 Jan 2011 14:55:08 +0100
Message-ID: <1295704508.21026.1416646721@webmail.messagingengine.com>
References: <alpine.LNX.2.00.1101202228370.11854@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C34BD243A6
	for <alsa-devel@alsa-project.org>; Sat, 22 Jan 2011 14:55:10 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1101202228370.11854@swampdragon.chaosbits.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jesper Juhl <jj@chaosbits.net>, linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jesper Juhl wrote:
> 'cs4398_regs' in 'struct xonar_cs43xx' is an array of 'u8' with a size of 
> 8. So, this code in sound/pci/oxygen/xonar_cs43xx.c::dump_d1_registers()
> 
>     		for (i = 2; i <= 8; ++i)
> 	  			snd_iprintf(buffer, " %02x", data->cs4398_regs[i]);
> 
> will overrun the array when 'i == 8'.
> 
> I guess that what's needed to fix it is the trivial patch below, but I 
> must admit that I have no idea about this code, so I may very well be 
> wrong. Additionally, I have no way to actually test this, so all I know is 
> that the below compiles. Someone who actually knows this code should take 
> a look before anything is comitted - consider the below (not much more 
> than) a bug report.
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>

Acked-by: Clemens Ladisch <clemens@ladisch.de>

> ---
>  xonar_cs43xx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/pci/oxygen/xonar_cs43xx.c
> b/sound/pci/oxygen/xonar_cs43xx.c
> index 9f72d42..2527191 100644
> --- a/sound/pci/oxygen/xonar_cs43xx.c
> +++ b/sound/pci/oxygen/xonar_cs43xx.c
> @@ -392,7 +392,7 @@ static void dump_d1_registers(struct oxygen *chip,
>  	unsigned int i;
>  
>  	snd_iprintf(buffer, "\nCS4398: 7?");
> -       for (i = 2; i <= 8; ++i)
> +       for (i = 2; i < 8; ++i)
>  		snd_iprintf(buffer, " %02x", data->cs4398_regs[i]);
>  	snd_iprintf(buffer, "\n");
>  	dump_cs4362a_registers(data, buffer);
