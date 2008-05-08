From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] [ALSA] soc - fsl_ssi.c fix "BUG:
	scheduling while	atomic"
Date: Thu, 8 May 2008 23:41:46 +0400
Message-ID: <20080508194146.GA5816@polina.dev.rtsoft.ru>
References: <20080508160112.GA17085@polina.dev.rtsoft.ru>
	<48235248.70305@freescale.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by alsa0.perex.cz (Postfix) with SMTP id 741CD2451F
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 21:41:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48235248.70305@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 08, 2008 at 02:19:36PM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> > We must not sleep with irqs disabled, so replace msleep with mdelay.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> Acked-By: Timur Tabi <timur@freescale.com>
> 
> Anton, can you try testing the code with the call to mdelay/msleep commented
> out?

Ok, I'll try...

> On my quick test, I didn't need it, so I have a suspicion that it was
> needed only for the old 1.0 silicon.

Are there any drawbacks of mdelay'ing? Since some silicons need this
we'd better leave it then.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
