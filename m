From: "Dmitry Eremin-Solenikov" <dbaryshkov@gmail.com>
Subject: Re: [PATCH] pxa2xx-ac97: switch AC unit to correct
	state before probing
Date: Mon, 5 Jan 2009 14:26:43 +0300
Message-ID: <bc64b4640901050326l6dfb7331q1538c05bf3dd5d9b@mail.gmail.com>
References: <1231149486-32377-1-git-send-email-dbaryshkov@gmail.com>
	<20090105105805.GA22459@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 49F8C1037FD
	for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2009 12:26:44 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id b2so2096296ana.2
	for <alsa-devel@alsa-project.org>; Mon, 05 Jan 2009 03:26:43 -0800 (PST)
In-Reply-To: <20090105105805.GA22459@rakim.wolfsonmicro.main>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/1/5 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Mon, Jan 05, 2009 at 12:58:06PM +0300, Dmitry Eremin-Solenikov wrote:
>> From: Dmitry Baryshkov <dbaryshkov@gmail.com>
>
>> If AC97 unit is in partially enabled state, early request_irq can trigger
>> IRQ storm or even full hang up. Workaround this by forcibly switching ACLINK off
>> at the start of the probe.
>
>> Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
>
> Applied, thanks.  I guess some of your scripts need updating for your
> name change after your wedding, though?
>

Nah, I just didn't resign/recommit all old patches, so they still bear
my old surname.

-- 
With best wishes
Dmitry
