From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [BAD PATCH] ice1712: Add support for Philips
 PSC724 Ultimate Edge
Date: Wed, 14 Mar 2012 09:07:57 +0100
Message-ID: <4F6051DD.9000808@ivitera.com>
References: <201203132159.19733.linux@rainbow-software.org>
	<4F5FBB62.4020300@ivitera.com>
	<20120313213322.GB16460@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
	[84.242.75.189]) by alsa0.perex.cz (Postfix) with ESMTP id 9AC3324483
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 09:07:58 +0100 (CET)
In-Reply-To: <20120313213322.GB16460@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 13.3.2012 22:33, Mark Brown napsal(a):
> On Tue, Mar 13, 2012 at 10:25:54PM +0100, Pavel Hofman wrote:
> 
>> I always found that a simple proc interface listing all register values
>> of the chips onboard greatly helped with troubleshooting. E.g.
>> http://git.alsa-project.org/?p=alsa-kmirror.git;a=blob;f=i2c/other/ak4xxx-adda.c;h=cef813d23641afcd39b56a57c5fc8058cb99bfb0;hb=HEAD#l879
> 
>> http://git.alsa-project.org/?p=alsa-kmirror.git;a=blob;f=i2c/other/ak4114.c;h=fdf3c1b65e388414c995a597ef2b351b4ec2a220;hb=HEAD#l451
> 
> If you use regmap for your register I/O you get this for free (plus some
> other infrastructure stuff).


Mark, thanks for the information. I searched sound-2.6 tree and found
the only reference to linux/regmap.h in soc-io.c. Please could you point
me to a place where it is used in alsa source code so that I could take
it as an example? I have no problem with using the latest kernel
infrastructure helpers but there are just too many of them.

Thanks a lot,

Pavel.
