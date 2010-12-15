From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2.1 0/3] ASoC: Extend DAPM to handle
 cross-device paths
Date: Wed, 15 Dec 2010 18:14:08 +0000
Message-ID: <20101215181408.GE9275@rakim.wolfsonmicro.main>
References: <1292321912-24765-1-git-send-email-jhnikula@gmail.com>
	<1292342268.3316.18.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2FF272459E
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 19:14:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1292342268.3316.18.camel@odin>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 14, 2010 at 03:57:48PM +0000, Liam Girdwood wrote:
> On Tue, 2010-12-14 at 12:18 +0200, Jarkko Nikula wrote:

> > Last time there were discussion about special n_widgets casing for
> > non-DAPM codecs. Mark suggested to drop them but they are still here as I
> > don't want to break boards having non-DAPM codec with bias control and that
> > casing is trivial to drop when not needed anymore.

I'm pretty sure we just want to make DAPM mandatory here, it's a bunch
of extra code fixing these devices up around the core algorithms which
gets very little testing.

> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Applied, thanks.
