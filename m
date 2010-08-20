From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] asoc/multi-component: mpc8610:
 replace	of_device with platform_device
Date: Fri, 20 Aug 2010 12:44:44 -0500
Message-ID: <4C6EBF0C.3000204@freescale.com>
References: <1282249618-27137-1-git-send-email-timur@freescale.com>
	<20100820094113.GB13668@rakim.wolfsonmicro.main>
	<AANLkTi=nAR=qCikxMK25a6u_vT5t_hz0RGo2Us+sba6T@mail.gmail.com>
	<1282320631.3084.636.camel@odin>
	<20100820162116.GD21965@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by alsa0.perex.cz (Postfix) with ESMTP id 7AD67243A3
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 19:45:26 +0200 (CEST)
Received: from mail175-tx2 (localhost.localdomain [127.0.0.1])	by
	mail175-tx2-R.bigfish.com (Postfix) with ESMTP id B16107F83C1	for
	<alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 17:45:23 +0000 (UTC)
Received: from TX2EHSMHS017.bigfish.com (unknown [10.9.14.241])	by
	mail175-tx2.bigfish.com (Postfix) with ESMTP id F1E1C98804E	for
	<alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 17:44:57 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o7KHikuq019046	for
	<alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 10:44:56 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o7KHw510011595	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 12:58:05 -0500 (CDT)
In-Reply-To: <20100820162116.GD21965@sirena.org.uk>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
>> > Mark has pulled and has this patch now. Btw, the confusion here was in
>> > the patch subject (multi-component) hence this mornings email on the
>> > matter.
> This sorted the application issue, applied now.

Ok, this wraps up all my work for mpc8610 and p1022 audio.  Thanks, guys.  I
know I was a bit prissy every now and then, so I appreciate your putting up
with me these last four months.
