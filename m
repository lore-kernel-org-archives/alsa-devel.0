From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Automatically set TDM if needed
	on	pxa-ssp and allow frame width override when using TDM.
Date: Wed, 10 Jun 2009 15:48:36 +0100
Message-ID: <20090610144836.GB7767@rakim.wolfsonmicro.main>
References: <1244567590.7406.100.camel@brutus>
	<20090610121844.GC14632@sirena.org.uk>
	<1244644794.27053.210.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DE8FA103820
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Jun 2009 16:48:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1244644794.27053.210.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 10, 2009 at 11:39:54AM -0300, Daniel Ribeiro wrote:

> Ok, but I dont know how to handle slot_width for wm9081. Is a FIXME
> comment here enough for a first version? Its hard for me to get this
> working correctly on wm9081 as I dont have such hardware and PCAP2 only
> supports 16bits slots.

Oh, and it's probably OK if you just leave bits of this undone - I'll
amend the code before applying it.
