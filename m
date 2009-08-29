From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: Davinci: Add audio codec support
 for DM365 EVM
Date: Sat, 29 Aug 2009 10:11:02 +0100
Message-ID: <20090829091102.GB4314@sirena.org.uk>
References: <1251489237-22688-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 67E0F244F2
	for <alsa-devel@alsa-project.org>;
	Sat, 29 Aug 2009 11:11:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1251489237-22688-1-git-send-email-miguel.aguilar@ridgerun.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: miguel.aguilar@ridgerun.com
Cc: todd.fischer@ridgerun.com, davinci-linux-open-source@linux.davincidsp.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, clark.becker@ridgerun.com
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 28, 2009 at 01:53:57PM -0600, miguel.aguilar@ridgerun.com wrote:

> +/* dm365 evm audio private data */
> +static struct aic3x_setup_data dm365_evm_aic3x_setup = {
> +       .i2c_bus = 1,
> +       .i2c_address = 0x18,
> +};

This won't build any more - the I2C board info from arch/arm is now used
and these fields have been removed from the struct.  You should just be
able to drop the codec data entirely if you don't need any of the other
fields.
