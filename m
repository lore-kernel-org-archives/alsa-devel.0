From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: imx-spdif: Use module_init() to
 handle platform_device_register()
Date: Fri, 20 Dec 2013 15:02:06 +0800
Message-ID: <20131220070204.GA15246@MrMyself>
References: <1387190169-7936-1-git-send-email-Guangyu.Chen@freescale.com>
 <20131216194717.GO3185@sirena.org.uk>
 <20131216211958.GS4360@n2100.arm.linux.org.uk>
 <20131216221710.GH3185@sirena.org.uk>
 <20131217103049.GA3043@MrMyself>
 <20131218130415.GO28455@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 by alsa0.perex.cz (Postfix) with ESMTP id 189D1265521
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 08:08:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131218130415.GO28455@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 18, 2013 at 01:04:15PM +0000, Mark Brown wrote:
> > Although I'll continue finding another way to register it tomorrow, I think
> > it's better to make a simple report for this solution.
> 
> > And if you have any idea, please guide me.
> 
> There's still the options of either registering the dummy devices in the
> core (rather than in a specific module where two modules could conflict
> with each other) or registering a subdevice for the card that I
> mentioned the other day.  Of those two registering in the core seems
> better - it's basically the same as your current idea but means that two
> card drivers that need this won't conflict with each other.

I'd love to try these two even though it should be a bit tougher.

Thank you for the ideas.
Nicolin Chen
