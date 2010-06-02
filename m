From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] AsoC/s6000: use resource_size
	for	{request/release}_mem_region and ioremap
Date: Wed, 2 Jun 2010 14:56:08 +0100
Message-ID: <20100602135608.GA18071@sirena.org.uk>
References: <4C063751.2060001@gmail.com>
	<20100602105123.GB3020@opensource.wolfsonmicro.com>
	<4C065006.7030305@emlix.com> <20100602124556.GD10031@sirena.org.uk>
	<AANLkTimZV7VyQq31taz2tJOsoBD8Upi3B0ROnZI5O5xn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 567D8243B0
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 15:56:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimZV7VyQq31taz2tJOsoBD8Upi3B0ROnZI5O5xn@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Daniel Gl?ckner <dg@emlix.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 02, 2010 at 09:40:13PM +0800, Wan ZongShun wrote:

> Oh, it just be my worry.
> If some codes were no longer useful or valuable, what should we do for them?
> delete them or keep them be there yet?

> If I my patch to fix a worthless codes, everything I do will be nothing.

The hardware is still very much live, it's just that Daniel isn't
working on it.
