From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Bugs on aspire one A150
Date: Sat, 13 Dec 2008 15:15:38 +0200
Message-ID: <1229174138.24940.9.camel@maxim-laptop>
References: <491506DB.1070000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f20.google.com (mail-bw0-f20.google.com
	[209.85.218.20]) by alsa0.perex.cz (Postfix) with ESMTP id 536B724438
	for <alsa-devel@alsa-project.org>; Sat, 13 Dec 2008 14:15:47 +0100 (CET)
Received: by bwz13 with SMTP id 13so6621367bwz.8
	for <alsa-devel@alsa-project.org>; Sat, 13 Dec 2008 05:15:46 -0800 (PST)
In-Reply-To: <491506DB.1070000@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org, ath5k-devel@lists.ath5k.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


So, big thanks for everything.

Now aspire one linux support is very close to perfect,
(only problem left is that wireless is limited to 18Mbits/s raw rate,
but at some point I or developers of ath5k will get to the bottom of
this)

I also noticed, that now the SD only card reader is always enabled
regardless of card been there while booting, and same happens in
windows, I suspect that this is permanent hardware change, which worries
me, but this reader works fine otherwise.
(This is another reason why binary bioses are evil, go and find out why
it enables it)


Also forgot to mention that both readers ignore write protect tab on SD
card, and I will report this to correct mailing list soon.
Everything else works fine

please include acpiphp fix in 2.6.28.
Also I applied patch to coretemp to make it show cpu temperature.

Thanks again,
	Maxim Levitsky
