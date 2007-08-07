From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: Possible problems with alsa soc
Date: Tue, 7 Aug 2007 14:12:18 +0530
Message-ID: <8d6898730708070142v5097c4fdo8c997936774fb318@mail.gmail.com>
References: <8d6898730708060649q6163f65u76259c9d6e6840e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E94F103860
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Aug 2007 10:42:20 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so2167518wag
	for <alsa-devel@alsa-project.org>; Tue, 07 Aug 2007 01:42:18 -0700 (PDT)
In-Reply-To: <8d6898730708060649q6163f65u76259c9d6e6840e1@mail.gmail.com>
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

Any way calling close() before open() is not possible, i will restate
it as calling close() before prepare().

Thanks
Nobin Mathew

On 8/6/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> Hi Liam,
>
> There are some players which will call snd-pcm_close() before any open
> call, i dont know why they are calling this. So in ASoC it will put
> the stream in SNDRV_CTL_POWER_D3hot and pop_wait equal to 1. This
> state will make problems in snd_pcm_prepare (i.e soc_pcm_prepare).
>
> Trouble creating players and libraries are mpg123 and gstreamer library.
>
> Takashi,
>
>  We now have priority based alsa plugin, as I explained earlier. all
> these credits goes to Sudhanshu. This will be usefull for many gps,
> bluetooth and audio SoCs. But we need to make some changes to make it
> generic, later we will summit this as a patch.
>
> Thanks
> Nobin Mathew
>
