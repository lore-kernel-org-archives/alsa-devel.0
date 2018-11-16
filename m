From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: How to propagate parameters from FE to BE with
 compressed audio interfaces
Date: Fri, 16 Nov 2018 09:04:47 +0200
Message-ID: <CAEnQRZDq88F3s_6buR_29VyEv221xUNS3ffm1qX7UsktP9Z5-A@mail.gmail.com>
References: <1542209728.21696.53.camel@nxp.com>
 <de3b13f4-bfec-07ba-3f3a-85796ccccfa9@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by alsa0.perex.cz (Postfix) with ESMTP id B61A7267AFC
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2018 08:04:59 +0100 (CET)
Received: by mail-ed1-f52.google.com with SMTP id x30so14033806edx.2
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 23:04:59 -0800 (PST)
In-Reply-To: <de3b13f4-bfec-07ba-3f3a-85796ccccfa9@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: vkoul@kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 14, 2018 at 6:52 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> Hi Daniel,
>
> On 11/14/18 9:35 AM, Daniel Baluta wrote:
> > Hello,
> >
> > soc_compr_set_params_fe calls dpcm_be_dai_hw_params in order to setup
> > BE hw_params.
> >
> > Is there a way to transfer parameters like for example the rate from FE
> > to BE?
> >
> > In soc_compr_set_params_fe there is this code:
> >
> > *
> > * Create an empty hw_params for the BE as the machine driver must
> > * fix this up to match DSP decoder and ASRC configuration.
> > * I.e. machine driver fixup for compressed BE is mandatory.
> > */
> > memset(&fe->dpcm[fe_substream->stream].hw_params, 0,
> >         sizeof(struct snd_pcm_hw_params));
> >
> > So, information about parameters is just ignored.
> >
> > The only way we can setup hw_params for BE is via
> > be_hw_params_fixup() but this function doesn't have any information
> > from FE.
> >
> > My use case is something like this:
> >
> > FE:
> >      - cpu: FSL SAI DAI interface
> >      - platform: DSP
> >      - codec: dummy codec
> > BE:
> >      - cpu: dummy
> >      - platform: dummy
> >      - codec: cs42888.
> >
> > codec could handle 44100Hz and 48000Hz streams, but the BE doesn't have
> > any way to know what is the rate cplay sets to FE.
>
> I don't think we planned for the case you mention, but IIRC it was
> intentional.
>
> In our implementations and the non-Intel ones I am familiar with, the BE
> typically handles data that is mixed between PCM channels (for
> tone/alerts/low latency) and decompressed data. So the rate adaptation
> of the decoder output is handled inside the DSP and the BE is configured
> at a set rate. I also don't remember when was the last time we supported
> 44.1 kHz, maybe 2011?
>
Got your point. I will use (A)SRC to handle the rate conversion.

Thanks a lot Pierre!

Daniel.
