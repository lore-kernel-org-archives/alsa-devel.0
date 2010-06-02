From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] AsoC/s6000: use resource_size
	for	{request/release}_mem_region and ioremap
Date: Wed, 2 Jun 2010 13:45:57 +0100
Message-ID: <20100602124556.GD10031@sirena.org.uk>
References: <4C063751.2060001@gmail.com>
	<20100602105123.GB3020@opensource.wolfsonmicro.com>
	<4C065006.7030305@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 51E9B24632
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 14:45:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C065006.7030305@emlix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Gl?ckner <dg@emlix.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Wan ZongShun <mcuos.com@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 02, 2010 at 02:35:18PM +0200, Daniel Gl?ckner wrote:

> I don't think it is necessary to add an entry to MAINTAINERS.
> My name and address listed at the top of the file should be enough.
> It's not like I'm still working on it, but if needed I can take the
> device from the shelf to perform some tests, should anyone make more
> serious changes to the driver.

MAINTAINERS is used by automatic tools like get_maintainer to find who
to CC so entries there are still useful - original authorship is often
not a good indicator that someone is willing to take responsibility for
the code.  From the sounds of it though it was for a particular project
and you've moved on from it so you're not particularly concerned about
now so it's not worth it anyway?
