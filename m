From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Dynamic CODEC DAI
Date: Mon, 5 Dec 2011 11:49:35 +0000
Message-ID: <20111205114935.GG11150@opensource.wolfsonmicro.com>
References: <4ED42C0E.2080300@codeaurora.org>
	<20111129134913.GB26800@opensource.wolfsonmicro.com>
	<4ED83E52.6080004@codeaurora.org> <1322820685.7185.12.camel@odin>
	<4EDC712E.9040409@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C9EF910398A
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 12:49:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EDC712E.9040409@codeaurora.org>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 04, 2011 at 11:22:22PM -0800, Patrick Lai wrote:

> My problem has more to do with ability to form PCM device at run-time
> by grouping available slimbus ports at the CPU side and CODEC side
> after knowing number of channels required. Furthermore, the CODEC I am
> working on does not allow all mic inputs going to all audio interface
> capture ports. Unless application can provide the mic input it is
> interested before initiation of capture stream, it is hard to utilize
> very slimbus port on the CODEC. Do you have work in progress code on
> gitorious.org? Perhaps, I can take a look to understand more about your
> proposed design and see what I can leverage.

You get pretty much exactly the same problem on PCM links using TDM -
you can get a single link which you can combine into groups of channels
dynamically.  For example, you might use two channels for speaker and
two for headphones or you might use those four plus another two for 5.1
speaker all depending on use case.
