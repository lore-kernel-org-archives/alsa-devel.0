From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC PATCH 1/4] alsa: make hw_params negotiation
 infrastructure 'bclk_ratio aware'
Date: Tue, 5 Mar 2019 13:42:32 +0900
Message-ID: <20190305044232.GA15636@workstation>
References: <20190304165955.21696-1-TheSven73@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD07FF896CE
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2019 05:42:42 +0100 (CET)
Received: by mail-pg1-f193.google.com with SMTP id 196so4705726pgf.13
 for <alsa-devel@alsa-project.org>; Mon, 04 Mar 2019 20:42:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20190304165955.21696-1-TheSven73@gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Mar 04, 2019 at 11:59:52AM -0500, Sven Van Asbroeck wrote:
> Negotiation seems to work ok, but bclk_ratio is exposed to
> userspace via snd_pcm_hw_params, which is not acceptable.
> 
> Constrain bclk_ratio by:
> - cpu   dai capabilities && rules
> - codec dai capabilities && rules
> - minimum bclk_ratio is sample_width * channels
> 
> In hw_params_choose(), pick the smallest supported bclk_ratio,
> which should correspond to the most efficient solution.
> 
> If cpu and codec dais do not specify or constrain supported
> bclk_ratios, alsa will pick sample_width * channels.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
>  include/sound/pcm.h         | 11 +++++++++++
>  include/sound/soc.h         |  2 ++
>  include/uapi/sound/asound.h |  5 +++--
>  sound/core/pcm_native.c     | 34 +++++++++++++++++++++++++++++++++-
>  sound/soc/soc-pcm.c         |  8 ++++++++
>  5 files changed, 57 insertions(+), 3 deletions(-)

In UAPI of Linux sound subsystem, sample formats are represented
in enumerators prefixed with 'SNDRV_PCM_FORMAT_'. In the enumerators,
sample bits and padding bits are represented:

              S8 S16 S20 S24 S32 S18_3 S20_3 S24_3
sample-bits:   8  16  20  24  32  18    20    24 (=width)
padding-bits:  0   0  12   8   0   6    12     0
total bits:    8  16  32  32  32  24    24    24 (=physical_width)
 
When indicating a certain bit ratio of BCLK/WS from userspace,
applications use correct combination of the above format (=physical_width)
and the number of samples per audio data frame (=channels).

All of drivers can add constraints and rules for runtime of PCM substream
in its .open callback. As a result, applications can see available
combination of the format and the channels and choose correct combination.

In my opinion, your issue is a lack of the constraints and rules in
relevant drivers; perhaps in tda998x driver. Or core functionality of
ALSA SoC part has a lack of consideration about the above design of
ALSA PCM core and PCM interface. If a certain combination of CPU-dai and
CODEC-dai requires to ignore the above somehow, it should be done in
interaction between drivers for CPU-dai/CODEC-dai. In short, your issue
should not be exported to userspace.

I note that for your 'hypothetical' cpu dai[1], 20x2/20x2 mode
(physical_width=20, channels=2) is not available from userspace application.
We have no sample format suitable to it.


Anyway, when posting to change UAPI of Linux sound subsystem, it's
better to describe the reason fot new stuffs; what they're designed for,
and the reason to require them. Wnen posting in a result of series of
discussion done previously, it's better to add any reference to it. The
change effects all of userspace stuffs, regardless of whether they exist
or doesn't.  Furthermore the change has forced application developers to
take care of codes newly added. Additionally, it's better to note actual
example of applications with the added code. Unless, no one can judge
that the added code is enough abstracted for an application to handle
various type of hardware by the same code.

[1] https://mailman.alsa-project.org/pipermail/alsa-devel/2019-February/146062.html


Regards

Takashi Sakamoto
