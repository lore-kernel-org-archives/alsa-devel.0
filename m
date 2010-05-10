From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA Control Interface - default values?
Date: Mon, 10 May 2010 14:54:07 +0100
Message-ID: <20100510135407.GF5199@sirena.org.uk>
References: <20100510133516.41930@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id ACB0D1037EE
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 15:54:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100510133516.41930@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Max Klein <mein_name@ist-einmalig.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 10, 2010 at 03:35:16PM +0200, Max Klein wrote:

> Can someone please tell me why ALSA initializes the Control with a value of zero, even if the minimum in the info callback is 1 ?

> Is there any way to initialize the control with some "default" values, aside of snd_ctl_add()?

What is the problem here?  The driver is responsible for the default
values - where do you believe that ALSA is overwriting the values you're
looking for?
