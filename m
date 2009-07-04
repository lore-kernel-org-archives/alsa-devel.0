From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [RFC 0/13] Intel SST drivers
Date: Sat, 4 Jul 2009 11:31:56 +0100
Message-ID: <20090704103156.GC10490@sirena.org.uk>
References: <438BB0150E931F4B9CE701519A44630132984DC0@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EA973103817
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Jul 2009 12:31:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630132984DC0@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 03, 2009 at 11:36:03AM +0530, Koul, Vinod wrote:

> There are 2 drivers involved. One is for the audio DSP engine that can
> decode and do audio processing and one is for the ALSA sound card
> driver with support for three different sound cards that are supported
> on the platform.

Looking at this I'm wondering how general purpose the DSP on these parts
is.  This sort of integrated DSP is fairly common in modern embedded
CPUs but normally the DSP is exposed in a more general fashion, allowing
the DSP to be used for non-audio purposes as well which means that the
DSP management code tends to live outside the sound tree.

Given what you're saying about Intel-provided firmwares it is possible
that while the hardware is capable of general purpose use you're not
exposing sufficient information for people to actually write their own
firmware in which case that's less of an issue and the situation is
closer to that with things like WiFi cards but I thought it was better t
ask.
