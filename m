From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: wm8731: set the ACTIVE bit if bias
	ON entered
Date: Mon, 4 Jul 2011 18:34:10 +0100
Message-ID: <4E11F992.6080506@ti.com>
References: <ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
	<1309517034-26110-1-git-send-email-nicolas.ferre@atmel.com>
	<20110701161506.GC23784@opensource.wolfsonmicro.com>
	<4E118BF6.6010205@atmel.com>
	<20110704172856.GF28726@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 934FE103868
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 19:34:14 +0200 (CEST)
In-Reply-To: <20110704172856.GF28726@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 04/07/11 18:29, Mark Brown wrote:
> On Mon, Jul 04, 2011 at 11:46:30AM +0200, Nicolas Ferre wrote:
> 
>> Ah, ok... but I fear that I do not know the whole system enough for this
>> addition ;-(
>> Do you think you can code this modification, I will be happy to test it,
>> if you want...
> 
> It's pretty trivial - try the below (Liam, are you OK with this if it
> tests OK?):
> 

All fine by me, It's been so long I've forgotten most things about the WM8731 now ;)
