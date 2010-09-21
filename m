From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix soc-cache buffer overflow bug
Date: Tue, 21 Sep 2010 15:36:24 +0100
Message-ID: <1285079784.3089.52.camel@odin>
References: <1285074755-8627-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<20100921132139.GB29838@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EA6FB24368
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 16:36:30 +0200 (CEST)
Received: by wwb28 with SMTP id 28so5494398wwb.20
	for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2010 07:36:29 -0700 (PDT)
In-Reply-To: <20100921132139.GB29838@rakim.wolfsonmicro.main>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-09-21 at 14:21 +0100, Mark Brown wrote:
> On Tue, Sep 21, 2010 at 02:12:35PM +0100, Dimitris Papastamos wrote:
> > Make sure we stay within the cache boundaries when updating the
> > register cache.
> > 
> > Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> 
> OK, will wait for Liam's review before applying but as discussed
> off-line please also do a version of this patch that applies to
> 2.6.36-rc since it's a bug fix.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
