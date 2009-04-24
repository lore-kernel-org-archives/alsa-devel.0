From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/3] ASoC: cs4270: add Master Playback
	Switch
Date: Fri, 24 Apr 2009 14:54:40 +0100
Message-ID: <20090424135439.GG26440@sirena.org.uk>
References: <1240578026-1987-1-git-send-email-daniel@caiaq.de>
	<1240578026-1987-2-git-send-email-daniel@caiaq.de>
	<20090424131738.GE26440@sirena.org.uk>
	<20090424135216.GF10450@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 51C981038A7
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Apr 2009 15:54:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090424135216.GF10450@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 24, 2009 at 03:52:16PM +0200, Daniel Mack wrote:

> I'll send a new patch for that, providing this feature in a slightly
> more complex fashion. However, I don't want to remove the other
> function. If the soc core decides to mute the codec, it should be able
> to do so.

It's not the core that needs it, it's the DAC that normally needs the
core to mute it (modulo random floating signals that it might parse) -
if cs4270 is happy without the mute then the core doesn't care if it's
not there.
