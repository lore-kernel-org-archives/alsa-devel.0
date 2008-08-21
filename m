From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: [PATCH] revo51: add headphone output
Date: Thu, 21 Aug 2008 09:14:21 +0200
Message-ID: <48AD15CD.8090601@insite.cz>
References: <20080821042842.GA7789@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 939A724425
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Aug 2008 09:14:28 +0200 (CEST)
In-Reply-To: <20080821042842.GA7789@orion>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander Beregalov <a.beregalov@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alexander Beregalov wrote:
>  It is ALSA bug #1754.
>  D6 bit in 02 register is PW4.
> 
> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
> ---
> 
>  sound/i2c/other/ak4xxx-adda.c |    4 ++--
>  sound/pci/ice1712/revo.c      |    5 +++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/i2c/other/ak4xxx-adda.c b/sound/i2c/other/ak4xxx-adda.c
> index 288926d..4c94458 100644
> --- a/sound/i2c/other/ak4xxx-adda.c
> +++ b/sound/i2c/other/ak4xxx-adda.c
> @@ -233,8 +233,8 @@ void snd_akm4xxx_init(struct snd_akm4xxx *ak)
>  		0x01, 0x02, /* 1: reset and soft-mute */
>  		0x00, 0x06, /* 0: mode3(i2s), disable auto-clock detect,
>  			     * disable DZF, sharp roll-off, RSTN#=0 */
> -		0x02, 0x0e, /* 2: DA's power up, normal speed, RSTN#=0 */
> -		// 0x02, 0x2e, /* quad speed */
> +		0x02, 0x4e, /* 2: DA's power up, normal speed, RSTN#=0 */
> +		// 0x02, 0x6e, /* quad speed */

Fantastic, I guess this could help to fix the problem with 
non-functioning monitoring in ESI Juli@ too. I did not notice the fourth 
DAC was powered down. Thanks a lot!

Pavel.
