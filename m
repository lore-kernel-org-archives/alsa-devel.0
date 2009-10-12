From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 6/8] RX-51: Audio: Add usage of regulator
 framework to control VMMC2
Date: Mon, 12 Oct 2009 12:04:55 +0300
Message-ID: <20091012090455.GC13234__2924.46911703355$1255339061$gmane$org@esdhcp037198.research.nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-7-git-send-email-eduardo.valentin@nokia.com>
	<20091008132619.GE29176@rakim.wolfsonmicro.main>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20091008132619.GE29176@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Tony Lindgren <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 08, 2009 at 03:26:19PM +0200, Mark Brown wrote:
> On Thu, Oct 08, 2009 at 02:58:55PM +0300, Eduardo Valentin wrote:
> 
> > +static struct regulator_consumer_supply rx51_vmmc2_supplies[] = {
> > +	REGULATOR_SUPPLY("avdd_dac", "2-0018"), /* tlv320aic3x */
> > +	REGULATOR_SUPPLY("vdd", "2-0060"), /* tpa6130a2*/
> >  };
> 
> avdd_dac is the only supply added for the tlv320aic3x but, for example,
> the tlv320aic34 has something like 8 supplies from a quick scan of the
> datasheet.  It'd be better to set up all of the supplies, even if only
> with a fixed voltage regulator supplying them, since when regulator
> support is added to the CODEC driver it should be requesting all the
> supplies it needs and therefore fail to instatiate if some are missing.

Right. Should we add 4 instances of drvdd and 2 of iovdd? So, naming those would be like:

	REGULATOR_SUPPLY("drvdd0", "2-0018"), /* tlv320aic3x */
	REGULATOR_SUPPLY("drvdd1", "2-0018"), /* tlv320aic3x */
	REGULATOR_SUPPLY("drvdd2", "2-0018"), /* tlv320aic3x */
	REGULATOR_SUPPLY("drvdd3", "2-0018"), /* tlv320aic3x */

or even better:

	REGULATOR_SUPPLY("drvdd_b4", "2-0018"), /* tlv320aic3x */
	REGULATOR_SUPPLY("drvdd_a4", "2-0018"), /* tlv320aic3x */
	REGULATOR_SUPPLY("drvdd_b9", "2-0018"), /* tlv320aic3x */
	REGULATOR_SUPPLY("drvdd_a9", "2-0018"), /* tlv320aic3x */

what do you think?

BR

-- 
Eduardo Valentin
