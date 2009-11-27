From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Sound support for Neuros OSD2 Davinci based board.
Date: Fri, 27 Nov 2009 11:12:55 +0000
Message-ID: <20091127111254.GB29512@sirena.org.uk>
References: <4B0E7D5E.3080906@chelcom.ru> <002e01ca6e9c$2dab6040$890220c0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5321110392C
	for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2009 12:13:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <002e01ca6e9c$2dab6040$890220c0$@com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chaithrika U S <chaithrika@ti.com>
Cc: alsa-devel@alsa-project.org, 'David Brownell' <dbrownell@users.sourceforge.net>, 'Takashi Iwai' <tiwai@suse.de>, linux-kernel@vger.kernel.org, 'Kevin Hilman' <khilman@deeprootsystems.com>, "'A. Porodko'" <panda@chelcom.ru>, 'Troy Kisky' <troy.kisky@boundarydevices.com>, 'Liam Girdwood' <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 26, 2009 at 06:57:19PM +0530, Chaithrika U S wrote:

> @@ -246,6 +249,9 @@ static int __init evm_init(void)
>  	if (machine_is_davinci_evm()) {
>  		evm_snd_dev_data = &evm_snd_devdata;
>  		index = 0;
> +	} else if (machine_is_neuros_osd2()) {
> +		evm_snd_dev_data = &evm_snd_devdata;
> +		index = 0;

> The above can be combined with the check for DaVinci EVM
> 	if (machine_is_davinci_evm() ||
> 				(machine_is_neuros_osd2()) {
>  		evm_snd_dev_data = &evm_snd_devdata;
>  		index = 0;

I raised the same query when Andrey sent an off-list copy to me by
mistake - he said that in future he intends to extend the driver to 
have additional features not present on the EVM (though for me that
could always change the || later).

Andrey, with Linux kernel patches reply to all is generally the way
forward.
