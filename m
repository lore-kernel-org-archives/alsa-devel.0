From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH v2 1/3] ASoC: zx: Add ZTE zx296702 pcm
	support
Date: Fri, 22 May 2015 09:08:51 +0800
Message-ID: <CABymUCMYZP9CQ7gj4XXKVmHZ-5vfsxx=8o6aDGSsoWWREc=Zpg@mail.gmail.com>
References: <1430915885-30656-1-git-send-email-jun.nie@linaro.org>
 <CABymUCNRH13mO0xXBB6tAZokxWhZFE5CxURxpNgoVs+enU240w@mail.gmail.com>
 <20150521200442.GE21577@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f43.google.com (mail-la0-f43.google.com
 [209.85.215.43])
 by alsa0.perex.cz (Postfix) with ESMTP id DB5AE265967
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 03:08:51 +0200 (CEST)
Received: by laat2 with SMTP id t2so2503070laa.1
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 18:08:51 -0700 (PDT)
In-Reply-To: <20150521200442.GE21577@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, "wan.zhijun" <wan.zhijun@zte.com.cn>, Liam Girdwood <lgirdwood@gmail.com>, ZTE-LT Mailman List <zte-lt@lists.linaro.org>
List-Id: alsa-devel@alsa-project.org

2015-05-22 4:04 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Mon, May 18, 2015 at 04:04:30PM +0800, Jun Nie wrote:
>> 2015-05-06 20:38 GMT+08:00 Jun Nie <jun.nie@linaro.org>:
>
>> Do you have any comments on this patch set? Or you suggest to add HDMI
>
> Please don't send pings, they just add to the mail volume.
>
>> API calling in the same serial patch? For the HDMI calling, I have no
>> good idea except direct call currently. Because I need dts hook to
>> audio driver, while no HDMI call back data can be shared from video
>> side to audio side in this independent initialization case.
>
> My previous suggestion was to have a CODEC driver for the HDMI IP - I'm
> not sure why that would require a "direct call"?

I mean I have to direct call HDMI API in HDMI codec driver, is that acceptable?

Jun
