From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH 2/4] ARM: mvebu: add audio I2S controller
 to Armada 38x Device Tree
Date: Fri, 27 Feb 2015 21:22:30 +0100
Message-ID: <CAPv3WKeLfFsxcC5gvZeP9DZqysZ0XtashByppeuDzRfvjxjujg@mail.gmail.com>
References: <1424901482-3809-1-git-send-email-mw@semihalf.com>
 <1424901482-3809-3-git-send-email-mw@semihalf.com>
 <54EE4AD6.6090101@gmail.com>
 <CAPv3WKf8b+fuB-4qVwKC57iKaNHTLZAf9VFpfDbow1Sb3YAsNw@mail.gmail.com>
 <54EE6942.9080800@gmail.com>
 <CAPv3WKezrx4jkZNo3PYSOGZtiSJH09+94BaknYNN4xPkB1AxKw@mail.gmail.com>
 <20150227150303.2c4ea0e7@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
 [209.85.218.53])
 by alsa0.perex.cz (Postfix) with ESMTP id AEEA42608B4
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 21:22:31 +0100 (CET)
Received: by mail-oi0-f53.google.com with SMTP id u20so17559434oif.12
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 12:22:30 -0800 (PST)
In-Reply-To: <20150227150303.2c4ea0e7@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, Grzegorz Jaszczyk <jaz@semihalf.com>, Liam Girdwood <lgirdwood@gmail.com>, broonie@kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, =?UTF-8?Q?Gregory_Cl=C3=A9ment?= <gregory.clement@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

Dear Thomas,

2015-02-27 15:03 GMT+01:00 Thomas Petazzoni
<thomas.petazzoni@free-electrons.com>:
> Dear Marcin Wojtas,
>
> On Thu, 26 Feb 2015 10:05:08 +0100, Marcin Wojtas wrote:
>
>> > Given that this PLL layout is most likely 38x specific, I'd just put it
>> > into drivers/clk/mvebu/armada-38x.c.
>>
>> Audio PLL setting consist of 3 independent registers. Adjacent to them
>> there are same regs for setting TDM PLL, however I doubt  telephony is
>> going to be supported in foreseeable future (if ever).
>
> We might be supporting TDM in the future. However, I see that the TDM
> PLL registers are nicely grouped together, and so are the audio PLL
> registers. So maybe we can simply have a driver to handle the audio PLL
> registers for now, and if needed in the future, add another driver for
> the TDM PLL.

I've got very fresh experience of adding TDM support for A38x, it
definitely would require longer discussion.

>
>> I also have strong suspicion that it looks the same in a39x - Thomas,
>> can you take a look into spec and confirm?
>
> As far as I can see there is no audio support and no TDM support in
> Armada 39x, and there those TDM PLL and audio PLL registers do not
> exist.
>

Given all the facts, do you think that drivers/clk/mvebu/armada-38x.c
is a right place for adding this PLL setting support?

Best regards,
Marcin
