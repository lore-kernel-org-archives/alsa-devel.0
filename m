From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.30
Date: Wed, 18 Feb 2009 12:37:20 +0000
Message-ID: <20090218123720.GB11336@opensource.wolfsonmicro.com>
References: <20090218120135.GA15414@sirena.org.uk>
	<s5hiqn8vsz4.wl%tiwai@suse.de> <s5hhc2svssv.wl%tiwai@suse.de>
	<s5heixwvske.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AEA4010388D
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 13:37:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5heixwvske.wl%tiwai@suse.de>
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

On Wed, Feb 18, 2009 at 01:27:13PM +0100, Takashi Iwai wrote:

> ... and pxa/* drivers don't build.  Missing i2c updates?

Yes, I'll send a patch shortly.

I've never been able to get the underlying platform support for those
machines to build, could you send me the .config you're using for
testing, please?  It's possible that they've been fixed since I last
tried, I know people have been working on them a bit.
