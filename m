From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [alsa-devel] [PATCH] Revert
 "ASoC: core: replace aux_comp_list to component_dev_list"
Date: Thu, 29 Dec 2016 17:18:21 +0100
Message-ID: <061fafe6-dc46-375d-9e57-cc59115a04aa@samsung.com>
References: <CGME20161229152622epcas4p19054a78722d5eae88c983230f457e794@epcas4p1.samsung.com>
 <1483022987-28843-1-git-send-email-nikita.yoush@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1483022987-28843-1-git-send-email-nikita.yoush@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/29/2016 03:49 PM, Nikita Yushchenko wrote:
> This reverts commit 1a653aa44725668590b36bbe2d7fe4736a69f055 ("ASoC:
> core: replace aux_comp_list to component_dev_list").
> 
> That commit tries to remove card->aux_comp_list, using flagged entries
> in card->component_dev_list instead.
> 
> However, components are added to card->component_dev_list in
> soc_probe_component(), which is called for aux devices by
> soc_probe_aux_devices(). Before that commit, it traversed
> card->aux_comp_list and found aux devices added by soc_bind_aux_dev().
> After that commit, it traverses card->component_dev_list and finds no
> aux devices, because soc_probe_component() was not yet called for them.
> 
> Thus all aux devices are lost and any setup that needs them no longer
> works.

I think we can't simply revert that commit now, after commit

9178feb ASoC: add Component level suspend/resume
component_dev_list is also used for the component level suspend/resume,
if auxiliary devices would have been on a separate list they would be
missed in the suspend/resume sequences.

I run into same issue and posted a patch:

"ASoC: Fix binding and probing of auxiliary components".

--
Thanks,
Sylwester
