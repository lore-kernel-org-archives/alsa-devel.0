From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] General fix for Palm27x aSoC driver
Date: Tue, 14 Apr 2009 23:42:34 +0200
Message-ID: <200904142342.34914.marek.vasut@gmail.com>
References: <200904121858.42931.marek.vasut@gmail.com>
	<200904122051.19335.marek.vasut@gmail.com>
	<20090414195035.GA6902@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f223.google.com (mail-bw0-f223.google.com
	[209.85.218.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 93BE1103869
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 23:42:28 +0200 (CEST)
Received: by bwz23 with SMTP id 23so2914950bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2009 14:42:27 -0700 (PDT)
In-Reply-To: <20090414195035.GA6902@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Tuesday 14 of April 2009 21:50:36 Mark Brown wrote:
> On Sun, Apr 12, 2009 at 08:51:19PM +0200, Marek Vasut wrote:
> > +static struct pxa2xx_ac97_platform_data palmld_ac97_pdata = {
> > +	.reset_gpio	= 95,
> > +};
>
> The type of this will need changing to reflect the patch that got merged
> for this but other than that minor point this approach is fine.

OK, shall I change it and resend (ps. to what if you dont mind telling me?) ? 
Also, do you want to push it through also tree or ARM tree ? I'm for the 
second option as it's more of a bugfix suitable for that tree.

Thanks
