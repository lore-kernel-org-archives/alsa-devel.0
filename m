From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Patch] Overrun in sound/pci/au88x0/au88x0_pcm.c
Date: Tue, 11 Apr 2006 00:03:56 -0400
Message-ID: <1144728237.18918.19.camel@mindpipe>
References: <1144664001.15821.1.camel@alice>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1144664001.15821.1.camel@alice>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Please send all ALSA bug fixes to alsa-devel (cc'ed)

On Mon, 2006-04-10 at 12:13 +0200, Eric Sesterhenn wrote:
> hi,
> 
> since idx is used as an index for vortex_pcm_prettyname[VORTEX_PCM_LAST],
> it should not be equal to VORTEX_PCM_LAST. This fixes coverity bug id #572
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> 
> --- linux-2.6.17-rc1/sound/pci/au88x0/au88x0_pcm.c.orig	2006-04-10 12:10:22.000000000 +0200
> +++ linux-2.6.17-rc1/sound/pci/au88x0/au88x0_pcm.c	2006-04-10 12:10:41.000000000 +0200
> @@ -506,7 +506,7 @@ static int __devinit snd_vortex_new_pcm(
>  	int i;
>  	int err, nr_capt;
>  
> -	if ((chip == 0) || (idx < 0) || (idx > VORTEX_PCM_LAST))
> +	if ((chip == 0) || (idx < 0) || (idx >= VORTEX_PCM_LAST))
>  		return -ENODEV;
>  
>  	/* idx indicates which kind of PCM device. ADB, SPDIF, I2S and A3D share the 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
