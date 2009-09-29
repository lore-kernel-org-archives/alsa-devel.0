From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: SND_SOC_DAPM_LINE behavior
Date: Tue, 29 Sep 2009 13:44:40 +0100
Message-ID: <20090929124439.GA8632@rakim.wolfsonmicro.main>
References: <200909291536.39792.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 53E1C10387C
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Sep 2009 14:44:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200909291536.39792.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 29, 2009 at 03:36:39PM +0300, Peter Ujfalusi wrote:

> The DAPM routing is something like this in the codec driver:

> |DAC|------------->|              |              
>                    |Playback Mixer|->|OUTPUT|
> |INPUT|->|Bypass|->|              |
>          |SWITCH|

> Now if in the machine driver I create the following DAPM widget:
> SND_SOC_DAPM_LINE("Line In", NULL),

> and than connect this DAPM_LINE to the codec's INPUT (LINE-IN):
> {"LINE-IN", NULL, "Line In"},

> Than the codec bias level would be always in ON state, regardless of the state 
> of the Bypass Switch (it is off by default).

That shouldn't happen, turning off the bypass switch should break the
path and let the bias sit at standby.  I'd need to check the code but I
expect that the fact that LINE can be either an input or an output is
confusing things and we need to split it into two widgets, one for input
and one for output.

The easiest thing for an actual system would just be to not bother with
the external widget if you're not doing anything with it.  It'll only
make things work better, there's no need for the external widgets unless
you're switching them.
