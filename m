From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v2] ASoC: soc-cache: block based	rbtree
	compression
Date: Tue, 3 May 2011 14:51:28 +0100
Message-ID: <20110503135117.GA2893@sirena.org.uk>
References: <20110503094319.GA27833@sirena.org.uk>
	<s5h4o5crrux.wl%tiwai@suse.de>
	<20110503104701.GD1762@opensource.wolfsonmicro.com>
	<s5hzkn4qcro.wl%tiwai@suse.de>
	<20110503110205.GE1762@opensource.wolfsonmicro.com>
	<s5hliyoq8d3.wl%tiwai@suse.de>
	<20110503130259.GK1762@opensource.wolfsonmicro.com>
	<s5hhb9brkg8.wl%tiwai@suse.de>
	<20110503132420.GM1762@opensource.wolfsonmicro.com>
	<s5hd3jzrjsw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C3FF1038B6
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 15:51:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hd3jzrjsw.wl%tiwai@suse.de>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, May 03, 2011 at 03:32:47PM +0200, Takashi Iwai wrote:

> Hrm, then I don't understand why changing the cache management changes
> the bulk I/O behavior as you described.  What's missing there?

If we can't get the data laid out in a contiguous array in memory then
we have to gather the data for transmit in the I/O code which is
painful and wasteful.  As I say for other cache formats this isn't an
issue.
