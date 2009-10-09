From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH - try2] ASoC: TPA6130A2 amplifier driver
Date: Fri, 9 Oct 2009 18:19:42 +0100
Message-ID: <20091009171941.GA20083@sirena.org.uk>
References: <1255092941-17586-1-git-send-email-peter.ujfalusi@nokia.com>
	<1255093831.30157.207.camel@eenurkka-desktop>
	<200910091636.16126.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DFA7C243CD
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 19:19:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200910091636.16126.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 09, 2009 at 04:36:16PM +0300, Peter Ujfalusi wrote:

> Well it is very unlikely that something like this could ever happen since the 
> tpa6130a2_channel_enable and the tpa6130a2_power is called when DAPM is 
> enabling/disabling the path. I think in a middle of enable or disable there 
> should not be any opposite operation running in DAPM...

DAPM guarantees single threadedness - DAPM itself would get confused if
there were more than one power update in progress at once.
