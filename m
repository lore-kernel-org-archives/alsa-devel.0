From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: my driver can't reproduce continuously
Date: Thu, 23 Jul 2009 11:06:40 +0100
Message-ID: <20090723100640.GB25013@sirena.org.uk>
References: <ur5w8z18d.wl%morimoto.kuninori@renesas.com>
	<uocrbzpng.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 716021039A7
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 12:06:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <uocrbzpng.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 23, 2009 at 06:58:59PM +0900, Kuninori Morimoto wrote:

> o why aplay say underrun!!! ?
>   where should I check ?

Underrun means that the driver is consuming data more quickly than aplay
is able to provide it.  This may mean that there's some system
performance problem or it may be due to your driver is consuming data
more quickly than it should and causing problems further up the stack.

> o sometimes BUG_ON is called when I use kmalloc on
>   snd_soc_dai_ops :: trigger.
>   This BUG_ON came frome cache_alloc_refill.
>   Should I not use kmalloc on trigger function ?

You shouldn't be using kmalloc() there, no - the trigger function is
called from an atomic context where only very limited memory allocation
is possible.

I'll have a look at your code, but it's likely to be a few days before I
have time to do so.
