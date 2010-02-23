From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsi: Modify over/under run error
 settlement
Date: Tue, 23 Feb 2010 10:46:01 +0000
Message-ID: <20100223104600.GD14629@rakim.wolfsonmicro.main>
References: <ubpfh678q.wl%morimoto.kuninori@renesas.com>
	<20100222101421.GA27789@sirena.org.uk>
	<ur5ocae02.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4F8CE1038E9
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 11:46:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ur5ocae02.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 23, 2010 at 11:21:17AM +0900, Kuninori Morimoto wrote:

> Sorry. I should have explained details.

> In current FSI driver, playback function cares only overrun,
> and capture function cares only underrun.

> But playback function should had cared about underrun,
> and capture function should had cared about overrun too.

> My patch modify playback/capture to care both overrun and underrun

OK - I've applied the patch with the above explanation added to the
commit message.  Thanks.
