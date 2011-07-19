From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH v3 00/10] ARM: mxs: add audio support
Date: Tue, 19 Jul 2011 10:58:37 +0800
Message-ID: <CAA+hA=TEOtt7-CXjzwRMSYEtLbBEOy1Te7vfJOXsso695zLjNw@mail.gmail.com>
References: <1310731780-1645-1-git-send-email-b29396@freescale.com>
	<20110718203816.GA9457@pengutronix.de>
	<20110719014946.GD3838@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 19DE6243BE
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jul 2011 04:58:37 +0200 (CEST)
Received: by ywa8 with SMTP id 8so1633035ywa.38
	for <alsa-devel@alsa-project.org>; Mon, 18 Jul 2011 19:58:37 -0700 (PDT)
In-Reply-To: <20110719014946.GD3838@S2100-06.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, Wolfram Sang <w.sang@pengutronix.de>, u.kleine-koenig@pengutronix.de, Dong Aisheng <b29396@freescale.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2011/7/19 Shawn Guo <shawn.guo@freescale.com>:
> On Mon, Jul 18, 2011 at 10:38:16PM +0200, Wolfram Sang wrote:
>> On Fri, Jul 15, 2011 at 08:09:30PM +0800, Dong Aisheng wrote:
>>
>> > This patch series is to add audio support based on saif for mxs platfo=
rm.
>> > The driver only supports playback currently.
>> > For capturing, due to hardware limitation that we have to use two saif
>> > instances to implement full duplex (playback & recording), we need to
>> > figure out a good design to fit in ASoC as the following work.
>>
>> So, since the codec problems seem to be resolved now (and they were luck=
ily
>> really just codec-problems):
>>
>> For the ASoC-patches (1-4):
>>
>> Tested-by: Wolfram Sang <w.sang@pengutronix.de>
>>
>> For the mach-mxs-Patches (5-9, 10 is already picked up), assuming patch =
6 will
>> lose the DIGCTRL-handling:
>>
>> Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
>>
>> I think this series is good for 3.1. Now we just need the mxs-dma bugfix=
 on
>> top, but that's a different patch...
>>
> Just to be clear, =A0Aisheng, you will submit the mxs-dma fix, right?
Yes, i'll send it now.

Regards
Dong Aisheng
