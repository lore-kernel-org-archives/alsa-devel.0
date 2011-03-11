From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: : Question cpu_dai->active  & codec_dai->active
Date: Fri, 11 Mar 2011 15:31:00 +0000
Message-ID: <20110311153059.GN1760@opensource.wolfsonmicro.com>
References: <2A84145621092446B6659B8A0F28E26F4703F71706@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4758B2451F
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 16:31:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2A84145621092446B6659B8A0F28E26F4703F71706@irsmsx501.ger.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Bensaid, Selma" <selma.bensaid@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 04, 2011 at 11:04:20AM +0000, Bensaid, Selma wrote:

> Why the cpu_dai->active and codec_dai->active are not used to check if
> the corresponding shutdown or startup callbacks should be called or not?

> This could be useful for DAIs that handle capture and playback streams by avoiding:

> - perform 2 cpu_dai or codec_dai startup when opening both streams (playback and 
> Capture)
> - close a cpu_dai or codec_dai for a stream (example playback) while
> the 2nd stream (playback) is still running

It's done to allow the driver to make the decision about needing to do
anything - some drivers may need to do per-stream things, those that
don't can work out if they need to do anything.  If it became very
common we could add variants that only get called once but at the minute
we have very few things that support multiple streams in the first
place.
