From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Any wigets for ADC to DAC ?
Date: Mon, 31 Mar 2008 11:24:32 +0100
Message-ID: <20080331102431.GB21135@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D854B24760
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Mar 2008 12:24:35 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexandre BOUIN <a.bouin@kerlink.fr>
Cc: 'ALSA-devel' <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 28, 2008 at 04:39:48PM +0100, Alexandre BOUIN wrote:

> In intern, we're still using WM8900 codec. We'd like to know in ASoC layer,
> there is a widget to declare a possible audio path between ADC and DAC.

If there were a direct connection the appropriate thing would just be to
declare it (in that particular chip there is actually a digitial mixer
in there).  Using such a path is not particularly supported by ASoC v1
since it treats ADCs and DACs as sinks and sources only.
