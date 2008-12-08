From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 4/8] ASoC: TWL4030: DAPM mapping of the
	Earpiece output
Date: Mon, 8 Dec 2008 11:24:56 +0000
Message-ID: <20081208112454.GD5159@sirena.org.uk>
References: <1228723748-22911-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-2-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-3-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-4-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-5-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CC4410382F
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 12:24:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1228723748-22911-5-git-send-email-peter.ujfalusi@nokia.com>
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

On Mon, Dec 08, 2008 at 10:09:04AM +0200, Peter Ujfalusi wrote:

> +static const struct snd_kcontrol_new twl4030_dapm_erapiece_controls =
> +SOC_DAPM_ENUM("Route", twl4030_earpiece_enum);
> +

erapiece?  :)
