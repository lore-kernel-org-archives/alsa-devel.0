From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: MPC5200: Support for buffer wrap
 around
Date: Sat, 1 Aug 2009 10:57:12 +0100
Message-ID: <20090801095712.GC7979@sirena.org.uk>
References: <20090731230311.17686.46431.stgit@riker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 962C624382
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Aug 2009 11:57:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090731230311.17686.46431.stgit@riker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Bonesio <bones@secretlab.ca>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 31, 2009 at 04:08:55PM -0700, John Bonesio wrote:
> We've encountered strange behavior in the alsamixer settings using the wm9712
> codec. If we unmute the headphone output and then unmute the PCM output, the
> headphone output gets reset to mute in the hardware register. At this point
> the hardware register does not match the value in the register cache.

Which specific controls are you looking at here?

> I've spent some time debugging this, and the headphone setting is set outside
> of any code path that would call the ac97_write() routine. As best as I can
> tell, there is something strange going on in hardware.

> I've provided this patch that works around the problem.

Like Grant says I suspect this isn't the patch you meant...

> Have any of you seen this before? Is this patch the right approach?

I've never heard of that before and the WM9712 is very widely deployed
so if it were a hardware issue in the CODEC I'd imagine it would have
come up.  On the other hand, it's not beyond the bounds of possibility.
If you could post the patch showing exactly what you're doing I could
probably say more.

If you could get a scope on the bus that might be interesting...
