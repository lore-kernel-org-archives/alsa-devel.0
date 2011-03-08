From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add MAX9850 codec driver
Date: Tue, 8 Mar 2011 12:09:52 +0000
Message-ID: <20110308120952.GA13671@opensource.wolfsonmicro.com>
References: <1299501913-3772-1-git-send-email-christian.glindkamp@taskit.de>
	<20110307134857.GA16691@opensource.wolfsonmicro.com>
	<20110307170420.GC7619@taskit.de>
	<20110308101450.GA11205@opensource.wolfsonmicro.com>
	<20110308115254.GD7902@taskit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ED1BF24591
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2011 13:09:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110308115254.GD7902@taskit.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christian Glindkamp <christian.glindkamp@taskit.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 08, 2011 at 12:52:54PM +0100, Christian Glindkamp wrote:
> Do I understand it correctly, that all register writes that I do in the
> probe function would be overridden by the syncing so they would have to
> be moved to the standby code or put into the register cache array as
> default values?

If you do any registers writes in the probe() function, in effect you
will be changing the hardware state as well as the cache state.  If
after that point you sync the cache to the hardware, the altered cache
will be synced, not the defaults cache.  The core makes a copy of the
defaults cache and uses that for syncing, or if you don't provide a
default's cache it will use a zero-ed cache.

Note that volatile registers don't affect the cache, they bypass it
completely.

Thanks,
Dimitris
