From: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
Subject: Re: refreshing the reg cache in asoc driver
Date: Fri, 01 Oct 2010 12:08:29 +0200
Message-ID: <4CA5B31D.706@elproma.com.pl>
References: <17b6865a.5133de6e.4ca30a3c.3659c@o2.pl>
	<20100929175215.GC19087@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailmxout.mailmx.agnat.pl (mailmxout.mailmx.agnat.pl
	[193.239.44.238])
	by alsa0.perex.cz (Postfix) with ESMTP id A3E5A1039F7
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 12:08:31 +0200 (CEST)
Received: from smtp.agnat.pl ([193.239.44.82])
	by mailmxout.mailmx.agnat.pl with esmtp (Exim 4.72)
	(envelope-from <g.daniluk@elproma.com.pl>) id 1P1cXW-0001zE-7t
	for alsa-devel@alsa-project.org; Fri, 01 Oct 2010 12:08:30 +0200
Received: from [83.19.137.3] (helo=[192.168.1.79])
	by smtp.agnat.pl with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.71) (envelope-from <g.daniluk@elproma.com.pl>)
	id 1P1cXW-0001x6-5a
	for alsa-devel@alsa-project.org; Fri, 01 Oct 2010 12:08:30 +0200
In-Reply-To: <20100929175215.GC19087@sirena.org.uk>
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

Mark Brown wrote:
> Note that Dimitrios just posted a driver for this to the list earlier
> today, which is also available from opensource.wolfsonmicro.com.  It
> would be best to work with this driver.
>   
yes, I saw it later after sending my e-mail, I'll try using this one 
instead of my own.
>
> The bigger question would be why you want to refresh the register cache
> - normally this should not be required.  If you do need to do this it
> would be better to trigger the refresh off whatever event causes the
> register status in the CODEC to get out of sync.  If there are registers
> which report status which does change dynamically normally they
> shouldn't be cached at all but should instead be treated as volatile and
> read back from the CODEC at all times.
>   
Thanks a lot, I thought about it in the wrong way.

Greg
