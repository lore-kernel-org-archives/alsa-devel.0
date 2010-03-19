From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] ASoC: tlv320dac33: DSP mode and
 clocking updates
Date: Fri, 19 Mar 2010 11:21:27 +0000
Message-ID: <20100319112127.GC23306@rakim.wolfsonmicro.main>
References: <1268989820-18262-1-git-send-email-peter.ujfalusi@nokia.com>
	<1268991483.3757.14.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B56EB1038BA
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 12:21:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1268991483.3757.14.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 19, 2010 at 09:38:03AM +0000, Liam Girdwood wrote:
> On Fri, 2010-03-19 at 11:10 +0200, Peter Ujfalusi wrote:

> > tlv320dac33 can not support DSP_B mode since the data delay can not be set to be
> > actually 0. Only DSP_A mode can be supported, so fix the DSP_A mode, and remove
> > the DSP_B.

> > The original internal clock distribution config has been found to be not
> > optimal, so fix that as well.

> Both

> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

...and applied for 2.6.34, thanks.
