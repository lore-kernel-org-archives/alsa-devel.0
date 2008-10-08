From: ext-jukka.hynninen@vaisala.com
Subject: Re: ASoC WM8510 Mic PGA problem
Date: Wed, 8 Oct 2008 09:37:51 +0300
Message-ID: <B9D3C48C98930741A166756A50C44A610F17B55F@helx1.corp.vaisala.com>
References: <B9D3C48C98930741A166756A50C44A610F17B555@helx1.corp.vaisala.com>
	<20081003133936.GD26035@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B556@helx1.corp.vaisala.com>
	<20081006100522.GB14087@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B55A@helx1.corp.vaisala.com>
	<20081007121144.GA5119@rakim.wolfsonmicro.main>
	<B9D3C48C98930741A166756A50C44A610F17B55D@helx1.corp.vaisala.com>
	<20081007134318.GF19835@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B55E@helx1.corp.vaisala.com>
	<20081007145934.GA32344@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw.vaisala.com (mailgw.vaisala.com [192.81.123.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FAB4243A1
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Oct 2008 08:38:06 +0200 (CEST)
Received: from helsrv02.vaisala.com (helsrv02.vaisala.com [192.81.123.16])
	by mailgw.vaisala.com (8.13.6/8.13.6) with SMTP id m986brUu018997
	for <alsa-devel@alsa-project.org>; Wed, 8 Oct 2008 09:37:53 +0300
Content-class: urn:content-classes:message
In-Reply-To: <20081007145934.GA32344@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Quoting Mark Brown:

>> I'm sorry, It seems to be the switch connecting MICN to negative PGA
>> terminal that does not stay on (register 0x2c bit 1)
> Ah, I think I see what's going on here.  Could you try this patch,

The latest one did the trick. Now the PGA control works nice and
smoothly.

Many thanks!


-Jukka
