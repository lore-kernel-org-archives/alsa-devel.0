From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ARM: EXYNOS4: Add PCM audio support for WM8994
Date: Tue, 26 Apr 2011 10:37:20 +0530
Message-ID: <BANLkTimhsJtU5zgKmRjEK+2BvW-nZfisCg@mail.gmail.com>
References: <1303714472-2391-1-git-send-email-sbkim73@samsung.com>
	<1303714472-2391-3-git-send-email-sbkim73@samsung.com>
	<BANLkTik2uTae-V1MQ_Owj_jC=x14W4HgwA@mail.gmail.com>
	<007f01cc03b6$8e165060$aa42f120$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <007f01cc03b6$8e165060$aa42f120$@com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org, kgene.kim@samsung.com, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 26, 2011 at 7:36 AM, Sangbeom Kim <sbkim73@samsung.com> wrote:
> Hi Jassi,
>
> Thanks for your advisor.
> Currently, Only Exynos4210 pcm block is different.
> And There is no rule to design in Future AP.
> I will discuss with ap design team and try to
> change pcm block like a previous one for the future AP.
> Because, I think that it is more desirable to include
> SCLK divider in the pcm block like old Samsung APs.
> So, In the exynos4 case, I want to handle it by quirk.
> What do you think about my opinion?

Ok. If the block is not going to change for sure, maybe
handling by quirk is ok.
