From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Hide TLV320AIC26 configuration
	option for	non-OpenFirwmare users
Date: Mon, 13 Oct 2008 19:14:58 +0100
Message-ID: <20081013181458.GA23014@opensource.wolfsonmicro.com>
References: <1223915914-12196-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5h1vykv1rm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AA4A024599
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Oct 2008 20:15:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h1vykv1rm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 13, 2008 at 07:33:01PM +0200, Takashi Iwai wrote:

> Hmm, I'm afraid this may disable CONFIG_SND_SOC_TLV320AIC26 when
> CONFIG_SND_SOC_OF_SIMPLE=n automatically, no?

Yes, I'd feared that too but it doesn't do that, at least not in my
testing - the dependencies are just completely ignored.

> > Thanks to Takashi for the suggestion.

> Actually I proposed a wrong solution.  What I meant was the form using
> "if" instead of "depends on":

> config SND_SOC_TLV320AIC26
>  	tristate "TI TLV320AIC26 Codec support" if SND_SOC_OF_SIMPLE
> 	...

> In this way, the selectable item appears only when
> CONFIG_SND_SOC_OF_SIMPLE is set.  The other dependencies remain as
> they are.

Ah, yes.  That seems to work too and is a bit neater, though still a bit
nasty since it looks like the tristate is conditional on the
OpenFirmware support now so it's still not entirely clear that the right
thing will happen.  Updated patch coming in a moment.
