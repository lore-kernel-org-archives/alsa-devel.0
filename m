From: Howard Mitchell <hm@hmbedded.co.uk>
Subject: Re: [PATCH] ASoC: pcm512x: Remove hardcoding of
	pll-lock to GPIO4
Date: Tue, 24 Mar 2015 10:10:35 +0000
Message-ID: <5511381B.8030709@hmbedded.co.uk>
References: <1427145421-5544-1-git-send-email-hm@hmbedded.co.uk>
 <80347e73030a4e31b9765defd4f6ff5a@EMAIL.axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avasout05.plus.net (avasout05.plus.net [84.93.230.250])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FC74260418
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 11:13:14 +0100 (CET)
In-Reply-To: <80347e73030a4e31b9765defd4f6ff5a@EMAIL.axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@axentia.se>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 24/03/15 07:52, Peter Rosin wrote:
> Howard Mitchell wrote:
>> Currently GPIO4 is hardcoded to output the pll-lock signal.
>> Unfortunately this is after the pll-out GPIO is configured which
>> is selectable in the device tree. Therefore it is not possible to
>> use GPIO4 for pll-out. Therefore this patch removes the
>> configuration of GPIO4.
> Howard, thanks for picking up my laundry!
No problem. It was pretty quick and easy to redo from my previous patch 
anyway.
> Is master mode working for you otherwise? Have you seen any sign
> of bad dividers for the various clocks, or anything like that?
Not so far. I've run though all the sampling rates from 44.1KHz to 
192KHz with a 24.576MHz input clock and they all sounded ok. I haven't 
done the maths and checked every single divider setting but I think I 
would have heard if something wasn't quite right.
> Regarding the pin configuration, I suppose the cleanest approach
> would be to implement it as a pin control driver? Then you could
> also expose the pins as gpios and  select the pin functions in a more
> standard way, right? I wouldn't know where to start with that
> though. I have the feeling that it would also mean that there would
> have to be a mfd driver for the chip???
Yes that would allow userspace access as well. I guess a good place to 
start would be one of the I2C gpio expanders: 
.../drivers_/_gpio_/_gpio-pca953x.c for instance.
> However, there is the issue that we don't need anything more from
> the chip, so we're happy with the driver as is (assuming the overclocking
> patch goes in as planned for 4.1).
On our board the additional gpios are not even tracked out so the driver 
is fine as is for now. For the future we have discussed the possibility 
of providing two master clock oscillators to avoid using the pll 
altogether. In this case one of the gpios could be used for switching.

- Howard
