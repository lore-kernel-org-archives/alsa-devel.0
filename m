From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 6/6] ASoC: xtfpga-i2s: Add missing __rcu
	annotation
Date: Tue, 28 Jul 2015 13:48:47 +0300
Message-ID: <CAMo8BfL7Zd7cgSVawtzLf4ejFm9X7jbQwZhktFTkAJFjGw5bmQ@mail.gmail.com>
References: <1437987388-9706-1-git-send-email-lars@metafoo.de>
 <1437987388-9706-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 4260C26070F
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 12:48:48 +0200 (CEST)
Received: by oibn4 with SMTP id n4so66568023oib.3
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 03:48:47 -0700 (PDT)
In-Reply-To: <1437987388-9706-7-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Patrick Lai <plai@codeaurora.org>, patches@opensource.wolfsonmicro.com, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 27, 2015 at 11:56 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> tx_substeam is accessed using the RCU API and hence should have the __rcu
> annotation. Fixes the following sparse warnings:
>
>         sound/soc/xtensa/xtfpga-i2s.c:165:24: error: incompatible types in
>                 comparison expression (different address spaces)
>         sound/soc/xtensa/xtfpga-i2s.c:165:24: error: 'struct snd_pcm_substream
>                 [noderef] <asn:4>*' versus
>         sound/soc/xtensa/xtfpga-i2s.c:165:24: error: 'struct snd_pcm_substream *'
>         sound/soc/xtensa/xtfpga-i2s.c:255:24: error: incompatible types in
>                 comparison expression (different address spaces)
>         sound/soc/xtensa/xtfpga-i2s.c:255:24: error: 'struct snd_pcm_substream
>                 [noderef] <asn:4>*' versus
>         sound/soc/xtensa/xtfpga-i2s.c:255:24: error: 'struct snd_pcm_substream *'
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/xtensa/xtfpga-i2s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thank you for the fix, Lars-Peter.
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
