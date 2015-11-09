From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt5645: Power up the RC clock to
	make sure the speaker volume adjust properly
Date: Mon, 9 Nov 2015 03:13:09 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694FA36C9@RTITMBSV03.realtek.com.tw>
References: <1446724551-27762-1-git-send-email-oder_chiou@realtek.com>
 <20151105121230.GD18409@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694FA2BE6@RTITMBSV03.realtek.com.tw>
 <20151106104433.GB18409@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 56CE52606D8
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 04:13:35 +0100 (CET)
In-Reply-To: <20151106104433.GB18409@sirena.org.uk>
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

> > Thank you for the kind advice. The "cancel_delayed_work_sync" is
> > essential in case of the operation of kcontrol continuously. We want
> > to make sure the RC clock can be powered up at least 200ms after the
> > speaker volume is adjusted, so we add the "cancel_delayed_work_sync"
> > on the top of the function and requeue it, thanks.
> 
> What makes you claim that this is "essential in case of the operation of kcontrol
> continuously"?
> 
Like the Chrome OS, while the user pull the volume bar up or down, the
kcontrol will be manipulated by the UI continuously and seamlessly. In this
kind of case, if the "cancel_delayed_work_sync" is removed, the
queue_delayed_work will be failed within 200ms after the previous
queue_delayed_work, and it will not be able to make sure the power of the
RC clock enabled at least 200ms, thanks.
