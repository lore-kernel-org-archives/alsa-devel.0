From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V5 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Date: Sun, 21 Apr 2019 19:57:19 -0700
Message-ID: <20190422025715.GB9768@Asurada>
References: <cover.1555900078.git.shengjiu.wang@nxp.com>
 <cc27c775aca3a9c1ffcd310429170bbd64b74a39.1555900078.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cc27c775aca3a9c1ffcd310429170bbd64b74a39.1555900078.git.shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 22, 2019 at 02:32:35AM +0000, S.j. Wang wrote:
> When we want to support more sample rate, for example 12kHz/24kHz
> we need update the process_option table, if we want to support more
> sample rate next time, the table need to be updated again. which
> is not flexible.
> 
> We got a function fsl_asrc_sel_proc to replace the table, which can
> give the pre-processing and post-processing options according to
> the sample rate.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

A couple of more small comments.

And please add this when you resend:
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> + * Unsupport cases: Tsout > 8.125 * Tsin, Tsout > 16.125 * Tsin

Since we have a ratio validation somewhere else, it's okay to
drop this line -- it may confuse people since the function no
longer checks these unsupported cases.

> +static int fsl_asrc_sel_proc(int inrate, int outrate,

I think "void" type should be just fine as we made sure there
is no unsupported cases running in this function.
