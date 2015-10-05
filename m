From: Michael Shell <list1@michaelshell.org>
Subject: Re: sysfs: cannot create duplicate filename
 '/devices/isa/sbawe.0/sound/card0/seq-oss-0-0'
Date: Mon, 5 Oct 2015 05:14:38 -0400
Message-ID: <20151005051438.a6a9de5eda0631b18d8d0814@michaelshell.org>
References: <20151004011238.3759486f630c6605dd5c7d4d@michaelshell.org>
 <s5h8u7id5i7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.supercp.com (barracuda.supercp.com [216.234.124.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 3627626044B
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 11:06:07 +0200 (CEST)
Received: from a2s43.a2hosting.com (a2s43.a2hosting.com [216.119.133.66]) by
 barracuda.supercp.com with ESMTP id Ld9rafD1Sg3VFLbs for
 <alsa-devel@alsa-project.org>; Mon, 05 Oct 2015 05:06:05 -0400 (EDT)
In-Reply-To: <s5h8u7id5i7.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 04 Oct 2015 17:21:04 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> -	if (snd_seq_device_new(emu->card, 0, SNDRV_SEQ_DEV_ID_OSS,
> +	if (snd_seq_device_new(emu->card, 1, SNDRV_SEQ_DEV_ID_OSS,


   Takashi,

Confirmed to work under 4.2.2. No more dmesg error messages and midi
playback is operating normally.


   Thank you for you help,

   Mike


PS: In the future, is there any recommended systematic way to
find out which drivers are conflicting with regard to this
type of problem? The last/error one is easy, but how would
we find out which one registered before it?
