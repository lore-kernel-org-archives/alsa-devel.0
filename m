From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: RFC: new TLV types for dB range with min/max
Date: Fri, 19 Jun 2009 10:33:46 +0100
Message-ID: <20090619093345.GB5270@sirena.org.uk>
References: <s5hocskekcm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 62ED8244B7
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 11:33:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hocskekcm.wl%tiwai@suse.de>
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

On Fri, Jun 19, 2009 at 09:47:05AM +0200, Takashi Iwai wrote:

> Since the step size may have a rounding error, this can accumulate to
> a significant amount at the max value.

> A simple way to avoid this is to just give min and max values instead
> of min and step values, and interpolate the middle.  For that, I
> create two new TLV types.

This is a good idea - it is also helpful for some of the ASoC devices
which have dB scales with steps with 3 decimal places of resolution,
using this makes writing the driver a bit easier.  Thanks for doing it.
