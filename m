From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/5] ASoC: wm8731: rework power management
Date: Fri, 01 Jul 2011 11:31:45 +0200
Message-ID: <4E0D9401.1070300@atmel.com>
References: <1309370419-22810-1-git-send-email-nicolas.ferre@atmel.com>
	<ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
	<20110629171148.GB10798@opensource.wolfsonmicro.com>
	<4E0C80B8.7030006@atmel.com>
	<20110630152203.GB3249@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FAD91037FB
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jul 2011 11:31:55 +0200 (CEST)
In-Reply-To: <20110630152203.GB3249@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, lrg@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Le 30/06/2011 17:22, Mark Brown :
> On Thu, Jun 30, 2011 at 03:57:12PM +0200, Nicolas Ferre wrote:
> 
> Please fix your mailer to line wrap within paragraphs.
> 
>> First of all, I experienced issues while not having OSC enabled during
>> suspend/resume cycle. Am I right supposing that, if using oscillator
>> to clock the codec, I have to keep it running during a suspend/resume
>> cycle?
> 
> No, not at all.  What makes you believe that you would you need to do
> that?

Ok, I re-tested and for sure I was totally wrong! So we forget this part
of the patch.
I guess that this belief may come from my first implementation on 2.6.35
where OSC was not part of the DAPM... Sory for the noise.

I repost the "active bit" part real-soon-now.

Thanks for your help, best regards,
-- 
Nicolas Ferre
