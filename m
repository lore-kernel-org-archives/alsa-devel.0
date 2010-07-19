From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Clicking and stuttering audio when playing two or
	more files
Date: Mon, 19 Jul 2010 09:59:37 +0100
Message-ID: <20100719085936.GB15693@rakim.wolfsonmicro.main>
References: <AANLkTikcthlodljUqW8oA69UYL2znXfTgHbABTRHYwSI@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1EC9D243CA
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 10:59:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTikcthlodljUqW8oA69UYL2znXfTgHbABTRHYwSI@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Rosenberg <adam@alcorn.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 15, 2010 at 01:21:47PM -0400, Adam Rosenberg wrote:
> I have audio output perfectly from my second CS42448 CODEC now, but
> only when one file is playing.  When I attempt to play two files, one
> or both of the files play with clicking and stuttering.  I am also

Clicks and stutters usually mean that you're not managing to keep the
data flowing into the audio controller quickly enough to keep it from
underrunning.

> noticing that the PCM prepare operation is occurring more than once.
> What could be causing this problem?

I'd expect prepare to be called for each data stream.
