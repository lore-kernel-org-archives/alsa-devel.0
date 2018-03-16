From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: alsalib and snd_pcm_hw_params_set_rate_minmax
Date: Fri, 16 Mar 2018 08:50:02 -0400
Message-ID: <20180316125002.GA10870@char.us.oracle.com>
References: <8f76589f-d64f-e6c2-db4a-57319e68ec3d@gmail.com>
 <084894a2-8107-05ab-6f6c-7418c505f3c4@sakamocchi.jp>
 <9cf1073b-97ec-a3f5-a08a-5c54f5d92c4a@gmail.com>
 <s5ho9jp79s7.wl-tiwai@suse.de>
 <d17e2fdd-d316-8bd7-351c-9e0446adafc1@gmail.com>
 <s5hefkl6q1s.wl-tiwai@suse.de>
 <43fb1d82-60e3-37af-961b-5d8819bf3cef@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AA25267380
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 13:50:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <43fb1d82-60e3-37af-961b-5d8819bf3cef@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

.snip..
> All seem to work now when I pass all 5 parameters while querying.
> The only scary thing is that I had to change the size of
> requests/responses in the sndif protocol from 32 to 64 bytes :(

Oh boy. Well, are there any other users beside your code? In which case we could
just sweep it under the rug and pretend we never had it at 32 bytes.

> 
> Takashi, could you please have a quick look and tell me if
> this is what you expect?
> > 
> > thanks,
> > 
> > Takashi
> Thank you,
> Oleksandr
> 
> [1] https://github.com/andr2000/linux/commits/tiwai_sound_for_next_pv_snd_upstream_v2
> [2] https://github.com/andr2000/xen/commits/pr_sndif_v3
> [3] https://github.com/andr2000/snd_be/commits/pr_hw_param
