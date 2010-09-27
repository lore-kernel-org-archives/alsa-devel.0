From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add Jassi Brar as Samsung maintainer
Date: Sun, 26 Sep 2010 22:41:50 -0700
Message-ID: <20100927054149.GA13056@opensource.wolfsonmicro.com>
References: <1285402601-10131-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTik5q1B9B5V0rUHVfAXPHe7vWbxJm3dK_A6QfTJ=@mail.gmail.com>
	<AANLkTi=xEwPGsf756EG3c4sC5F4mDevoXwcMtSYnrXt_@mail.gmail.com>
	<AANLkTimf1BmDe0pPqPgi0qWYG9pb2tZVgvLQ4VVEh6K5@mail.gmail.com>
	<AANLkTimvdZP3pjYv56+AXGy5d7ceb+q1=NomH3fr1isC@mail.gmail.com>
	<20100927001959.GB10638@opensource.wolfsonmicro.com>
	<AANLkTi=JOwQD9sJG603NEQuqJU_N9fAA6nPAtq3YuAvF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DD13F24557
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 07:41:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=JOwQD9sJG603NEQuqJU_N9fAA6nPAtq3YuAvF@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: =?utf-8?B?7LWc7LCs7Jqw?= <cw00.choi@samsung.com>, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 27, 2010 at 11:01:54AM +0900, Kyungmin Park wrote:

> Yes, recent Samsung SoC supports the clock & block gating. As the
> word, clock gating means enable/disable the clock and block gating
> means turn on/off some peripherals blocks to reduce the power. e..g,
> In case of audio, AUDIO block including I2S, AC97 and so on.

It's very straightforward, yes (though in the case of AC'97 the split
between CODEC and CPU is more tricky than you might at first think since
by default the CPU is clock master for everything).

> However codec is different. even though it can turn on/off codec, I
> think it have to re-initialize to use it and it takes some times.

The same is true for CPU IPs, of course.  With modern CODECs this is
becoming less and less of an issue - with VMID referenced CODECs there
was always a lengthy delay to bring up VMID but with ground referenced,
PDM and class D outputs it's becoming less and less of an issue to just
power things down.
