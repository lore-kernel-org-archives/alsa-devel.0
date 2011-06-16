From: Johannes Stezenbach <js@sig21.net>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add STA32X codec driver
Date: Thu, 16 Jun 2011 11:12:07 +0200
Message-ID: <20110616091207.GA4829@sig21.net>
References: <1308079626-31239-1-git-send-email-zonque@gmail.com>
	<1308079626-31239-2-git-send-email-zonque@gmail.com>
	<20110615150516.GC2806@opensource.wolfsonmicro.com>
	<20110615205329.GA7445@sig21.net> <4DF9C13A.2000205@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id D4EB510396B
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 11:12:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DF9C13A.2000205@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Daniel Mack <zonque@gmail.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 16, 2011 at 10:39:22AM +0200, Lars-Peter Clausen wrote:
> >> On Tue, Jun 14, 2011 at 09:27:05PM +0200, Daniel Mack wrote:
> >>
> >>> +static const char *sta32x_limiter_drc_attack_thr[] = {
> >>> +	"-31dB", "-29dB", "-27dB", "-25dB", "-23dB", "-21dB", "-19dB", "-17dB",
> >>> +	"-16dB", "-15dB", "-14dB", "-13dB", "-12dB", "-10dB", "-7dB", "-4dB" };
> 
> You can put multiple scale items each with their own min/max value into a TLV.
> For example for DRC attack in your case this would look like:
> 
> static const unsigned int drc_attack_tlv[] = {
> 	TLV_DB_RANGE_HEAD(3),
> 	0, 7, TLV_DB_SCALE_ITEM(-3100, 200, 0),
> 	8, 13, TLV_DB_SCALE_ITEM(-1600, 100, 0),
> 	14, 16, TLV_DB_SCALE_ITEM(-1000, 300, 0),
> };

That looks indeed much better than using enums.

Thanks,
Johannes
