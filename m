From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: [PATCH v2 4/5] ASoC: add spi hw read function for
 16 addr 8 data mode
Date: Mon, 15 Aug 2011 15:03:33 +0800
Message-ID: <CAHG8p1B1vixgfkQdnNLyvm5NSajWMCWAGCaG+yCWEJYpQT+cYw@mail.gmail.com>
References: <1313186654-22520-1-git-send-email-scott.jiang.linux@gmail.com>
	<1313186654-22520-4-git-send-email-scott.jiang.linux@gmail.com>
	<CAGsJ_4wm-4TGnBmnzQPKoN+ytbi_xL1Nh7Lz5wF21w6F3g6abw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id EC17B244F2
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 09:03:34 +0200 (CEST)
Received: by qwf7 with SMTP id 7so2416048qwf.38
	for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2011 00:03:33 -0700 (PDT)
In-Reply-To: <CAGsJ_4wm-4TGnBmnzQPKoN+ytbi_xL1Nh7Lz5wF21w6F3g6abw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

2011/8/15 Barry Song <21cnbao@gmail.com>:
> 2011/8/13 Scott Jiang <scott.jiang.linux@gmail.com>:
>> some spi registers are 7bits global address + 1 bit r/w + 8 bits
>> register address. soc cache layer can't support this kind well.
>> so let codec driver read registers directly.
>
> i don't think your this document has any relationship with your patch.
> it is just making confusion.
> And who is the user of your this new API?
>
some spi codecs such as ad1938 can't be supported by cache layer. so
they need spi hw read function.
This patch add this function for 16bits addr 8 bits data mode spi transfer.
