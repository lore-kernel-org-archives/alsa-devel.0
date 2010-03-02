From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC 0/4] FIFO caused playback delay (latency)
	handling in soc
Date: Wed, 3 Mar 2010 07:29:23 +0800
Message-ID: <4f3252891003021529h4cfe22a4wb5d8217da298a94f@mail.gmail.com>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 00A7910389A
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 00:29:24 +0100 (CET)
Received: by pwj10 with SMTP id 10so443948pwj.38
	for <alsa-devel@alsa-project.org>; Tue, 02 Mar 2010 15:29:23 -0800 (PST)
In-Reply-To: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/3/2 Peter Ujfalusi <peter.ujfalusi@nokia.com>

> Hello,
>
> There has been discussion in alsa-devel in this subject several times,
> but no actual patches has been sent.
>
> Based on the available information the latency caused by the HW buffer
> on some systems can be handled by updating the runtime->delay.
>
> It has been discussed, that the runtime->delay can also be updated
> dynamically to show more accurate delay.
>
> To further complicate things, in ASoC we could have more buffer in the
> chain. To handle this we need soc level support.
>
> This RFC series tries to do that in soc by:
> - introducing a pcm_pointer wrapper
> - in this wrapper we call the original pcm_pointer functions to get the
>  DMA pointer
> - introducing a new interface in dai_ops to ask the delay from the dais
> - adding the cpu_dai and codec_dai returned delay to form the actual
>  delay
> - update the runtime->delay with this value.
>
> With this approach none of the existing drivers need change, but they
> can add support for specifying the FIFO caused delay.
>
> In this series on top of the core changes the omap(3) code is updated
> to take this delay reporting into use.
> I have not added the support to the tlv320dac33 codec driver, since it
> needs a bit more work, but along the same line it can be done, and if
> the tlv320dac33 is hooked to omap McBSP than applications can know the
> whole delay/latency on that path.
>
> Since this is for RFC, I have based it on sound-2.6 topc/asoc branch,
> which does not have the McBSP regcache nor the sidetone patches, but I
> would like to get feedback on this method first than create a proper
> series.
>
> I have left out linux-omap from this RFC round, since the problem
> is ALSA related.
>
> Thank you,
> P=E9ter Ujfalusi
>
> ---
> Peter Ujfalusi (4):
>  ASoC: core: soc level wrapper for pcm_pointer callback
>  ASoC: core: Add delay operation to snd_soc_dai_ops
>  OMAP3: McBSP: Add interface for transmit FIFO state query
>  ASoC: OMAP3: Report delay on playback caused by the internal FIFO
>
>  arch/arm/plat-omap/include/plat/mcbsp.h |    4 +++
>  arch/arm/plat-omap/mcbsp.c              |   27 ++++++++++++++++++++++++
>  include/sound/soc-dai.h                 |    6 +++++
>  sound/soc/omap/omap-mcbsp.c             |   26 +++++++++++++++++++++++
>  sound/soc/soc-core.c                    |   34
> ++++++++++++++++++++++++++++++-
>  5 files changed, 96 insertions(+), 1 deletions(-)
>
>
>
Do soc support snd_pcm_rewind() and snd_pcm_forward ?
