From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/2] PCM OSS fixes
Date: Tue, 9 Jan 2018 14:38:48 +0100
Message-ID: <524a613e-9362-32a7-97a6-1e19145b15cc@metafoo.de>
References: <20180108142541.18098-1-tiwai@suse.de>
 <87b0dddb-c9f4-5dc6-d6c4-1136c091c9fa@metafoo.de>
 <s5hd12k75m1.wl-tiwai@suse.de>
 <8d4dc6ef-6542-8ad1-ca9b-6b025409fac4@metafoo.de>
 <s5hy3l85pgp.wl-tiwai@suse.de>
 <aa6bae39-8b79-482f-c313-ae004403e509@metafoo.de>
 <s5ho9m31o6r.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id C1315266E45
 for <alsa-devel@alsa-project.org>; Tue,  9 Jan 2018 14:38:50 +0100 (CET)
In-Reply-To: <s5ho9m31o6r.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Dmitry Vyukov <dvyukov@google.com>
List-Id: alsa-devel@alsa-project.org

On 01/09/2018 08:33 AM, Takashi Iwai wrote:
[...]
> However, the problem is that OSS emulation sets avail_min=1: implying
> that, when there is any samples empty in the ring buffer, it can
> continue.  In the case above, when some samples have been processed
> before wait_for_avail(), it keeps the outer loop spinning again.
> 
> Since each iteration takes ca 2ms on my VM, 8000Hz rate gives 1 or 2
> samples free at each iteration.  Thus at each time snd_pcm_lib_xfer()
> is invoked, it processes 1 or 2 samples, then returns due to pending
> signals, and the outer loop continues until the whole given samples
> are consumed.  If the machine is faster or the sample rate is lower,
> the outer loop may exit, OTOH.

OK, that makes sense. I didn't think about that case. In my mind I was
working with avail_min=period_size.

Thanks for clearing this up.

- Lars
