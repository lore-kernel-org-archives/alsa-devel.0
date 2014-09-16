From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH] speaker-test: Fix dropped samples at
	the	end of test
Date: Tue, 16 Sep 2014 03:30:45 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901B33933@SHSMSX101.ccr.corp.intel.com>
References: <1410524068-15982-1-git-send-email-jarkko.nikula@linux.intel.com>
 <s5hioko52lz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 120782610A3
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 05:31:44 +0200 (CEST)
In-Reply-To: <s5hioko52lz.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Vidal,
 Guillaume-florianX" <guillaume-florianx.vidal@intel.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Takashi Iwai
> Sent: Monday, September 15, 2014 11:24 PM
> To: Jarkko Nikula
> Cc: alsa-devel@alsa-project.org; Vidal, Guillaume-florianX
> Subject: Re: [alsa-devel] [PATCH] speaker-test: Fix dropped samples at the end
> of test
> 
> At Fri, 12 Sep 2014 15:14:28 +0300,
> Jarkko Nikula wrote:
> >
> > Commit 6d1673526b0f ("Avoid unnecessary drain/restart in
> > speaker-test") drains only when buffer is bigger than audio sample.
> > This has a drawback that up to buffer size amount of data may not be
> > heard at the end of audio sample.
> >
> > This was noted with "speaker-test -c 2 -t wav -s 2" test on a hardware
> > that has a buffer size of 24000 samples and 48 kHz sample rate.
> > Instead of playing "front right" it played something like "front ra".
> >
> > Reverse buffer size vs sample size test wouldn't work either since
> > then samples smaller than buffer are dropped.
> >
> > Fix this by removing buffer_size tests from write_loop() and do
> > drain/restart always when not aborting.
> >
> > Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > Reported-by: Vidal, Guillaume-florianX
> > <guillaume-florianx.vidal@intel.com>
> > ---
> > This was originally noted on Baytrail ADSP hw (default buffer size
> > 24000) but can be heard also on Intel HDA (default buffer size 8192)
> > when audio sample is small enough but bigger than buffer. For instance
> > 100 ms sample finishes too shortly (buffer size 8192, sample size
> > 9600) but 50 ms plays ok (buffer size 8192, sample size 4800).
> >
> > I guess some optimization can be done for snd_pcm_prepare() when not
> > looping but that's not necessary for this fix.
> 
> Won't it suffice by just putting snd_pcm_drain() at the end of the whole
> operation like below?  Doing snd_pcm_drain() and
> snd_pcm_prepare() at each time causes often undesired pop noises or such.
> 
> OTOH, doing drain there is good for showing the text at the right time.  So,
> we'll likely want to have both options managed by a command line option.
> 
> 
> Takashi
> 
> ---
> diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c index
> 61396f296c65..362efa7ffc0d 100644
> --- a/speaker-test/speaker-test.c
> +++ b/speaker-test/speaker-test.c
> @@ -1307,6 +1307,7 @@ int main(int argc, char *argv[]) {
>      }
>    }
> 
> +  snd_pcm_drain(handle);
[Keyon] here I verified Takashi's fix also works.
> 
>    free(frames);
>  #ifdef CONFIG_SUPPORT_CHMAP
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
