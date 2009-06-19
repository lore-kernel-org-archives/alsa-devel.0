From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] New ASoC Drivers for ADI AD1938 codec
Date: Fri, 19 Jun 2009 12:56:13 +0100
Message-ID: <FD8E5377-D9B2-4876-8A82-F2E29BA3B2E4@opensource.wolfsonmicro.com>
References: <1245403695-20537-1-git-send-email-21cnbao@gmail.com>
	<20090619104738.GF5270@sirena.org.uk>
	<8bd0f97a0906190405k33503d8ekd74ec9ddbb2fde12@mail.gmail.com>
	<A40FAF28-889C-4322-A114-098EEA56FCE6@opensource.wolfsonmicro.com>
	<8bd0f97a0906190421q332f337cr1799c6b65bd06f0e@mail.gmail.com>
	(sfid-20090619_122210_786837_40A5C757)
Mime-Version: 1.0 (iPhone Mail 7A341)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3CB30244FD
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 13:56:31 +0200 (CEST)
In-Reply-To: <8bd0f97a0906190421q332f337cr1799c6b65bd06f0e@mail.gmail.com>
	(sfid-20090619_122210_786837_40A5C757)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Barry Song <21cnbao@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 19 Jun 2009, at 12:21, Mike Frysinger <vapier.adi@gmail.com> wrote:

> On Fri, Jun 19, 2009 at 07:13, Mark Brown wrote:
>>>>
>>>
>>>
>>
>>>>
>>>>
>>>
>> Yes. It is needed in order to specify how things are hooked up on a  
>> given
>> board.
>
> to look at the wm8731 then, these are good examples of how it's done ?
> sound/soc/atmel/sam9g20_wm8731.c
> sound/soc/pxa/corgi.c

Anything should be OK - possibly one of the existing Blackfin drivers.  
I mentioned wm8731 due to the SPI but by the time it gets to the  
machine driver that's hidden so it's not urgently relevant.
