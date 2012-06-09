From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: wm8903: disable mic detect irqs
	until jack registered
Date: Fri, 08 Jun 2012 22:31:43 -0600
Message-ID: <4FD2D1AF.4020101@wwwdotorg.org>
References: <1339177075-20506-1-git-send-email-swarren@wwwdotorg.org>
	<20120609013154.GA3924@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 242E2103F49
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Jun 2012 06:31:46 +0200 (CEST)
In-Reply-To: <20120609013154.GA3924@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 06/08/2012 07:31 PM, Mark Brown wrote:
> On Fri, Jun 08, 2012 at 11:37:54AM -0600, Stephen Warren wrote:
> 
>> This problem can be triggered by fully initializing an audio
>> card, then removing and re-inserting the machine driver module.
>> This would leave mic detection enabled in HW, and mic_jack set to
>> a stale value.
> 
> This isn't a good fix for this issue, - the fact that it works is
> more a sign that nobody got round to moving the interrupt
> registration to the I2C probe() function than anything else.
...
> In terms of the mic detection itself it's really the responsibility
> of the machine driver to say that the jack doesn't exist any more
> when it's being removed - it should be calling wm8903_mic_detect()
> again during unregistration to disable the interrupt. ...

OK, that makes sense. I guess I can do that in the card's .remove()
function. I'd shied away from doing that before since the jacks are
created in the DAI link's init() function, and there wasn't a
symmetrical DAI link remove() function to match that, but the card
remove() should be fine.
