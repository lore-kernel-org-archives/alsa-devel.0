From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/8] McBSP: OMAP3: Add Sidetone feature
Date: Thu, 8 Oct 2009 14:17:02 +0100
Message-ID: <20091008131702.GC29176__32454.485706012$1255008001$gmane$org@rakim.wolfsonmicro.main>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-4-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1255003137-1034-4-git-send-email-eduardo.valentin@nokia.com>
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
Cc: ext Tony Lindgren <tony@atomide.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 08, 2009 at 02:58:52PM +0300, Eduardo Valentin wrote:

> +static const struct attribute *sidetone_attrs[] = {
> +	&dev_attr_st_enable.attr,
> +	&dev_attr_st_taps.attr,
> +	&dev_attr_st_ch0gain.attr,
> +	&dev_attr_st_ch1gain.attr,
> +	NULL,
> +};

This stuff, particularly the enable, probably wants to be pushed out via
an ALSA API rather than via random sysfs stuff.  It'd be better to
publish a control API here and then use that from within ALSA.
