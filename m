From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 07/12] ASoC: SOF: Add DSP firmware trace
	event support
Date: Tue, 04 Sep 2018 14:21:20 +0100
Message-ID: <579fc5f7d26a8cba21fe36eb4ff6bb4a1a0d8496.camel@linux.intel.com>
References: <20180831151910.16122-1-liam.r.girdwood@linux.intel.com>
 <20180831151910.16122-8-liam.r.girdwood@linux.intel.com>
 <20180903162503.GS10302@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 33AE22678EC
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 15:21:40 +0200 (CEST)
In-Reply-To: <20180903162503.GS10302@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2018-09-03 at 17:25 +0100, Mark Brown wrote:
> On Fri, Aug 31, 2018 at 04:19:05PM +0100, Liam Girdwood wrote:
> 
> > Add a trace event buffer that can be used by userspace to read DSP runtime
> > trace events alongside bespoke trace data in realtime for firmware debug.
> 
> Should this be integrated into the Linux trace event mechanism rather
> than open coded?  It would at least be nice to not call this a trace
> event buffer - when I initially read this I was expecting it to be for
> the standard Linux stuff which obviously it isn't.

Your right, I'll rename. The eventual aim is to make it more like Linux trace
but we are constrained somewhat as some DSPs only 96kB or instruction RAM, hence
it's a simple and raw trace infrastructure.

Liam
