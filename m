From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC Peek individual register debugfs
Date: Sat, 23 Jul 2011 07:44:13 +0100
Message-ID: <20110723064412.GA31413@opensource.wolfsonmicro.com>
References: <4E28C543.5090802@codeaurora.org>
	<20110722090757.GG23192@opensource.wolfsonmicro.com>
	<4E29C6FC.6060801@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 00DB21039BD
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Jul 2011 08:44:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E29C6FC.6060801@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, brubin@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 22, 2011 at 11:52:44AM -0700, Patrick Lai wrote:
> On 7/22/2011 2:07 AM, Mark Brown wrote:

> >codec_reg.  This is the sort of question that can easily be answered by
> >looking at the code, or a running system.

> I checked soc-core.c on Linux next and I do not believe there is
> such debugfs interface. Here is the interface proposal.

> By default, cat codec_reg prints entire register dump
> If someone echo "<register_addr>" > codec_reg before running
> cat codec_reg, only register address and value of given register
> would be printed. Afterward, state gets reset. Entire register dump
> gets printed if user cat codec_reg again

No, that's bad as it means you can rely on the behaviour of the existing
file.  Just use codec_reg, it already does what you need - if you look
at the code you'll see that it only displays the registers you actually
read from it and since the registers are displayed in a fixed length
format they'll always appear at a consistent place in the file.
