From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 2/6] ASoC: cs42l51: make driver user-selectable
Date: Tue, 28 Oct 2014 14:50:32 -0500
Message-ID: <alpine.DEB.2.10.1410281449130.28816@heelrod>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414512524-24466-3-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1414512524-24466-3-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, Brian Austin <brian.austin@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Nadav Haklai <nadavh@marvell.com>, Mark Brown <broonie@kernel.org>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

> the CS42L51 I2C codec driver user-selectable.
> 
> Cc: Brian Austin <brian.austin@cirrus.com>
> Cc: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  sound/soc/codecs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index a68d173..f4fb12f 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -336,7 +336,7 @@ config SND_SOC_CS42L51
>  	tristate
>  
>  config SND_SOC_CS42L51_I2C
> -	tristate
> +	tristate "Cirrus Logic CS42L51 CODEC (I2C)"
>  	select SND_SOC_CS42L51
>  
>  config SND_SOC_CS42L52
> -- 
> 2.0.0
> 

Thanks,

Acked-by: Brian Austin <brian.austin@cirrus.com>
