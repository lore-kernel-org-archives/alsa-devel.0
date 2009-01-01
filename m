From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Control interconnection information API?
Date: Thu, 1 Jan 2009 11:43:44 +0000
Message-ID: <20090101114343.GB6888@sirena.org.uk>
References: <495BF9DB.2060202@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 52E8C10381B
	for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2009 12:43:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <495BF9DB.2060202@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 01, 2009 at 12:01:47PM +1300, Eliot Blennerhassett wrote:

> * ASoC DAPM (which I (not being an ASoC developer or user) have mostly
> been skimming over in this list).

> Reading this
> http://www.mjmwired.net/kernel/Documentation/sound/alsa/soc/dapm.txt
> 3. Codec Widget Interconnections. I can see that there are lists of
> connections.  I'm not sure if these are visible to userspace via any API?

These are not visible to user space and the information provided is not
at all complete - as well as DAPM controls (used for power management)
most devices will also have a number of regular ALSA controls which
aren't tied in with the path information yet.  It's been at the back of
my mind to let drivers do that but it's not particularly near the top of
my list.

> Can either of these schemes be generalised to all ALSA drivers?
> Is there some other way to reveal the information (Connections TLV, new
> API etc?)

Anything that works for ASoC should be able to work for all ALSA
drivers, though since there's nothing there yet it's probably not
particularly useful for you right now.

> Does anybody else thing this is worth pursuing, or is it just me?

Yes, it'd definitely be useful for ASoC.  One of the issues with ASoC at
the minute is that embedded codecs (especially audio hub codecs) can
have a very large number of controls and having the interconnection
information availiable in mixer user interfaces would help users work
with them.

Even with just the existing power information it'd still be a win.
