From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH v2 1/3] ASoC: zx: Add ZTE zx296702 pcm
	support
Date: Sat, 23 May 2015 22:41:17 +0800
Message-ID: <CABymUCPXFEcu1cJtwauvy-Yj1eoZ5pXd8fQ0Y3iOJvfJ6LWG4w@mail.gmail.com>
References: <1430915885-30656-1-git-send-email-jun.nie@linaro.org>
 <CABymUCNRH13mO0xXBB6tAZokxWhZFE5CxURxpNgoVs+enU240w@mail.gmail.com>
 <20150521200442.GE21577@sirena.org.uk>
 <CABymUCMYZP9CQ7gj4XXKVmHZ-5vfsxx=8o6aDGSsoWWREc=Zpg@mail.gmail.com>
 <20150522113512.GF21391@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com
 [209.85.215.49])
 by alsa0.perex.cz (Postfix) with ESMTP id C20902604B0
 for <alsa-devel@alsa-project.org>; Sat, 23 May 2015 16:41:17 +0200 (CEST)
Received: by lami4 with SMTP id i4so28582875lam.0
 for <alsa-devel@alsa-project.org>; Sat, 23 May 2015 07:41:17 -0700 (PDT)
In-Reply-To: <20150522113512.GF21391@sirena.org.uk>
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

2015-05-22 19:35 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Fri, May 22, 2015 at 09:08:51AM +0800, Jun Nie wrote:
>> 2015-05-22 4:04 GMT+08:00 Mark Brown <broonie@kernel.org>:
>
>> > My previous suggestion was to have a CODEC driver for the HDMI IP - I'm
>> > not sure why that would require a "direct call"?
>
>> I mean I have to direct call HDMI API in HDMI codec driver, is that acceptable?
>
> I don't know what you mean when you talk about "direct call HDMI API" -
> what is the HDMI API to which you refer here?

Sorry for confusing you. I mean HDMI function in video part. I have to
call ZTE specific HDMI function from ASoC codec driver.

Jun
