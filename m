From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH] ASoC: fix pxa2xx-i2s clk_get call
Date: Sun, 31 Aug 2008 16:29:38 +0000 (UTC)
Message-ID: <g9egti$3hp$1@ger.gmane.org>
References: <1220129102-20140-1-git-send-email-dbaryshkov@gmail.com>
	<20080830215137.GA28645@sirena.org.uk>
	<bc64b4640808301452x3acec2der2a153d0218706587@mail.gmail.com>
	<1220180736.6499.100.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id CB6B424559
	for <alsa-devel@alsa-project.org>;
	Sun, 31 Aug 2008 18:29:54 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KZpoB-00024D-R5
	for alsa-devel@alsa-project.org; Sun, 31 Aug 2008 16:29:47 +0000
Received: from ppp89-110-3-214.pppoe.avangarddsl.ru ([89.110.3.214])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 31 Aug 2008 16:29:47 +0000
Received: from dbaryshkov by ppp89-110-3-214.pppoe.avangarddsl.ru with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 31 Aug 2008 16:29:47 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:

> On Sun, 2008-08-31 at 01:52 +0400, Dmitry wrote:
>> 2008/8/31 Mark Brown <broonie@sirena.org.uk>:
>> > On Sun, Aug 31, 2008 at 12:45:02AM +0400, Dmitry Baryshkov wrote:
>> >> pxa2xx-isa: probe actual device and use it for clk_get call thus
>> >> fixing error during startup hook
>> >
>> > i2s, not isa.  Other than that
>> >
>> > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> >
>> > and IIRC Liam acked it already as well.
>> >
>> >
>> ... and asked to repost on alsa-devel
>> 
>> 
> It's best to additionally post these patches to alsa-devel for Takashi
> to upstream.

And since it fixes the regression, could it be pushed into 2.6.27-rc?

-- 
With best wishes
Dmitry
