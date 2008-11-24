From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 5/9] ASoC: TWL4030: Add PreDriv outupt mux
	and volume controls
Date: Mon, 24 Nov 2008 13:48:09 +0000
Message-ID: <20081124134808.GB22394@sirena.org.uk>
References: <1227527383-22516-1-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-2-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-3-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-4-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-5-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-6-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DA3B324415
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 14:48:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1227527383-22516-6-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 24, 2008 at 01:49:39PM +0200, Peter Ujfalusi wrote:

> +static const char *twl4030_predrivl_mix[] = {"Off", "Voice", "DACL1",
> +					    "DACL2", "DACR2"};
> +static const char *twl4030_predrivr_mix[] = {"Off", "Voice", "DACR1",
> +					    "DACR2", "DACL2"};

> +static const struct soc_enum twl4030_enum[] = {

I know quite a few existing drivers use an array of enums but please
don't do this for new code - it doesn't help legibility to have to find
the enums in the table.

> +	SOC_ENUM_SINGLE(TWL4030_REG_PREDL_CTL, 0, 5, twl4030_predrivl_mix),
> +	SOC_ENUM_SINGLE(TWL4030_REG_PREDR_CTL, 0, 5, twl4030_predrivr_mix),
> +};

Is this really an enum?  The fact that it's described as a mixer and
it's got a series of individual bits for selecting the inputs make it
sound like it should be possible to enable multiple inputs at once in
which case this should be a series of switches - see SND_SOC_DAPM_MIXERs
in other drivers for examples.  If it's really an enum then calling it a
mux is probably better.

Another issue is that it might be better to add these as DAPM controls
now rather than have to move them to be DAPM controls later.  If you use
SND_SOC_NOPM for the power bit then DAPM won't actually do any power
control, it'll just expose the control.

These comments apply to the other patches in the series.
