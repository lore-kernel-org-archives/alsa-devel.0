From: Daniel Mack <daniel@caiaq.org>
Subject: Re: snd_pcm_hw_params_get_period_size points to	__old_
	symbol
Date: Sun, 22 Feb 2009 23:22:28 +0100
Message-ID: <20090222222228.GE5893@buzzloop.caiaq.de>
References: <20090222213553.GA5893@buzzloop.caiaq.de>
	<1235340956.27887.547.camel@vega.slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D5511244C7
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 23:22:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1235340956.27887.547.camel@vega.slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 22, 2009 at 10:15:56PM +0000, Liam Girdwood wrote:
> > With alsa-lib and alsa-utils cross-compiled for ARM by
> > buildroot (currently version 1.0.19, but earlier versions
> > seem to be equally affected), I encounter the effect that
> > snd_pcm_hw_params_get_period_size() does not write the expected
> > value to the given snd_pcm_uframes_t pointer. In fact, this
> > variable is not written at all. This makes aplay calculate 0
> > for chunk_bytes in set_params() and then exit with the bogus error
> > message "Not enough memory". I did some tracing and found out that
> > the function called for snd_pcm_hw_params_get_period_size() is in
> > fact __old_snd_pcm_hw_params_get_period_size() which has a different
> > footprint and hence the pointer given to it is leaved untouched.
> > 
> > As I don't fully understand all the system behind the symbol names
> > remapping, I'm stuck here. Can anybody reproduce this bug?
> 
> AFAICT, buildroot builds a broken ALSA ARM userspace. I've had driver
> bug reports from numerous users for about 2 years now due to buildoot
> building a faulty ARM ALSA userspace. I've also asked each bug reporter
> to report this to buildroot bugzilla. Seems it's not fixed yet.

Interesting, thanks for pointing that out.

> Please either build alsa-lib natively or with OpenEmbedded.

This is rather unpracticable for us as we build the whole system with
buildroot. Hence, I'd rather go and fix it. Any hint about what could
possibily go wrong during the build phase which would explain that bug
to happen? A missing/wrong define, bogus configure arguments?

Daniel
