From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Can I stop sound from driver as system error ?
Date: Tue, 15 Dec 2015 10:48:45 +0900
Message-ID: <566F717D.3050701@sakamocchi.jp>
References: <87zixcpktb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id E44D426078A
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 02:48:48 +0100 (CET)
In-Reply-To: <87zixcpktb.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Dec 15 2015 10:25, Kuninori Morimoto wrote:
> I wonder can I stop sound from driver side (not from user-land)
> as system error during playback or capture ?
> How to do it if we can ?

Stop PCM substreams with SNDRV_PCM_STATE_XRUN. In detail, see 
implementation of snd_pcm_stop_xrun() available in 3.19 or later. Then, 
userspace applications cannot continue to read/write PCM frames via ALSA 
uapi.

When using alsa-lib, then, userspace applications receive -EPIPE as 
return value of calling PCM APIs. The applications can stop their 
operation for PCM character devices, or can also recover the XRUN state 
of PCM substream by calling snd_pcm_prepare(). In this case, struct 
snd_pcm_ops.prepare() is called again in driver side.

I think tinyalsa works almost the same.


Regards

Takashi Sakamoto
