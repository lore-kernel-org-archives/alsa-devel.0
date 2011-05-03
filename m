From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v2] ASoC: soc-cache: block based
 rbtree	compression
Date: Tue, 3 May 2011 12:02:06 +0100
Message-ID: <20110503110205.GE1762@opensource.wolfsonmicro.com>
References: <1304339309-28820-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<s5hoc3lrxaq.wl%tiwai@suse.de>
	<20110502144256.GA1656@opensource.wolfsonmicro.com>
	<s5hk4e9rwfm.wl%tiwai@suse.de>
	<20110502145814.GB1844@opensource.wolfsonmicro.com>
	<20110503094319.GA27833@sirena.org.uk>
	<s5h4o5crrux.wl%tiwai@suse.de>
	<20110503104701.GD1762@opensource.wolfsonmicro.com>
	<s5hzkn4qcro.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0FD25103815
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 13:02:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzkn4qcro.wl%tiwai@suse.de>
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

On Tue, May 03, 2011 at 12:50:03PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > This isn't about CPU usage, it's about I/O bandwidth which is a big
> > concern in situations like resume where you can be bringing the device
> > back up from cold.

> Hm, but how do these patches achieve it?  I see no change in the I/O
> access side.

There's none directly but we need to get the data into blocks before we
can do bulk I/O (or do complicated gather bulk I/O).

> > CPU usage isn't really that much of an issue; we need to burn an awful
> > lot of CPU for it to take longer than the I/O takes.

> Yes, that's why I've been asking it...

We're talking I2C here so you're looking at 400kHz contended buses for
the I/O, though of course optimisations in CPU usage are also useful.
