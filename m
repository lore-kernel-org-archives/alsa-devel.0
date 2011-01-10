From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: soc-core: Add support for NULL
 default register caches
Date: Mon, 10 Jan 2011 16:40:00 -0600
Message-ID: <4D2B8AC0.2010001@freescale.com>
References: <1294654256-1012-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<4D2B83EC.4000400@freescale.com>
	<20110110222938.GD5886@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	by alsa0.perex.cz (Postfix) with ESMTP id A2096103944
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 23:40:05 +0100 (CET)
In-Reply-To: <20110110222938.GD5886@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> You've not identified what the issue is with the above?  Is it just that
> nothing else ensured the cache was set up (eg, by doing reads from the
> hardware)?

The CS4270 registers are numbered from 1 through 8, so codec_reg should look
like this:

 1:   c3
 2:    0
 3:   30
 4:    0
 5:    0
 6:    0
 7:    0
 8:    0

What I don't know is why the bad output, but it's probably because the register
cache code broke during the various changes applied to it since multi-component
was introduced.  Originally, the driver handled the register cache completely
internally.  Then, as register caching was added to ASoC itself, the driver was
modified to use it.  I believe that those modifications were not really tested.

And since I removed all that code for my patch, I'm not really inclined to go
back and see what specifically was wrong with it.

-- 
Timur Tabi
Linux kernel developer at Freescale
