From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Applied "ASoC: rsnd: ssi: fix race condition in
 rsnd_ssi_pointer_update" to the asoc tree
Date: Tue, 9 Jan 2018 15:53:13 +0900
Message-ID: <9caa59c7-4c0b-ef77-88ea-29f5e03441c0@sakamocchi.jp>
References: <E1eNNl3-0003pn-VV@debutante>
 <661598a7-b62c-074a-a12e-12ed87f4700e@sakamocchi.jp>
 <20171211113809.GA9854@sirena.org.uk> <5A54565C.70805@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5A54565C.70805@mentor.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Jiada,

On Jan 9 2018 14:42, Jiada Wang wrote:
> Only the first patch in
> https://www.spinics.net/lists/alsa-devel/msg71021.html
> was applied, but the second patch "ASoC: rsnd: ssi: remove unnesessary 
> period_pos"
> was missed
> 
> Could you please have a look

I can see all of them were applied to Mark's for-next branch[1].

  - 33f801366bdf ('ASoC: rsnd: ssi: fix race condition in 
rsnd_ssi_pointer_update')[2]
  - 2e2d53da81af ('ASoC: rsnd: ssi: remove unnesessary period_pos')[3]

No worries to us.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/log/?h=for-next
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/sound/soc/sh?h=for-next&id=33f801366bdf3f8b67dfe325b84f4051a090d01e
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/sound/soc/sh?h=for-next&id=2e2d53da81af6b2222c6b4e025a5d01b37b4449b


Regards

Takashi Sakamoto
