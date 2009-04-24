From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 2/3] ASoC: cs4270: add Master Playback
	Switch
Date: Fri, 24 Apr 2009 15:52:16 +0200
Message-ID: <20090424135216.GF10450@buzzloop.caiaq.de>
References: <1240578026-1987-1-git-send-email-daniel@caiaq.de>
	<1240578026-1987-2-git-send-email-daniel@caiaq.de>
	<20090424131738.GE26440@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id C6D4B1038A7
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Apr 2009 15:52:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090424131738.GE26440@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 24, 2009 at 02:17:38PM +0100, Mark Brown wrote:
> On Fri, Apr 24, 2009 at 03:00:26PM +0200, Daniel Mack wrote:
> > This new control exports cs4270's DAC MUTE capabilities.
> 
> The DAC mute is controled by cs4270_mute function - DAC mute is handles
> specially since many CODECs want to have mute synchronised with power
> down of the DAC.  If cs4270 doesn't need this then remove the DAI
> operation too.

Well, what I'm willing to implement is a way to manually mute the codec
while it is running, independendly from other ways.

I've seen that dai function and untruly believed that those two ways
could peacefully co-exist. But as it turns out, they currently influence
each other, and a manually set mute will be overridden by the next
stream start via the dai function. Which is bad.

I'll send a new patch for that, providing this feature in a slightly
more complex fashion. However, I don't want to remove the other
function. If the soc core decides to mute the codec, it should be able
to do so.

Daniel
