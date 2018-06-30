From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH RFC] ASoC: pxa-ssp: remove .set_pll() and
	.set_clkdiv() callbacks
Date: Sat, 30 Jun 2018 17:26:03 +0200
Message-ID: <876020i9dg.fsf@belgarion.home>
References: <20180629125940.27359-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr
 [80.12.242.129])
 by alsa0.perex.cz (Postfix) with ESMTP id 1771726735C
 for <alsa-devel@alsa-project.org>; Sat, 30 Jun 2018 17:26:04 +0200 (CEST)
In-Reply-To: <20180629125940.27359-1-daniel@zonque.org> (Daniel Mack's message
 of "Fri, 29 Jun 2018 14:59:40 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, haojian.zhuang@gmail.com, philipp.zabel@gmail.com
List-Id: alsa-devel@alsa-project.org

Daniel Mack <daniel@zonque.org> writes:

>
> I'd appreciate some review of this one. The only PXA3xx based platform
> I have access to uses the EXTCLK clocking source, but this patch
> changes the way the internal audio PLL works. Hence, I could only
> complile-test it for now.

If the zylonite platform is a target, I can try. Nevertheless, I'd be inclined
to use the approach "merge first, fix if there are regressions next".

I must admit that due to hot weather conditions in south France, and the
electrical outages, my inverter decided to commit suicide ... As a true hero, he
protected my boards, but now I must order a new one before attempting to use my
lubbock/mainstone/zylonite again.

Cheers.

--
Robert
