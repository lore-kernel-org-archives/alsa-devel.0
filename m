From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: [PATCH] alsa-lib: if card driver name is empty
 string, use card name instead
Date: Tue, 20 Sep 2011 14:37:04 +0800
Message-ID: <CAHG8p1D=b9-1R6LkkO+39t41F3doGkCN8kPHn19gwif4r03JAg@mail.gmail.com>
References: <1316538944-31853-1-git-send-email-scott.jiang.linux@gmail.com>
	<s5haa9zspcb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f43.google.com (mail-qw0-f43.google.com
	[209.85.216.43])
	by alsa0.perex.cz (Postfix) with ESMTP id 248CD103830
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 08:37:05 +0200 (CEST)
Received: by qwm42 with SMTP id 42so414043qwm.2
	for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2011 23:37:04 -0700 (PDT)
In-Reply-To: <s5haa9zspcb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

2011/9/20 Takashi Iwai <tiwai@suse.de>:
> At Tue, 20 Sep 2011 13:15:44 -0400,
> Scott Jiang wrote:
>>
>> Some drivers don't have a card driver name, but they have a nice card name containing enough info.
>> So we can use card name to search card config if we found driver name is not valid.
>>
>> Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
>
> It's rather a bug of driver, no?
> I don't think we need to work around it.
>
Mark said it's a bug of app..., he believes driver has provided enough
info in card name.
