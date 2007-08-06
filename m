From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Possible problems with alsa soc
Date: Mon, 6 Aug 2007 19:19:15 +0530
Message-ID: <8d6898730708060649q6163f65u76259c9d6e6840e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AD172435D
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Aug 2007 15:49:17 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so1415518rvb
	for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2007 06:49:16 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
Cc: Sudhanshu Saxena <sudhanshu.saxena@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Liam,

There are some players which will call snd-pcm_close() before any open
call, i dont know why they are calling this. So in ASoC it will put
the stream in SNDRV_CTL_POWER_D3hot and pop_wait equal to 1. This
state will make problems in snd_pcm_prepare (i.e soc_pcm_prepare).

Trouble creating players and libraries are mpg123 and gstreamer library.

Takashi,

 We now have priority based alsa plugin, as I explained earlier. all
these credits goes to Sudhanshu. This will be usefull for many gps,
bluetooth and audio SoCs. But we need to make some changes to make it
generic, later we will summit this as a patch.

Thanks
Nobin Mathew
