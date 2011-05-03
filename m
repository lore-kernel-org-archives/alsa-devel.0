From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v2] ASoC: soc-cache: block based rbtree
 compression
Date: Tue, 3 May 2011 16:40:43 +0100
Message-ID: <20110503154043.GW1762@opensource.wolfsonmicro.com>
References: <20110503130259.GK1762@opensource.wolfsonmicro.com>
	<s5hhb9brkg8.wl%tiwai@suse.de>
	<20110503132420.GM1762@opensource.wolfsonmicro.com>
	<s5hd3jzrjsw.wl%tiwai@suse.de>
	<20110503135117.GA2893@sirena.org.uk>
	<s5h8vunri6p.wl%tiwai@suse.de>
	<20110503142729.GP1762@opensource.wolfsonmicro.com>
	<s5h4o5breqj.wl%tiwai@suse.de>
	<20110503152405.GV1762@opensource.wolfsonmicro.com>
	<s5hzkn3pzrv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4CD7F1038B7
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 17:40:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzkn3pzrv.wl%tiwai@suse.de>
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

On Tue, May 03, 2011 at 05:30:44PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > You don't need to retransmit the I2C device address or the register
> > address for every single register.

> Is this behavior achieved really by these patches?  As far as I read

As I've repeatedly said these patches only provide a building block for
that, they don't actually do anything to help with I/O by themselves.

> these two patches, they change how values are stored in the rb-tree.
> Now it'll be partially an array instead of one-value-per-node.  But,
> this doesn't change how snd_soc_read() / snd_soc_write() are called.

> Could you give an example which driver would be influenced actually?

There are no drivers that would benefit yet since the register caches
they rely on can't support this yet!
