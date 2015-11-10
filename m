From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt5645: Power up the RC clock to
	make sure the speaker volume adjust properly
Date: Tue, 10 Nov 2015 03:59:52 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694FA3A6A@RTITMBSV03.realtek.com.tw>
References: <1446724551-27762-1-git-send-email-oder_chiou@realtek.com>
 <20151105121230.GD18409@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694FA2BE6@RTITMBSV03.realtek.com.tw>
 <20151106104433.GB18409@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694FA36C9@RTITMBSV03.realtek.com.tw>
 <20151109140905.GB26072@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A26C260504
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 04:59:57 +0100 (CET)
In-Reply-To: <20151109140905.GB26072@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> On Mon, Nov 09, 2015 at 03:13:09AM +0000, Oder Chiou wrote:
> 
> > > What makes you claim that this is "essential in case of the operation of kcontrol
> > > continuously"?
> 
> > Like the Chrome OS, while the user pull the volume bar up or down, the
> > kcontrol will be manipulated by the UI continuously and seamlessly. In this
> > kind of case, if the "cancel_delayed_work_sync" is removed, the
> > queue_delayed_work will be failed within 200ms after the previous
> > queue_delayed_work, and it will not be able to make sure the power of the
> > RC clock enabled at least 200ms, thanks.
> 
> No, it won't.  To repeat what I said if you just schedule the delayed
> work again without cancelling then the right thing will happen.
> 
The following logs are our test result.
===========================================================================
[  123.365789] [rt5645_spk_put_volsw]->(584) queue_delayed_work ret = 1
[  123.367204] [rt5645_spk_put_volsw]->(584) queue_delayed_work ret = 0
[  123.392307] [rt5645_spk_put_volsw]->(584) queue_delayed_work ret = 0
[  123.393542] [rt5645_spk_put_volsw]->(584) queue_delayed_work ret = 0
[  123.469445] [rt5645_spk_put_volsw]->(584) queue_delayed_work ret = 0
[  123.470581] [rt5645_spk_put_volsw]->(584) queue_delayed_work ret = 0
[  123.565417] [rt5645_rcclock_work]->(3156)
===========================================================================
If we didn't cancel the delayed work, the function will return false to
indicate the delayed work that are already on the queue. It will make the
delayed work that cannot make sure to be manipulated at least 200ms after
the last rt5645_spk_put_volsw was manipulated. In the log, we remove the
cancel_delayed_work and there is only 95ms delay that cannot meet our
requirement, thanks.
