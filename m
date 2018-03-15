From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: alsalib and snd_pcm_hw_params_set_rate_minmax
Date: Thu, 15 Mar 2018 20:59:46 +0900
Message-ID: <084894a2-8107-05ab-6f6c-7418c505f3c4@sakamocchi.jp>
References: <8f76589f-d64f-e6c2-db4a-57319e68ec3d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 68242267252
 for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2018 12:59:53 +0100 (CET)
In-Reply-To: <8f76589f-d64f-e6c2-db4a-57319e68ec3d@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

On Mar 15 2018 19:45, Oleksandr Andrushchenko wrote:
> Is it possible for user-space to reduce configuration space
> with snd_pcm_hw_params_set_rate_minmax and then change it
> with another snd_pcm_hw_params_set_rate_minmax with values
> out of the reduced config?
> 
> For example, the initial min/max is 44100/48000 and I set 44100
> first, e.g.
> 
> snd_pcm_hw_params_set_rate_minmax(handle, hw_params, 44100, 0, 44100, 0)
> 
> and then want
> 
> snd_pcm_hw_params_set_rate_minmax(handle, hw_params, 48000, 0, 48000, 0)
> 
> Obviously, the last call fails as we have already a reduced
> space of [44100; 44100].
> 
> Is there a way I can still set the range to [48000; 48000]?
> 
> Thank you,
> Oleksandr
> 
> P.S. This is in context of work done for [1]
> 
> [1] https://www.spinics.net/lists/alsa-devel/msg75382.html

We can't. Once shrinking available interval of a parameter, we cannot
expand it again without initializing the parameter on memory object for
'struct snd_pcm_hw_params_t', in which actual layout is never disclosed
to user applications.

If you can initialize whole the parameters, snd_pcm_hw_params_any() is
available for your purpose, then set min/max rate again. But just for
one of the parameters, in my opinion, we need to open an internal API; 
snd_pcm_hw_param_any()[1].

[1] 
http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/pcm/pcm_params.c;h=608a2324cb268f84d91f67c53d979521678f4edb;hb=HEAD#l107


Regards

Takashi Sakamoto
