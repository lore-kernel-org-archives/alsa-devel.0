From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [alsa-devel] [PATCH] Revert "ASoC: core: replace aux_comp_list to component_dev_list"
Date: Sun, 8 Jan 2017 04:33:28 +0800
Message-ID: <CAGb2v649=7+vRK=kOqa6VEiQyZDL2kcKym_t=y-AOi=tV2zZyg@mail.gmail.com>
References: <CGME20161229152622epcas4p19054a78722d5eae88c983230f457e794@epcas4p1.samsung.com>
 <1483022987-28843-1-git-send-email-nikita.yoush@cogentembedded.com>
 <061fafe6-dc46-375d-9e57-cc59115a04aa@samsung.com> <20170106181823.qztj4b3rhxrgljq2@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170106181823.qztj4b3rhxrgljq2@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Chris Healy <cphealy@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 7, 2017 at 2:18 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Dec 29, 2016 at 05:18:21PM +0100, Sylwester Nawrocki wrote:
>
>> I run into same issue and posted a patch:
>
>> "ASoC: Fix binding and probing of auxiliary components".
>
> Which I applied so I guess things are fine now without the revert?  I'm
> still working through backlog from the holidays so didn't check
> properly yet.

This fixes the Allwinner H3 codec analog controls aux_device for me.
Thanks.

ChenYu

>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
