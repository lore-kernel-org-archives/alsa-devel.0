From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: TWL4030: Add AVADC Clock Priority
Date: Fri, 19 Jun 2009 11:00:16 +0100
Message-ID: <20090619100016.GE5270@sirena.org.uk>
References: <67059DBF19D7214F9C66BB0EA91BA90E3543F31D@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 43B2A10389D
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 12:00:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E3543F31D@dlee04.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 19, 2009 at 03:23:42AM -0500, Lopez Cruz, Misael wrote:

> +/* AVADC clock priority */
> +static const char *twl4030_avadc_clk_priority_texts[] = {
> +	"Voice high priority", "Audio high priority"
> +};
> +

It'd probably be better to say "Hifi" (or whatever spelling the rest of
the driver uses) rather than "Audio" here.  Audio is a bit confusing
since obviously the voice data is audio data too, it's just a different
path through the CODEC with different characteristics.  The same thing
has been done elsewhere in the driver.
