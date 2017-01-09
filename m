From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH] Revert "ASoC: core: replace aux_comp_list
 to component_dev_list"
Date: Mon, 9 Jan 2017 10:41:37 +0300
Message-ID: <979483f7-e78d-bca9-297f-ead170e658c1@cogentembedded.com>
References: <CGME20161229152622epcas4p19054a78722d5eae88c983230f457e794@epcas4p1.samsung.com>
 <1483022987-28843-1-git-send-email-nikita.yoush@cogentembedded.com>
 <061fafe6-dc46-375d-9e57-cc59115a04aa@samsung.com>
 <20170106181823.qztj4b3rhxrgljq2@sirena.org.uk>
 <CAGb2v649=7+vRK=kOqa6VEiQyZDL2kcKym_t=y-AOi=tV2zZyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f50.google.com (mail-lf0-f50.google.com
 [209.85.215.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D73B2664FB
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 08:41:40 +0100 (CET)
Received: by mail-lf0-f50.google.com with SMTP id o140so34222092lff.3
 for <alsa-devel@alsa-project.org>; Sun, 08 Jan 2017 23:41:40 -0800 (PST)
In-Reply-To: <CAGb2v649=7+vRK=kOqa6VEiQyZDL2kcKym_t=y-AOi=tV2zZyg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chris Healy <cphealy@gmail.com>
List-Id: alsa-devel@alsa-project.org

>>> I run into same issue and posted a patch:
>>
>>> "ASoC: Fix binding and probing of auxiliary components".
>>
>> Which I applied so I guess things are fine now without the revert?  I'm
>> still working through backlog from the holidays so didn't check
>> properly yet.
> 
> This fixes the Allwinner H3 codec analog controls aux_device for me.
> Thanks.

But this is not yet in 4.10-rc3 ?
