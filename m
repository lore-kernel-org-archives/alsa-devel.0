From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 1/6] ASoC: cs42l51: re-add of_match_table pointer
Date: Tue, 28 Oct 2014 15:09:33 -0500
Message-ID: <alpine.DEB.2.10.1410281502200.28816@heelrod>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414512524-24466-2-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1414512524-24466-2-git-send-email-thomas.petazzoni@free-electrons.com>
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
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, Brian Austin <brian.austin@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Mark Brown <broonie@kernel.org>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 28 Oct 2014, Thomas Petazzoni wrote:

>  #include "cs42l51.h"
>  
> +static const struct of_device_id cs42l51_of_match[] = {
> +	{ .compatible = "cirrus,cs42l51", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, cs42l51_of_match);
> +

Can't this be exported in the codec driver instead of removed?
It seems like it would be duplication for a multi-bus codec to have 
to add it in the bus driver.
For example if/when we add SPI this would have to be duplicated there as 
well right?  And then if we have I2C/SPI/Slimbus/Wireless/etc we would 
have this in all those files.

I believe that is how the cs42xx8 is handled. I will have to check.

Thanks,
Brian
