From: Liam Girdwood <lrg@kernel.org>
Subject: Re: snd_pcm_hw_params_get_period_size points to __old_
 symbol
Date: Sun, 22 Feb 2009 22:15:56 +0000
Message-ID: <1235340956.27887.547.camel@vega.slimlogic.co.uk>
References: <20090222213553.GA5893@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 18924244C7
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 23:16:07 +0100 (CET)
In-Reply-To: <20090222213553.GA5893@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2009-02-22 at 22:35 +0100, Daniel Mack wrote:
> Hi,
> 
> With alsa-lib and alsa-utils cross-compiled for ARM by
> buildroot (currently version 1.0.19, but earlier versions
> seem to be equally affected), I encounter the effect that
> snd_pcm_hw_params_get_period_size() does not write the expected
> value to the given snd_pcm_uframes_t pointer. In fact, this
> variable is not written at all. This makes aplay calculate 0
> for chunk_bytes in set_params() and then exit with the bogus error
> message "Not enough memory". I did some tracing and found out that
> the function called for snd_pcm_hw_params_get_period_size() is in
> fact __old_snd_pcm_hw_params_get_period_size() which has a different
> footprint and hence the pointer given to it is leaved untouched.
> 
> As I don't fully understand all the system behind the symbol names
> remapping, I'm stuck here. Can anybody reproduce this bug?

AFAICT, buildroot builds a broken ALSA ARM userspace. I've had driver
bug reports from numerous users for about 2 years now due to buildoot
building a faulty ARM ALSA userspace. I've also asked each bug reporter
to report this to buildroot bugzilla. Seems it's not fixed yet.

Please either build alsa-lib natively or with OpenEmbedded.

Liam 
