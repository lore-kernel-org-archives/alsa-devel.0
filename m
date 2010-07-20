From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH - alsa-lib 2/3] tlv: Handle 'holes' in
 SND_CTL_TLVT_DB_RANGE array
Date: Tue, 20 Jul 2010 09:32:25 +0100
Message-ID: <20100720083225.GA10222@rakim.wolfsonmicro.main>
References: <1279523646-4987-1-git-send-email-peter.ujfalusi@nokia.com>
	<1279523646-4987-3-git-send-email-peter.ujfalusi@nokia.com>
	<s5heiezfp1c.wl%tiwai@suse.de>
	<20100719160109.GC7002@sirena.org.uk>
	<s5h630bfo3x.wl%tiwai@suse.de>
	<20100719162416.GD7002@sirena.org.uk>
	<s5h39vffmkw.wl%tiwai@suse.de>
	<20100719170947.GA5950@rakim.wolfsonmicro.main>
	<s5hbpa3z5lz.wl%tiwai@suse.de> <4C45413C.10909@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 75ADD24575
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 10:32:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C45413C.10909@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 20, 2010 at 08:25:00AM +0200, Clemens Ladisch wrote:
> Takashi Iwai wrote:

> > Well, what I don't feel right is that this breaks the simpleness of
> > DB_RANGE handling.  It's just damn simple, and works as long as the
> > target point is covered by defined ranges.  If something is wrong,
> > it's the definition, not the parser.  That's why I wondered first
> > whether it can't be fixed in the driver side.

> As a driver writer, I would intuitively assume that the ranges must
> not be overlapping.  If we require all drivers to get this right,
> there will likely be new ones that don't.

This is exactly what happened with all the ASoC drivers - it never even
occurred to me that it might be sensible to overlap the ranges.  It's
not at all obvious, like I've said the drivers are basically providing a
data table.
