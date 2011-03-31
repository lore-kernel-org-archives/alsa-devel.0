From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Query - ASoC headphone detection stereo vs. mono
Date: Fri, 1 Apr 2011 06:56:48 +0900
Message-ID: <20110331215647.GC21726@opensource.wolfsonmicro.com>
References: <4D94C7C2.8050109@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 754EB10381E
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 23:56:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4D94C7C2.8050109@codeaurora.org>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 31, 2011 at 11:28:18AM -0700, Patrick Lai wrote:
> I would like to get a better understanding on how to propagate
> channel mode of inserted headphone through soc-jack framework? I
> looked at jack.h and I don't see any definition of channel mode. I
> would assume that user-space needs this information in order to set
> up the path in the audio CODEC properly such as mixing stereo
> content into mono stream inside CODEC. How is use case handled on
> other platform?

Generally this is handled by taking advantage of the fact that from the
fact that when you connect a mono headphone it shorts left and right
channels together so you should get audio out with a combination of the
two channels.  Quality won't be great and you could save power with
mono playback but it should work and probably you're not doing lengthy
playback if you only have mono output.

I think most people are working on the basis that mono headphones are so
vanishingly rare these days that it's just not worth worrying about them
- music playback is so common that even low end devices support it and
it's getting hard to find mono headsets out there.

We could slot it in relatively easily, we'd just need to add separate
reports for left and right channels inside the kernel and then either
ignore it for userspace or come up with some sane way of propagating the
information out there too.  Like Liam says we can discuss this at the
conference if nobody comes up with a patch by then.
