From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Dynamic CODEC DAI
Date: Tue, 29 Nov 2011 13:49:14 +0000
Message-ID: <20111129134913.GB26800@opensource.wolfsonmicro.com>
References: <4ED42C0E.2080300@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2388C103B36
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 14:49:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4ED42C0E.2080300@codeaurora.org>
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

On Mon, Nov 28, 2011 at 04:49:18PM -0800, Patrick Lai wrote:

> In CODEC driver, I will declare codec dai for each port.
> Then, I will enhance ASoC framework to take a list of CODEC DAIs and
> pass list of CODEC DAIs back to callback function such as startup,
> hw_param, prepare, trigger. I believe this approach will not require
> massive amount of change to framework.

The above is really vauge so it's hard to comment in any detail.  I'm
not sure it's worth trying to be too non-invasive, anything controlling
hardware is going to have to understand what's going on at the physical
level anyway and the host side is going to have to interoperate with the
Slimbus framework.  The core is also going to need to know about the
channel groups to allocate and destroy them as required.  It seems like
being more explicit might be easier.

Also note that the work on submitting your Silmbus driver core to
mainline appears totally stalled, there was just an initial posting but
no followup.
