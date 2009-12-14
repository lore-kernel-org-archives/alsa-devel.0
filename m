From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: hw_ptr accuracy with intel8x0 -> PulseAudio issue
Date: Mon, 14 Dec 2009 08:29:35 -0600
Message-ID: <6160a5130912140629l12e71c27u6fd7d53aba5b9fb0@mail.gmail.com>
References: <6160a5130912020115t45bd4635hceb0ac3de4fb1efe@mail.gmail.com>
	<6160a5130912030828m5b2401f3w31a67b6b51e8d8b6@mail.gmail.com>
	<4f3252890912031442i56ccc905g935a4d6ed48f40c6@mail.gmail.com>
	<6160a5130912031650u5949c921jc86d0847b2844803@mail.gmail.com>
	<4f3252890912041817u7ab83a3eh7643476d64d709f3@mail.gmail.com>
	<s5h4oo1sisn.wl%tiwai@suse.de>
	<4f3252890912090355n70a2b5cfu4fbb74d473480a94@mail.gmail.com>
	<s5hr5r4ntus.wl%tiwai@suse.de>
	<6160a5130912100627t4d62397dp654c9bcb84ade617@mail.gmail.com>
	<4f3252890912122334le0e5634gd693c7f5d1bfa6eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f173.google.com (mail-px0-f173.google.com
	[209.85.216.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EC49103801
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 15:29:36 +0100 (CET)
Received: by pxi3 with SMTP id 3so2186590pxi.16
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 06:29:36 -0800 (PST)
In-Reply-To: <4f3252890912122334le0e5634gd693c7f5d1bfa6eb@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> why did you reduce periods_max by half since the driver should still support
> 1024 periods of 32 bytes when you set periods_min = 2 ?
>
> Is it period_bytes_max by half ?

Yes I meant period_bytes_max.
