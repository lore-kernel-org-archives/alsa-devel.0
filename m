From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [BAD PATCH] ice1712: Add support for Philips
 PSC724 Ultimate Edge
Date: Tue, 13 Mar 2012 21:33:22 +0000
Message-ID: <20120313213322.GB16460@sirena.org.uk>
References: <201203132159.19733.linux@rainbow-software.org>
	<4F5FBB62.4020300@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 662DF10439C
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 22:33:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F5FBB62.4020300@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel@alsa-project.org, Ondrej Zary <linux@rainbow-software.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 13, 2012 at 10:25:54PM +0100, Pavel Hofman wrote:

> I always found that a simple proc interface listing all register values
> of the chips onboard greatly helped with troubleshooting. E.g.
> http://git.alsa-project.org/?p=alsa-kmirror.git;a=blob;f=i2c/other/ak4xxx-adda.c;h=cef813d23641afcd39b56a57c5fc8058cb99bfb0;hb=HEAD#l879

> http://git.alsa-project.org/?p=alsa-kmirror.git;a=blob;f=i2c/other/ak4114.c;h=fdf3c1b65e388414c995a597ef2b351b4ec2a220;hb=HEAD#l451

If you use regmap for your register I/O you get this for free (plus some
other infrastructure stuff).
