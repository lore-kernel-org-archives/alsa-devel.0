From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Question about device recovery when under/over run
	error case
Date: Tue, 19 Jan 2016 21:33:41 +0900
Message-ID: <569E2D25.4070205@sakamocchi.jp>
References: <87twmbfqio.wl%kuninori.morimoto.gx@renesas.com>
 <569C7215.2000801@sakamocchi.jp>
 <87si1vfmv6.wl%kuninori.morimoto.gx@renesas.com>
 <s5h4mebs33a.wl-tiwai@suse.de>
 <87vb6q4ev2.wl%kuninori.morimoto.gx@renesas.com>
 <569D8E35.4010306@sakamocchi.jp>
 <87si1u46d9.wl%kuninori.morimoto.gx@renesas.com>
 <569DABD3.4080707@sakamocchi.jp>
 <87powy4207.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 83F3A260536
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 13:33:46 +0100 (CET)
In-Reply-To: <87powy4207.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, shiiba <naoya.shiiba.nx@renesas.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, komatsu <toshiaki.komatsu.ud@renesas.com>, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Jan 19 2016 13:42, Kuninori Morimoto wrote:
> I believe snd-soc-rcar is OK at this point,

Could I request you to explain about usage of this lock primitive in SoC
with a few cores (i.e. 2) when dts allows the driver to handle several
PCM substreams and userspace applications try to use the PCM substreams
almost the same time?
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/soc/sh/rcar/core.c#n501

It's my concern since I did read your codes.


Regards

Takashi Sakamoto
