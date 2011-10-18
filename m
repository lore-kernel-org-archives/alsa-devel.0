From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: ad193x: Use snd_soc_update_bits for read-modify-write
Date: Tue, 18 Oct 2011 11:23:02 +0800
Message-ID: <CAGsJ_4xNAwyZcPkD-NQwF7Z=GzNPHAqDsBUteww4khWuuQv0jw@mail.gmail.com>
References: <1318582919.19976.1.camel@phoenix> <1318582987.19976.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1318582987.19976.2.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/10/14 Axel Lin <axel.lin@gmail.com>:
> Use snd_soc_update_bits for read-modify-write register access instead=
 of
> open-coding it using snd_soc_read and snd_soc_write
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Barry Song <21cnbao@gmail.com>

and fix the changelog as Mark pointed out.

> ---
> =C2=A0sound/soc/codecs/ad193x.c | =C2=A0 25 ++++++++++++-------------
> =C2=A01 files changed, 12 insertions(+), 13 deletions(-)
>

-barry
