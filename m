From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] pinctrl: madera: Fix uninitialized variable issue in
 madera_mux_set_mux
Date: Wed, 10 Oct 2018 16:58:05 +0200
Message-ID: <69b40c51-b9db-4193-81ec-3e1970ced983@embeddedor.com>
References: <20181010141353.GA14382@embeddedor.com>
 <20181010143340.GA1653@imbe.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010143340.GA1653@imbe.wolfsonmicro.main>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>, Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Charles,

> I don't believe this would fully address the issue since if you
> initialise ret to -1 you will still drop into the if statement
> and you will use the reg variable which should also be
> uninitialised on that code path.
> 
> Feels like initialising to 0 would probably be better anyway
> since the code path looks like the case were you have n_pins == 0
> and nothing really failed in that case just nothing needed to be
> done.
> 

You're right. I got confused with another similar issue I fixed, recently.

I'll send v2 shortly.

Thanks for the feedback.
--
Gustavo
