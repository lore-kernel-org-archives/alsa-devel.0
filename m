From: Hsin-yu Chao <hychao@chromium.org>
Subject: Re: Applied "ASoC: rt5514: expose Hotword Model
	control" to the asoc tree
Date: Thu, 14 Sep 2017 14:28:25 +0800
Message-ID: <CANyK0SnMG+TBz2xu0VtRpR--VOjG4CaFW764UaHPpOjfEdFrkg@mail.gmail.com>
References: <E1dkpi0-0000rj-Vu@debutante>
 <d9e62043-fa21-7159-c310-86c962ffb8e0@sakamocchi.jp>
 <4cb3fcb2-1182-956d-3594-92a654274cc5@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com
 [209.85.223.170])
 by alsa0.perex.cz (Postfix) with ESMTP id CC639266986
 for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2017 08:28:27 +0200 (CEST)
Received: by mail-io0-f170.google.com with SMTP id v36so14142877ioi.1
 for <alsa-devel@alsa-project.org>; Wed, 13 Sep 2017 23:28:27 -0700 (PDT)
In-Reply-To: <4cb3fcb2-1182-956d-3594-92a654274cc5@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Oder Chiou <oder_chiou@realtek.com>, Dylan Reid <dgreid@chromium.org>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,
Thank you for the detailed explanation.
I will discuss with Oder about the blob used for voice wake up, and
see if we can come up with a proposal to generalize this by basic
types.

Hi Mark,
There's a related patch "ASoC: rt5514: Guard Hotword Model bytes
loading" might need to be reverted as well.
If there's anything I should do please let me know.

Thanks,
Hsin-yu

On Thu, Sep 14, 2017 at 1:03 PM, Takashi Sakamoto
<o-takashi@sakamocchi.jp> wrote:
> On Sep 14 2017 12:54, Takashi Sakamoto wrote:
>>
>> As the subject notes, please revert the commit including the below lines.
>
>
> Ah... I forgot to modify the subject line as 'Please revert d18420b0a0b8
> ("ASoC: rt5514: expose Hotword Model control")'.
>
>
> Regards
>
> Takashi Sakamoto
