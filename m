From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/7] ASoC: Instantiate all DAPM widgets at
	once
Date: Thu, 28 Apr 2011 22:18:30 +0100
Message-ID: <20110428211830.GB18350@opensource.wolfsonmicro.com>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
	<1304009173-5786-7-git-send-email-lars@metafoo.de>
	<20110428200737.GE16837@opensource.wolfsonmicro.com>
	<4DB9CD21.4040707@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C8C51243CA
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 23:18:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DB9CD21.4040707@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 28, 2011 at 10:25:05PM +0200, Lars-Peter Clausen wrote:
> On 04/28/2011 10:07 PM, Mark Brown wrote:

> > ...we can still instantiate widgets at any time, and lots of code will
> > do just that (and needs to do that because it needs the widgets to be
> > present in order to allow paths to be added).

> ... there are exactly 5 codec drivers which call snd_soc_dapm_new_widgets, all
> of them call this at the end of their codec probe callback, which means it can
> be dropped, because the core will call it again just right after the codecs
> probe callback (without this patch).

So it'd seem more sensible to do that, especially if that's what the
changelog says that the change does...  Reading the change the thing
that jumps out is that it's mostly a half done function rename rather
than the change it was described as being.

> Routes can be added just fine without the widgets being instantiated. In fact
> snd_soc_dapm_new_widgets requires the routes to be setup to initialize some
> widgets(mixers,muxs) properly.

Meh, right - wrong way round.
