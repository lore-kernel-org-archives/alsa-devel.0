From: Curtis Malainey <cujomalainey@google.com>
Subject: Re: [PATCH] ASoC: Intel: sst: fix kmalloc call with wrong flags
Date: Fri, 7 Jun 2019 15:27:11 -0700
Message-ID: <CAOReqxi45h20K4aSfnGC7kQFx-nOyLrDCknKG_Lc5iyGS4+zrA@mail.gmail.com>
References: <20190607221911.118136-1-levinale@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190607221911.118136-1-levinale@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Levin <levinale@chromium.org>
Cc: ALSA development <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ben Zhang <benzh@chromium.org>, Curtis Malainey <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 7, 2019 at 3:19 PM Alex Levin <levinale@chromium.org> wrote:
>
> When calling kmalloc with GFP_KERNEL in case CONFIG_SLOB is unset,
> kmem_cache_alloc_trace is called.
>
> In case CONFIG_TRACING is set, kmem_cache_alloc_trace will ball
nit: *call
> slab_alloc, which will call slab_pre_alloc_hook which might_sleep_if.
>
> The context in which it is called in this case, the
> intel_sst_interrupt_mrfld, calling a sleeping kmalloc generates a BUG():
>
> Fixes: 972b0d456e64 ("ASoC: Intel: remove GFP_ATOMIC, use GFP_KERNEL")
>
> [   20.250671] BUG: sleeping function called from invalid context at mm/slab.h:422
> [   20.250683] in_atomic(): 1, irqs_disabled(): 1, pid: 1791, name: Chrome_IOThread
> [   20.250690] CPU: 0 PID: 1791 Comm: Chrome_IOThread Tainted: G        W         4.19.43 #61
> [   20.250693] Hardware name: GOOGLE Kefka, BIOS Google_Kefka.7287.337.0 03/02/2017
> [   20.250893] R10: 0000562dd1064d30 R11: 00003c8cc825b908 R12: 00003c8cc966d3c0
> [   20.250896] R13: 00003c8cc9e280c0 R14: 0000000000000000 R15: 0000000000000000
>
> Signed-off-by: Alex Levin <levinale@chromium.org>
Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
> ---
>
