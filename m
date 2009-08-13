From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: snd_pcm_delay,
 hw buffers and driver api (was: Re: [PATCH 11/20] OMAP: McBSP: Add
 link DMA mode selection)
Date: Thu, 13 Aug 2009 21:59:23 +0100
Message-ID: <20090813205922.GB7519@sirena.org.uk>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
	<20090805103900.5ad89efe.jhnikula@gmail.com>
	<200908051158.57440.peter.ujfalusi@nokia.com>
	<1FFEF31EBAA4F64B80D33027D4297760047F6AED01@NOK-EUMSG-02.mgdnok.nokia.com>
	<20090811090457.d89afd3e.jhnikula@gmail.com>
	<1249971481.16045.17.camel@eenurkka-desktop>
	<20090812144547.eb4bf7f2.jhnikula@gmail.com>
	<alpine.DEB.1.10.0908132304420.3417@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C2F3210390C
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 22:59:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0908132304420.3417@ecabase.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kai Vehmanen <kvehmanen@eca.cx>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>, ext-eero.nurkkala@nokia.com
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 13, 2009 at 11:46:52PM +0300, Kai Vehmanen wrote:

> not strictly related to the patch in question, but this touches on, and is 
> a good example of, one question I've been wondering for some time now as 
> an app developer. Could Takashi, Jaroslav, Mark, or others comment on this 
> as well, perhaps? Dropping linux-omap as this is a generic ALSA question.

I'd suggest starting a new thread to discuss this - I'd imagine that
several of the people you're trying to get answers from are at best just
scanning the thread since it's very large and very OMAP-specific.

(Incidentally, can be very helpful to use --no-chain-reply-to when
posting large patch sets like this to avoid massive indentation in
threaded mail readers).

> In both cases, this value (hw_ptr) shows the status of sending data to an 
> separate entity, and one that has its own buffer (multiple ms) before the 
> actual DAC/ADC.

> But how would a driver expose both bits of info to apps (in a standard 
> fashion): 1) the hw_ptr for shuffling bits out of the ringbuffer, and 2) 
> the delay to next played-out/captured sample. For application developers, 
> (2) is the piece of info we are mostly interested in (if I write a sample 
> now, how long it will be until it's played out).

Both bits of information are very interesting to applications - some
applications want to work on the data they're sending for as long as
possible (things like pulse which do mixing are the obvious example of
this).

> Any update/ideas on this topic? Personally I think adding a new driver 
> callback would make most sense, as that would allow to take full benefit 
> from hardware that allows to query sample-accurate position of playout 
> (i.e. not just support exposing a fixed latency). Of course that's 
> potentially a big change. In alsa-lib, snd_pcm_hwsync() could call this 
> driver callback, and a new variant of snd_pcm_delay() could present the 
> information to the applications.

If we're adding a new API it should be possible to add one which
provides the required information without disturbing the semantics of
the existing APIs.
