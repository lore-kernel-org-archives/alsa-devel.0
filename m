From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [RFC] [PATCH] asoc tlv320aic3x: revisit clocking
 setup
Date: Fri, 25 Apr 2008 10:44:08 +0300
Message-ID: <20080425104408.fe6018de.jarkko.nikula@nokia.com>
References: <20080424145437.GA10882@buzzloop.caiaq.de>
	<20080424152136.GB10882@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 914F0103839
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 09:43:39 +0200 (CEST)
In-Reply-To: <20080424152136.GB10882@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Daniel Mack <daniel@caiaq.org>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 24 Apr 2008 17:21:36 +0200
"ext Daniel Mack" <daniel@caiaq.org> wrote:

> On Thu, Apr 24, 2008 at 04:54:37PM +0200, Daniel Mack wrote:
> > attached is a patch that reworks the clocking setup for the aic3x
> > codec. It drops the dividers table and calculates the values
> > instead. When simulated, this code does the right thing for all the
> > examples described in the datasheet. Please review and let me know
> > about any concerns.
> 
> Same thing again, but some more comments.
> 
Hi

This is great work, calculates correct PLL values for my platform when
using 12/19.2 MHz @ 44.1 and 48 kHz and takes into account issues we've
been discussing before.

Here are my review comments:

+	if (bypass_pll) {
+		pll_q &= 0xf;
+		aic3x_write(codec, AIC3X_SAMPLE_RATE_SEL_REG, 0);

This is redundant write since register is updated below.

+	if (params_rate(params) >= 88200)
+		data |= DUAL_RATE_MODE;
 	aic3x_write(codec, AIC3X_CODEC_DATAPATH_REG, data);
 
Dual rate mode should be set when rate is >= 64000 kHz.

 	/* codec sample rate select */
-	data = aic3x_divs[i].sr_reg;
+	data = (fsref * 10) / params_rate(params);
+	data /= 5;
+	data -= 2;
 	data |= (data << 4);
 	aic3x_write(codec, AIC3X_SAMPLE_RATE_SEL_REG, data);

Note result here is 0xFF if rate is >= 64000 kHz. Will calculate
correctly if fsref is doubled for those cases.

+	codec_clk = (2048 * fsref) / (aic3x->sysclk / 1000);
+
+	if (params_rate(params) >= 88200)
+		fsref *= 2;

Here also 64000. Remember to take into account doubled fsref when
calculating codec_clk if you move it before sample rate selection.

Otherwise patch looks good to me.


Jarkko
